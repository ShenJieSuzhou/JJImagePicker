//
//  CommentView.m
//  CommectProj
//
//  Created by shenjie on 2019/8/6.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "CommentView.h"
#import "NSDate+Extension.h"
#import <MJRefresh/MJRefresh.h>
#import "JJTopicManager.h"
#import "HttpRequestUtil.h"
#import <SVProgressHUD.h>
#import "GlobalDefine.h"
#import "HttpRequestUrlDefine.h"
#import "JJTokenManager.h"
#import "JJDetailsInfoFooterView.h"

@implementation CommentView
@synthesize  commentTableView = _commentTableView;
@synthesize selecteTopicFrame = _selecteTopicFrame;
@synthesize commentInputView = _commentInputView;
@synthesize commentContainerV = _commentContainerV;
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize currentPageInfo = _currentPageInfo;
@synthesize cubeModel = _cubeModel;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (id)init{
    return [self initWithFrame:CGRectZero];
}


- (void)show{
    [self commonInitlization];
}

- (void)commonInitlization{
    self.dataSource = [NSMutableArray new];

    [self addSubview:self.commentTableView];
    [self addSubview:self.commentContainerV];
    
    // 放到前面来
    [self.commentContainerV bringSubviewToFront:self.commentTableView];
    
    [self.commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.commentContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(50.0f);
    }];
    
    // 请求数据
    JJWorksFrame *workFrame = [[JJWorksFrame alloc] init];
    [workFrame setWorkModel:_cubeModel];
    [_dataSource insertObject:workFrame atIndex:0];
    [self loadComments:0 pageSize:10];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

/**
 首次加载评论

 @param pageIndex 索引
 @param pageSize 总数
 */
- (void)loadComments:(int)pageIndex pageSize:(int)pageSize{
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [HttpRequestUtil JJ_PullComments:QUERY_COMMENT_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID photoId:self.cubeModel.photoId pageIndex:[NSString stringWithFormat:@"%d", pageIndex] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        if(!data){
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"1"]){
            [SVProgressHUD dismiss];
            // 分页数据
            NSDictionary *page = [data objectForKey:@"page"];
            // 当前页
            int currentPage = [[page objectForKey:@"currentPage"] intValue];
            int totalPages = [[page objectForKey:@"totalPage"] intValue];
            JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:totalPages size:10 currentPage:currentPage];
            
            // 解析数据
            NSMutableArray *topicFrames = [[NSMutableArray alloc] init];
            NSArray *topics = [data objectForKey:@"topics"];
            for(int i = 0; i < [topics count]; i++){
                NSDictionary *topicTemp = [topics objectAtIndex:i];
                NSInteger commentsCount = [[topicTemp objectForKey:@"commentsCount"] intValue];
                NSString *createTime = [topicTemp objectForKey:@"createTime"];
                BOOL isLike = [[topicTemp objectForKey:@"islike"] boolValue];
                NSInteger likeNums = [[topicTemp objectForKey:@"likeNums"] intValue];
                NSString *content = [topicTemp objectForKey:@"text"];
                NSInteger topicId = [[topicTemp objectForKey:@"topicID"] intValue];
                // 用户信息
                NSDictionary *userDic = [topicTemp objectForKey:@"user"];
                NSString *avatarUrl = [userDic objectForKey:@"avatarUrl"];
                NSString *nickName = [userDic objectForKey:@"nickName"];
                NSInteger uerId = [[userDic objectForKey:@"uerId"] intValue];
                
                JJUser *user = [[JJUser alloc] init];
                user.userId =[NSString stringWithFormat:@"%ld", (long)uerId];
                user.nickname = nickName;
                user.avatarUrl = avatarUrl;
                
                JJTopic *topic = [[JJTopic alloc] init];
                topic.topicID = [NSString stringWithFormat:@"%ld", (long)topicId];
                topic.likeNums = likeNums;
                topic.like = isLike;
                topic.createTime = createTime;
                topic.text = content;
                topic.user = user;
                topic.commentsCount = commentsCount;
                
                // 添加到数据源中
                [topicFrames addObject:[weakSelf topicFrameWithTopic:topic]];
            }
            
            [weakSelf latestInfoRequestCallBack:pageInfo commemtList:topicFrames];
            
        }else{
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
        }
    }];
}


