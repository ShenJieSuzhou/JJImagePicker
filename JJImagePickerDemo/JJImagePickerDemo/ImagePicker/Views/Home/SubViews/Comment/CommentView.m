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
#import "JJCommentDetailController.h"
#import "JJTopicManager.h"
#import "HttpRequestUtil.h"
#import <SVProgressHUD.h>
#import "GlobalDefine.h"
#import "HttpRequestUrlDefine.h"
#import "JJTokenManager.h"

@implementation CommentView
@synthesize  commentTableView = _commentTableView;
@synthesize selecteTopicFrame = _selecteTopicFrame;
@synthesize decorateHeader = _decorateHeader;
@synthesize commentInputView = _commentInputView;
@synthesize commentContainerV = _commentContainerV;
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize currentPageInfo = _currentPageInfo;
@synthesize postId = _postId;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    return self;
}


- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    self.dataSource = [NSMutableArray new];
    [self addSubview:self.decorateHeader];
    [self addSubview:self.commentTableView];
    [self addSubview:self.commentContainerV];
    // 放到前面来
    [self.commentContainerV bringSubviewToFront:self.commentTableView];
    
    // 加载数据
    [self loadComments:0 pageSize:10];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.decorateHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 25.0f));
    }];
    
    [self.commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.decorateHeader.mas_bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.commentContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(50.0f);
    }];
}


/**
 首次加载评论

 @param pageIndex 索引
 @param pageSize 总数
 */
- (void)loadComments:(int)pageIndex pageSize:(int)pageSize{
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [HttpRequestUtil JJ_PullComments:QUERY_COMMENT_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID photoId:self.postId pageIndex:[NSString stringWithFormat:@"%d", pageIndex] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
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
     [HttpRequestUtil JJ_PullComments:QUERY_COMMENT_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID photoId:self.postId pageIndex:[NSString stringWithFormat:@"%d", pageIndex] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
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
    if(topic.commentsCount > 1){
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
        [_dataSource removeAllObjects];
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
        
        _commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downPullFreshData:)];
        _commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upPullFreshData:)];
    }
    
    return _commentTableView;
}

- (JJCommentDecorateHeader *)decorateHeader{
    if(!_decorateHeader){
        _decorateHeader = [[JJCommentDecorateHeader alloc] initWithFrame:CGRectZero];
    }
    return _decorateHeader;
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

// 上拉刷新
- (void)downPullFreshData:(MJRefreshHeader *)mjHeader{
    [self.commentTableView.mj_header endRefreshing];
//    [self.commentTableView reloadData];
    [self loadComments:0 pageSize:10];
}

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
- (void)commentInputView:(JJTopicFrame *)topicFrame{
    [self.dataSource insertObject:topicFrame atIndex:0];
    [self.commentTableView reloadData];
}

- (void)commentInputView:(JJCommentFrame *)newCommentFrame comment:(JJComment *)comment{
    self.selecteTopicFrame.topic.commentsCount = self.selecteTopicFrame.topic.commentsCount + 1;
    if(self.selecteTopicFrame.topic.commentsCount > 2){
        NSInteger count = self.selecteTopicFrame.commentFrames.count;
        NSInteger index = count - 1;
        [self.selecteTopicFrame.commentFrames insertObject:newCommentFrame atIndex:index];
        [self.selecteTopicFrame.topic.replayComments insertObject:comment atIndex:index];
        
        JJComment *lastComment = self.selecteTopicFrame.topic.replayComments.lastObject;
        lastComment.text = [NSString stringWithFormat:@"查看全部%zd条回复" , self.selecteTopicFrame.topic.commentsCount];
    }else{
        if (self.selecteTopicFrame.topic.replayComments.count == 2)
        {
            // 添加数据源
            [self.selecteTopicFrame.commentFrames addObject:newCommentFrame];
            [self.selecteTopicFrame.topic.replayComments addObject:comment];
            
            // 设置假数据
            JJComment *lastComment = [[JJComment alloc] init];
            lastComment.commentId = @"ALLCOMMENT";
            lastComment.text = [NSString stringWithFormat:@"查看全部%zd条回复" , self.selecteTopicFrame.topic.commentsCount];
            JJCommentFrame *lastCommentFrame =  [[JJTopicManager shareInstance] commentFramesWithComments:@[lastComment]].lastObject;
            // 添加假数据
            [self.selecteTopicFrame.commentFrames addObject:lastCommentFrame];
            [self.selecteTopicFrame.topic.replayComments addObject:lastComment];
        }else{
            // 添加数据源
            [self.selecteTopicFrame.commentFrames addObject:newCommentFrame];
            [self.selecteTopicFrame.topic.replayComments addObject:comment];
        }
    }
    
    [self reloadSelectedSection];
}

- (void)reloadSelectedSection{
    [self.commentTableView beginUpdates];
    NSInteger index = [self.dataSource indexOfObject:self.selecteTopicFrame];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [self.commentTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self.commentTableView endUpdates];
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
    }
    
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    id model = self.dataSource[section];
    
    if([model isKindOfClass:[JJTopicFrame class]]){
        JJTopicFrame *topicFrame = (JJTopicFrame *)model;
        return topicFrame.commentFrames.count > 0 ? JJTopicVerticalSpace:JJGlobalBottomLineHeight;
    }
    
    return .1f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JJTopicHeaderView *headerView = [JJTopicHeaderView headerViewWithTableView:tableView];
    JJTopicFrame *topicFrame = self.dataSource[section];
    headerView.topicFrame = topicFrame;
    headerView.delegate = self;
    return headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    JJTopicFooterView *footerView = [JJTopicFooterView footerViewWithTableView:tableView];
    [footerView setSection:section allSections:self.dataSource.count];
    return footerView;
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
//        if([commentFrame.comment.fromUser.userId isEqualToString:@"own"]){
//            return;
//        }
        
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
    self.commentTableView.mj_footer.hidden = self.dataSource.count < JJCommentMaxCount;
    
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

- (void)topicHeaderViewDidClickedTopicContent:(JJTopicHeaderView *)topicHeaderView{
    self.selecteTopicFrame = topicHeaderView.topicFrame;
    JJCommentReplay *commentReply = [[JJTopicManager shareInstance] commentReplyWithModel:topicHeaderView.topicFrame.topic];
    [self replyCommentWithCommentReply:commentReply];
}

@end
