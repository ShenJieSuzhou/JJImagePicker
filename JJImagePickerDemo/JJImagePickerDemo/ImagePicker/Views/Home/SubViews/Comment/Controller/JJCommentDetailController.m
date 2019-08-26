//
//  JJCommentDetailController.m
//  CommectProj
//
//  Created by shenjie on 2019/8/13.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJCommentDetailController.h"
#import "JJCommentInputView.h"
#import "JJTopicHeaderView.h"
#import "JJTopicFooterView.h"
#import "JJCommentCell.h"
#import "JJTopicManager.h"
#import <MJRefresh.h>
#import <Masonry.h>
#import "JJCommentContainerView.h"
#import "UIView+JJFrame.h"
#import <SVProgressHUD.h>

@interface JJCommentDetailController ()<UITableViewDelegate, UITableViewDataSource, JJTopicHeaderViewDelegate, JJCommentContainerViewDelegate, JJCommentInputViewDelegate, JJCommentCellDelegate>

// 评论表
@property (nonatomic, strong) UITableView *tableView;

// 评论数据
@property (nonatomic, strong) NSMutableArray *dataSource;

// 底部输入框
@property (nonatomic, strong) JJCommentContainerView *commentContainer;

// 输入框
@property (nonatomic, strong) JJCommentInputView *commentInputView;

// 点赞按钮
@property (nonatomic, strong) UIButton *likeBtn;


@end

@implementation JJCommentDetailController
@synthesize currentPageInfo = _currentPageInfo;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 标题
    self.title = @"全部回复";
    self.dataSource = [NSMutableArray new];
    
    // 初始化
    [self setUpSubViews];
    
    // 加载数据
    [self loadReplys:0 size:10];
}

- (void)setUpSubViews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer = footer;
    
    // 获取模型
    JJTopicHeaderView *headerView = [JJTopicHeaderView topicHeaderView];
    headerView.delegate = self;
    headerView.topicFrame = self.topicFrame;
    headerView.jj_height = self.topicFrame.height;
    // header
    self.tableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.commentContainer];
    // 放到前面来
    [self.commentContainer bringSubviewToFront:self.tableView];
}


- (void)setTopicFrame:(JJTopicFrame *)topicFrame{
    _topicFrame = topicFrame;
}

- (JJCommentContainerView *)commentContainer{
    if(!_commentContainer){
        _commentContainer = [[JJCommentContainerView alloc] initWithFrame:CGRectZero];
        _commentContainer.delegate = self;
        [_commentContainer setCommentCount:100];
    }
    return _commentContainer;
}

- (void)loadReplys:(int)pageIndex size:(int)size{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_PullReplys:QUERY_REPLY_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID commentId:_topicFrame.topic.topicID pageIndex:[NSString stringWithFormat:@"%d", pageIndex] pageSize:[NSString stringWithFormat:@"%d", size] callback:^(NSDictionary *data, NSError *error) {
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
            NSMutableArray *commentFrames = [[NSMutableArray alloc] init];
            NSArray *replys = [data objectForKey:@"replys"];
            for (int i = 0; i < replys.count; i++) {
                NSDictionary *replyInfo = [replys objectAtIndex:i];
                NSString *createTime = [replyInfo objectForKey:@"createTime"];
                NSString *content = [replyInfo objectForKey:@"text"];
                NSInteger commentID = [[replyInfo objectForKey:@"commentID"] intValue];
                NSInteger replyID = [[replyInfo objectForKey:@"replyID"] intValue];
                // 用户信息
                NSDictionary *toUserDic = [replyInfo objectForKey:@"toUser"];
                NSString *toAvatarUrl = [toUserDic objectForKey:@"avatarUrl"];
                NSString *toNickName = [toUserDic objectForKey:@"nickName"];
                NSInteger toUserId = [[toUserDic objectForKey:@"uerId"] intValue];
                
                NSDictionary *fromUserDic = [replyInfo objectForKey:@"fromUser"];
                NSString *fromAvatarUrl = [fromUserDic objectForKey:@"avatarUrl"];
                NSString *fromNickName = [fromUserDic objectForKey:@"nickName"];
                NSInteger fromUerId = [[fromUserDic objectForKey:@"uerId"] intValue];
                
                JJUser *toUser = [[JJUser alloc] init];
                toUser.userId =[NSString stringWithFormat:@"%ld", (long)toUserId];
                toUser.nickname = toNickName;
                toUser.avatarUrl = toAvatarUrl;
                
                JJUser *fromUser = [[JJUser alloc] init];
                fromUser.userId =[NSString stringWithFormat:@"%ld", (long)fromUerId];
                fromUser.nickname = fromNickName;
                fromUser.avatarUrl = fromAvatarUrl;
                
                JJComment *comment = [[JJComment alloc] initWithPostId:[NSString stringWithFormat:@"%ld", (long)replyID] commentId:[NSString stringWithFormat:@"%ld", (long)commentID] createTime:createTime text:content toUser:toUser fromUser:fromUser];
                
                // 添加到数据源中
                JJCommentFrame *commentFrame = [[JJCommentFrame alloc] init];
                commentFrame.comment = comment;
                [commentFrames addObject:commentFrame];
            }
            [weakSelf latestInfoRequestCallBack:pageInfo commemtList:commentFrames];
        }else{
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
        }
    }];
}

