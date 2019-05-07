//
//  OthersMainPageViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/27.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "OthersMainPageViewController.h"
#import "OthersIDView.h"
#import "WorksView.h"
#import "GlobalDefine.h"
#import "OriginalWorksViewController.h"
#import "CandyFansViewController.h"
#import "JJPageInfo.h"
#import "HttpRequestUtil.h"
#import "JJCacheUtil.h"


#define USERVIEW_WIDTH self.view.frame.size.width
#define USERVIEW_HEIGHT self.view.frame.size.height
#define DETAIL_INFO_VIEW_HEIGHT 300.0f

static int jjWorkPageSize = 6;

@interface OthersMainPageViewController ()<OthersIDInfoViewDelegate, WorksViewDelegate>

@property (strong, nonatomic) OthersIDView *othersIDView;
@property (strong, nonatomic) WorksView *workView;

@property (copy, nonatomic) NSString *fansId;
@property (strong, nonatomic) UIImage *avaterImg;
@property (copy, nonatomic) NSString *nikeName;
@property (assign) BOOL hasFocused;
@property (assign) BOOL isYourself;
@property (copy, nonatomic) NSArray *fansList;
@property (strong, nonatomic) JJPageInfo *currentPageInfo;
@property (strong, nonatomic) NSMutableArray *worksDataSource;
@property (strong, nonatomic) HomeCubeModel *userInfo;

@end

@implementation OthersMainPageViewController
@synthesize othersIDView = _othersIDView;
@synthesize workView = _workView;
@synthesize fansId = _fansId;
@synthesize avaterImg = _avaterImg;
@synthesize nikeName = _nikeName;
@synthesize fansList = _fansList;
@synthesize currentPageInfo = _currentPageInfo;
@synthesize worksDataSource = _worksDataSource;
@synthesize userInfo = _userInfo;
@synthesize hasFocused = _hasFocused;
@synthesize isYourself = _isYourself;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    [self.view addSubview:self.othersIDView];
    [self.view addSubview:self.workView];
    
    // 作品数据
    self.worksDataSource = [[NSMutableArray alloc] init];
    // 获取用户数据
    [self requestUserInfo];
}

- (void)setUserZone:(HomeCubeModel *)zoneInfo{
    self.userInfo = zoneInfo;
    self.fansId = self.userInfo.userid;
    NSString *avatar = self.userInfo.iconUrl;
    [JJCacheUtil diskImageExistsWithUrl:avatar completion:^(UIImage *image) {
        self.avaterImg = image;
    }];
    self.nikeName = self.userInfo.name;
    self.hasFocused = self.userInfo.hasFocused;
    self.isYourself = self.userInfo.isYourWork;
}

- (void)setFansModel:(FansModel *)fansModel{
    self.fansId = fansModel.userId;
    self.nikeName = fansModel.userName;
    NSString *avatar = fansModel.iconUrl;
    [JJCacheUtil diskImageExistsWithUrl:avatar completion:^(UIImage *image) {
        self.avaterImg = image;
    }];
}

-(OthersIDView *)othersIDView{
    if(!_othersIDView){
        _othersIDView = [[OthersIDView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, DETAIL_INFO_VIEW_HEIGHT)];
        _othersIDView.delegate = self;
    }
    return _othersIDView;
}

/**
 发布作品试图
 
 @return 发布作品试图
 */
- (WorksView *)workView{
    if(!_workView){
        _workView = [[WorksView alloc] initWithFrame:CGRectMake(0, DETAIL_INFO_VIEW_HEIGHT + 10.0f, self.view.frame.size.width, self.view.frame.size.height - DETAIL_INFO_VIEW_HEIGHT - 10.0f)];
        _workView.delegate = self;
    }
    return _workView;
}

/**
 获取用户信息
 */