/**
 加载更多评论

 @param pageIndex 索引
 @param pageSize 总数
 */
- (void)loadMoreComments:(int)pageIndex pageSize:(int)pageSize{
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
     [HttpRequestUtil JJ_PullComments:QUERY_COMMENT_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID photoId:self.cubeModel.photoId pageIndex:[NSString stringWithFormat:@"%d", pageIndex] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        if(!data){
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"1"]){
            [SVProgressHUD dismiss];
            // 分页数据
            NSDictionary *page = [data objectForKey:@"page"];
            // 当前页
            int currentPage = [[page objectForKey:@"currentPage"] intValue];
            int totalPages = [[page objectForKey:@"totalPage"] intValue];
            JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:totalPages size:10 currentPage:currentPage];
            
            // 解析数据
            NSMutableArray *topicFrames = [[NSMutableArray alloc] init];
            NSArray *topics = [data objectForKey:@"topics"];
            for(int i = 0; i < [topics count]; i++){
                NSDictionary *topicTemp = [topics objectAtIndex:i];
                NSInteger commentsCount = [[topicTemp objectForKey:@"commentsCount"] intValue];
                NSString *createTime = [topicTemp objectForKey:@"createTime"];
                BOOL isLike = [[topicTemp objectForKey:@"islike"] boolValue];
                NSInteger likeNums = [[topicTemp objectForKey:@"likeNums"] intValue];
                NSString *content = [topicTemp objectForKey:@"text"];
                NSInteger topicId = [[topicTemp objectForKey:@"topicID"] intValue];
                // 用户信息
                NSDictionary *userDic = [topicTemp objectForKey:@"user"];
                NSString *avatarUrl = [userDic objectForKey:@"avatarUrl"];
                NSString *nickName = [userDic objectForKey:@"nickName"];
                NSInteger uerId = [[userDic objectForKey:@"uerId"] intValue];
                
                JJUser *user = [[JJUser alloc] init];
                user.userId =[NSString stringWithFormat:@"%ld", (long)uerId];
                user.nickname = nickName;
                user.avatarUrl = avatarUrl;
                
                JJTopic *topic = [[JJTopic alloc] init];
                topic.topicID = [NSString stringWithFormat:@"%ld", (long)topicId];
                topic.likeNums = likeNums;
                topic.like = isLike;
                topic.createTime = createTime;
                topic.text = content;
                topic.user = user;
                topic.commentsCount = commentsCount;
                
                // 添加到数据源中
                [topicFrames addObject:[weakSelf topicFrameWithTopic:topic]];
            }
            
            [weakSelf latestInfoRequestCallBack:pageInfo commemtList:topicFrames];
            
        }else{
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
        }
    }];
}


- (JJTopicFrame *)topicFrameWithTopic:(JJTopic *)topic{
    if(topic.commentsCount > 0){
        JJComment *comment = [[JJComment alloc] init];
        comment.commentId = @"ALLCOMMENT";
        comment.text = [NSString stringWithFormat:@"查看全部%zd条回复", topic.commentsCount];
        [topic.replayComments addObject:comment];
    }
    
    JJTopicFrame *topicFrame = [[JJTopicFrame alloc] init];
    topicFrame.topic = topic;
    return topicFrame;
}

- (void)latestInfoRequestCallBack:(JJPageInfo *)pageInfo commemtList:(NSMutableArray *)photoList{
    
    if(pageInfo.currentPage == 0){
        [self.commentTableView.mj_header endRefreshing];
        [self.commentTableView.mj_footer endRefreshing];
//        [_dataSource removeAllObjects];
    }

    [self.commentTableView.mj_header endRefreshing];
    [self.commentTableView.mj_footer endRefreshing];

    _currentPageInfo = pageInfo;
    [_dataSource addObjectsFromArray:[photoList copy]];
    [self.commentTableView reloadData];
}