- (void)loadMoreReplys:(int)pageIndex size:(int)size{
    [HttpRequestUtil JJ_PullReplys:QUERY_REPLY_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID commentId:_topicFrame.topic.topicID pageIndex:[NSString stringWithFormat:@"%d", pageIndex] pageSize:[NSString stringWithFormat:@"%d", size] callback:^(NSDictionary *data, NSError *error) {
        
        
        
    }];
}

- (void)latestInfoRequestCallBack:(JJPageInfo *)pageInfo commemtList:(NSMutableArray *)comments{
    
    if(pageInfo.currentPage == 0){
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [_dataSource removeAllObjects];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    _currentPageInfo = pageInfo;
    [_dataSource addObjectsFromArray:[comments copy]];
    [self.tableView reloadData];
}

/*
 * 加载新数据
 */
- (void)loadNewData{
    [self.tableView.mj_header endRefreshing];
    
    [self loadReplys:0 size:10];
}

/*
 * 加载新数据
 */
- (void)loadMoreData{
    [self.tableView.mj_footer endRefreshing];
    // 刷新数据
    [self loadMoreReplys:_currentPageInfo.currentPage size:10];
}

// 回复评论
- (void)replyCommentWithCommentReply:(JJCommentReplay *)commentReply{
    JJCommentInputView *inputView = [[JJCommentInputView alloc] initWithFrame:CGRectZero];
    inputView.commentReply = commentReply;
    inputView.delegate = self;
    [inputView show];
}

#pragma mark - JJCommentCellDelegate
- (void)commentCell:(JJCommentCell *)commentCell didClickUser:(id)user{
    
}

#pragma mark - JJCommentContainerViewDelegate
-(void)commentContaninerBtnClickAction:(JJCommentContainerView *)commentContainerView{
    JJCommentInputView *inputView = [[JJCommentInputView alloc] initWithFrame:CGRectZero];
    inputView.delegate = self;
    [inputView setCacheTopicText];
    [inputView show];
}

#pragma mark - JJCommentInputViewDelegate
- (void)commentInputView:(JJCommentInputView *)inputPanelView attributedText:(NSString *)attributedText{
    
}

- (void)commentInputView:(JJTopicFrame *)topicFrame{
    
}

- (void)commentInputView:(JJCommentFrame *)newCommentFrame comment:(JJComment *)comment{
    
}

#pragma mark - tableviewdelegate
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJCommentFrame *commentFrame = self.dataSource[indexPath.row];
    return commentFrame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJCommentFrame *commentFrame = self.dataSource[indexPath.row];
    return commentFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    JJCommentFrame *commentFrame = self.dataSource[indexPath.row];

    //回复自己则忽略
    //        if([commentFrame.comment.fromUser.userId isEqualToString:@"own"]){
    //            return;
    //        }

    // 回复评论
    JJCommentReplay *commentReply = [[JJTopicManager shareInstance] commentReplyWithModel:commentFrame.comment];
    [self replyCommentWithCommentReply:commentReply];
}


#pragma mark - tableviewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJCommentCell *cell = [JJCommentCell cellWithTableView:tableView];
    JJCommentFrame *commentFrame = self.dataSource[indexPath.row];
    cell.commentFrame = commentFrame;
    cell.delegate = self;
    return cell;
}

@end