- (void)requestUserInfo{
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_GetOthersWorksArray:OTHERS_DATA_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID fansid:self.fansId pageIndex:[NSString stringWithFormat:@"0"] pageSize:[NSString stringWithFormat:@"%d", jjWorkPageSize] callback:^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            [self.workView.worksCollection.mj_header endRefreshing];
            [self.workView.worksCollection.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return ;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"0"]){
            if([[data objectForKey:@"errorCode"] isEqualToString:@"1008"]){
                [SVProgressHUD showErrorWithStatus:JJ_LOGININFO_EXPIRED];
                [SVProgressHUD dismissWithDelay:1.0f];
                return;
            }
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        // 用户信息
        NSString *fans = [data objectForKey:@"fans"];
        NSString *likesCount = [data objectForKey:@"likesCount"];
        NSArray *nFansList = [data objectForKey:@"fansList"];
        weakSelf.fansList = nFansList;
        weakSelf.hasFocused = [[data objectForKey:@"hasFocused"] boolValue];
        
        NSArray *works = [[data objectForKey:@"works"] copy];
        NSMutableArray *photoList = [[NSMutableArray alloc] init];
        for(int i = 0; i < [works count]; i++){
            NSDictionary *dic = [works objectAtIndex:i];
            NSString *userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userid"]];
            NSString *photoId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"photoid"]];
            NSString *pathStr = [dic objectForKey:@"path"];
            NSString *postTime = [dic objectForKey:@"postTime"];
            NSString *work = [dic objectForKey:@"work"];
            NSString *likeNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeNum"]];
            NSArray *photos = [pathStr componentsSeparatedByString:@"|"];
            
            Works *postWork = [[Works alloc] initWithPath:photos photoID:photoId userid:userId work:work time:postTime like:likeNum];
            [photoList addObject:postWork];
        }
        
        // 当前页
        int currentPage = [[data objectForKey:@"currentPage"] intValue];
        int totalPages = [[data objectForKey:@"totalPages"] intValue];
        JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:totalPages size:jjWorkPageSize currentPage:currentPage];
        
        NSString *postCount = [NSString stringWithFormat:@"%lu", (unsigned long)[photoList count]];
        [weakSelf refreshViewInfo:weakSelf.avaterImg nickname:weakSelf.nikeName postCount:postCount fans:fans likes:likesCount posts:photoList pageInfo:pageInfo hasFocused:weakSelf.hasFocused];
    }];
}

/**
 获取更多用户信息
 */
- (void)loadMoreUserInfo:(int)page size:(int)pageSize{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_GetOthersWorksArray:OTHERS_DATA_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID fansid:self.fansId pageIndex:[NSString stringWithFormat:@"%d", page] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
        if(error){
            [self.workView.worksCollection.mj_header endRefreshing];
            [self.workView.worksCollection.mj_footer endRefreshing];
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return ;
        }
        
        if([[data objectForKey:@"result"] isEqualToString:@"0"]){
            if([[data objectForKey:@"errorCode"] isEqualToString:@"1008"]){
                [SVProgressHUD showErrorWithStatus:JJ_LOGININFO_EXPIRED];
                [SVProgressHUD dismissWithDelay:1.0f];
                return;
            }
            [SVProgressHUD showErrorWithStatus:JJ_PULLDATA_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return;
        }
        
        // 用户信息
        NSString *fans = [data objectForKey:@"fans"];
        NSString *likesCount = [data objectForKey:@"likesCount"];
        NSArray *nFansList = [data objectForKey:@"fansList"];
        weakSelf.fansList = nFansList;
        weakSelf.hasFocused = [[data objectForKey:@"hasFocused"] boolValue];
        
        NSArray *works = [[data objectForKey:@"works"] copy];
        NSMutableArray *photoList = [[NSMutableArray alloc] init];
        for(int i = 0; i < [works count]; i++){
            NSDictionary *dic = [works objectAtIndex:i];
            NSString *userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userid"]];
            NSString *photoId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"photoid"]];
            NSString *pathStr = [dic objectForKey:@"path"];
            NSString *postTime = [dic objectForKey:@"postTime"];
            NSString *work = [dic objectForKey:@"work"];
            NSString *likeNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeNum"]];
            NSArray *photos = [pathStr componentsSeparatedByString:@"|"];
            
            Works *postWork = [[Works alloc] initWithPath:photos photoID:photoId userid:userId work:work time:postTime like:likeNum];
            [photoList addObject:postWork];
        }
        
        // 当前页
        int currentPage = [[data objectForKey:@"currentPage"] intValue];
        int totalPages = [[data objectForKey:@"totalPages"] intValue];
        JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:totalPages size:jjWorkPageSize currentPage:currentPage];
        
        NSString *postCount = [NSString stringWithFormat:@"%lu", (unsigned long)[photoList count]];
        [weakSelf refreshViewInfo:weakSelf.avaterImg nickname:weakSelf.nikeName postCount:postCount fans:fans likes:likesCount posts:photoList pageInfo:pageInfo hasFocused:weakSelf.hasFocused];
    }];
}