#pragma mark - 添加通知中心
- (void)_addNotificationCenter
{
    // 视频评论成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentSuccess:) name:JJCommentSuccessNotification object:nil];
    
    // 视频评论回复成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentReplySuccess:) name:JJCommentReplySuccessNotification object:nil];
    
    // 视频点赞成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeSuccess:) name:JJLikeSuccessNotification object:nil];
}


#pragma mark - 通知事件处理
// 评论成功
- (void)commentSuccess:(NSNotification *)note{

}

// 评论回复成功
- (void)commentReplySuccess:(NSNotification *)note{
    
}

// 话题点赞成功
- (void)likeSuccess:(NSNotificationCenter *)note{

}

- (UITableView *)commentTableView{
    if(!_commentTableView){
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        _commentTableView.backgroundColor = [UIColor whiteColor];
        _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        _commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downPullFreshData:)];
        _commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upPullFreshData:)];
    }
    
    return _commentTableView;
}

- (JJCommentInputView *)commentInputView{
    if(!_commentInputView){
        _commentInputView = [[JJCommentInputView alloc] initWithFrame:CGRectZero];
        _commentInputView.delegate = self;
    }
    return _commentInputView;
}

- (JJCommentContainerView *)commentContainerV{
    if(!_commentContainerV){
        _commentContainerV = [[JJCommentContainerView alloc] initWithFrame:CGRectZero];
        _commentContainerV.delegate = self;
        [_commentContainerV setCommentCount:100];
    }
    return _commentContainerV;
}

//// 上拉刷新
//- (void)downPullFreshData:(MJRefreshHeader *)mjHeader{
//    [self.commentTableView.mj_header endRefreshing];
////    [self.commentTableView reloadData];
//    [self loadComments:0 pageSize:10];
//}

// 下拉刷新
- (void)upPullFreshData:(MJRefreshFooter *)mjFooter{
    if(_currentPageInfo.currentPage + 1 >= _currentPageInfo.totalPage){
        [self.commentTableView.mj_footer setState:MJRefreshStateNoMoreData];
        [self.commentTableView.mj_footer endRefreshing];
    }else{
        [self loadMoreComments:_currentPageInfo ? _currentPageInfo.currentPage + 1 : 0 pageSize:10];
    }
}

// 回复评论
- (void)replyCommentWithCommentReply:(JJCommentReplay *)commentReply{
    JJCommentInputView *inputView = [[JJCommentInputView alloc] initWithFrame:CGRectZero];
    inputView.commentReply = commentReply;
    inputView.delegate = self;
    [inputView show];
}

#pragma mark - JJCommentInputViewDelegate
- (void)commentInputView:(JJTopic *)topic{
    topic.postId = self.cubeModel.photoId;
    topic.topicID = [NSString stringWithFormat:@"%ld", (long)[self mh_randomNumber:1 to:10000]];
    
    JJTopicFrame *topicFrame = [self topicFrameWithTopic:topic];
    [self.dataSource insertObject:topicFrame atIndex:1];
    
    // 发送请求
    [HttpRequestUtil JJ_SubmitComment:SUBMIT_COMMENT_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID photoId:topic.postId fromUserId:[JJTokenManager shareInstance].getUserID content:topic.text callback:^(NSDictionary *data, NSError *error) {
        
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        if(!data){
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"1"]){
            [SVProgressHUD showSuccessWithStatus:JJ_COMMENT_SUCCESS];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
    }];
    
    [self.commentTableView reloadData];
}

#pragma mark - JJCommentContainerViewDelegate
-(void)commentContaninerBtnClickAction:(JJCommentContainerView *)commentContainerView{
    JJCommentInputView *inputView = [[JJCommentInputView alloc] initWithFrame:CGRectZero];
    inputView.delegate = self;
    [inputView setCacheTopicText];
    [inputView show];
}

- (NSInteger) mh_randomNumber:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