/**
 刷新用户界面
 */
- (void)refreshViewInfo:(UIImage *)avater nickname:(NSString *)name postCount:(NSString *)postCount fans:(NSString *)fans likes:(NSString *)likes posts:(NSMutableArray *)posts pageInfo:(JJPageInfo *)pageInfo hasFocused:(BOOL)hasFocused{
    
    // 基本信息
    [self.othersIDView updateViewInfo:avater name:name worksCount:postCount fans:fans likes:likes hasFocused:hasFocused isSelf:self.isYourself];
    
    if(pageInfo.currentPage == 0){
        [self.workView.worksCollection.mj_header endRefreshing];
        [self.workView.worksCollection.mj_footer endRefreshing];
        [_worksDataSource removeAllObjects];
    }
    
    [self.workView.worksCollection.mj_header endRefreshing];
    [self.workView.worksCollection.mj_footer endRefreshing];
    
    _currentPageInfo = pageInfo;
    [_worksDataSource addObjectsFromArray:[posts copy]];
    [self.workView updateWorksArray:_worksDataSource];
}

#pragma mark - OthersIDInfoViewDelegate                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
- (void)showFansListCallback{
    CandyFansViewController *fansView = [CandyFansViewController new];
    [fansView setShowTitle:@"粉丝"];
    [fansView setCandyFansList:[NSMutableArray arrayWithArray:self.fansList]];
    [self.navigationController pushViewController:fansView animated:YES];
}

- (void)focusHerCandy:(UIButton *)sender{
    [self.userInfo setHasFocused:sender.selected];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoFocus:) object:sender];
    [self performSelector:@selector(toDoFocus:) withObject:sender afterDelay:0.2f];
}

- (void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WorksViewDelegate
- (void)goToWorksDetailViewCallback:(Works *)work{
    OriginalWorksViewController *origialWorksView = [OriginalWorksViewController new];
    [origialWorksView setWorksInfo:work];
    [self.navigationController pushViewController:origialWorksView animated:YES];
}

- (void)worksUpPullFreshDataCallback{
    if(_currentPageInfo.currentPage + 1 > _currentPageInfo.totalPage){
        [self.workView.worksCollection.mj_footer setState:MJRefreshStateNoMoreData];
        [self.workView.worksCollection.mj_footer endRefreshing];
    }else{
        [self loadMoreUserInfo:_currentPageInfo?_currentPageInfo.currentPage + 1:0 size:jjWorkPageSize];
    }
}

// 关注
- (void)toDoFocus:(UIButton *)sender{
    if (sender.selected) {
        // 已关注
        [HttpRequestUtil JJ_BeginFocus:START_FOCUS_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID focusObj:self.fansId callback:^(NSDictionary *data, NSError *error) {
            if(error){
                return ;
            }
        }];
    } else {
        // 未关注
        [HttpRequestUtil JJ_CancelFocus:CANCEL_FOCUS_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID focusObj:self.fansId callback:^(NSDictionary *data, NSError *error) {
            if(error){
                return ;
            }
        }];
    }
}

@end