#pragma mark - tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.dataSource[indexPath.section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        JJCommentFrame *commentFrame = topicFrame.commentFrames[indexPath.row];
        return commentFrame.cellHeight;
    }
    
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    id model = self.dataSource[section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        return topicFrame.height;
    }else if([model isKindOfClass:[JJWorksFrame class]]){
        JJWorksFrame *workFrame = (JJWorksFrame *)model;
        return workFrame.height;
    }
    
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    id model = self.dataSource[section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        return topicFrame.commentFrames.count > 0 ? JJTopicVerticalSpace:JJGlobalBottomLineHeight;
    }else{
        return 70.0f;
    }
    
    return .1f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    id model = self.dataSource[section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicHeaderView *headerView = [JJTopicHeaderView headerViewWithTableView:tableView];
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        headerView.topicFrame = topicFrame;
        headerView.delegate = self;
        return headerView;
    }else if([model isKindOfClass:[JJWorksFrame class]]){
        JJWorksFrame *workFrame = (JJWorksFrame *)model;
        JJDetailsInfoHeaderView *headerView = [JJDetailsInfoHeaderView headerViewWithTableView:tableView];
        headerView.workFrame = workFrame;
        headerView.delegate = self;
        
        return headerView;
    }
    
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    id model = self.dataSource[section];
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicFooterView *footerView = [JJTopicFooterView footerViewWithTableView:tableView];
        [footerView setSection:section allSections:self.dataSource.count];
        return footerView;
    }else if([model isKindOfClass:[JJWorksFrame class]]){
        JJDetailsInfoFooterView *footerView = [JJDetailsInfoFooterView footerViewWithTableView:tableView];
        
        return footerView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id model = self.dataSource[indexPath.section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        JJCommentFrame *commentFrame = topicFrame.commentFrames[indexPath.row];
        self.selecteTopicFrame = topicFrame;
        
        if([commentFrame.comment.commentId isEqualToString:@"ALLCOMMENT"]){
            // 跳转到更多评论
            [_delegate jumpToCommemtDetailView:topicFrame];
            return;
        }
        
        //回复自己则忽略
        if([commentFrame.comment.fromUser.userId isEqualToString:[JJTokenManager shareInstance].getUserID]){
            return;
        }
        
        //回复评论
        JJCommentReplay *commentReply = [[JJTopicManager shareInstance] commentReplyWithModel:commentFrame.comment];
        [self replyCommentWithCommentReply:commentReply];
    }
}


#pragma mark - tableviewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    id model = self.dataSource[section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        return topicFrame.commentFrames.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.dataSource[indexPath.section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJCommentCell *cell = [JJCommentCell cellWithTableView:tableView];
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        JJCommentFrame *commentFrame = topicFrame.commentFrames[indexPath.row];
        cell.commentFrame = commentFrame;
        cell.delegate = self;
        return cell;
    }

    return nil;
}



#pragma mark - JJTopicHeaderViewDelegate
- (void)topicHeaderViewDidClickedTopicContent:(JJTopicHeaderView *)topicHeaderView{
    self.selecteTopicFrame = topicHeaderView.topicFrame;
    JJCommentReplay *commentReply = [[JJTopicManager shareInstance] commentReplyWithModel:topicHeaderView.topicFrame.topic];
    [self replyCommentWithCommentReply:commentReply];
}

/** 点击头像或昵称的事件回调 */
- (void)topicHeaderViewDidClickedUser:(JJTopicHeaderView *)topicHeaderView{
    
}

/** 用户点击更多按钮 */
- (void)topicHeaderViewForClickedMoreAction:(JJTopicHeaderView *)topicHeaderView{
    
}

/** 用户点击点赞按钮 */
- (void)topicHeaderViewForClickedLikeAction:(JJTopicHeaderView *)topicHeaderView{
    
}

#pragma mark - JJDetailsInfoViewDelegate
- (void)goToUserZone{
    [_delegate goToUserZoneInViewController];
}

- (void)pullToBlackList{
    [_delegate pullToBlackListInViewController];
}

@end
