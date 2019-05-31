//
//  MeViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "MeViewController.h"
#import "DetailInfoView.h"
#import "WorksView.h"
#import "SettingViewController.h"
#import "SecurityViewController.h"
#import "JJLoginViewController.h"
#import "SettingViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "LoginSessionManager.h"
#import "HttpRequestUrlDefine.h"
#import "Works.h"
#import "JJTokenManager.h"
#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "OriginalWorksViewController.h"
#import "HttpRequestUtil.h"
#import "JJPageInfo.h"
#import "GlobalDefine.h"
#import "CandyFansViewController.h"
#import "CandyFollowerViewController.h"
#import "JJImageManager.h"
#import "PhotosViewController.h"

#define USERVIEW_WIDTH self.view.frame.size.width
#define USERVIEW_HEIGHT self.view.frame.size.height
#define DETAIL_INFO_VIEW_HEIGHT 300.0f

static int jjMyworksPageSize = 6;

@interface MeViewController ()<DetailInfoViewDelegate,LoginSessionDelegate,LoginOutDelegate,WorksViewDelegate>

@property (strong, nonatomic) DetailInfoView *detailView;
@property (strong, nonatomic) WorksView *workView;
@property (assign) BOOL isLogin;
@property (strong, nonatomic) NSMutableArray *photoDataSource;
@property (strong, nonatomic) JJPageInfo *currentPageInfo;
@property (copy, nonatomic) NSArray *fansList;
@property (copy, nonatomic) NSArray *followersList;

@end

@implementation MeViewController
@synthesize photoDataSource = _photoDataSource;
@synthesize detailView = _detailView;
@synthesize workView = _workView;
@synthesize currentPageInfo = _currentPageInfo;
@synthesize fansList = _fansList;
@synthesize followersList = _followersList;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLoginSuccess:) name:LOGINSUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publishWorksSuccess:) name:JJ_PUBLISH_WORKS_SUCCESS object:nil];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.workView];

    // 我的作品数据
    _photoDataSource = [NSMutableArray new];
    
    // 加载作品信息
    _currentPageInfo = [[JJPageInfo alloc] initWithTotalPage:0 size:jjMyworksPageSize currentPage:0];
    [self loadUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 用户信息view

 @return 用户信息视图
 */
-(DetailInfoView *)detailView{
    if(!_detailView){
        _detailView = [[DetailInfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, DETAIL_INFO_VIEW_HEIGHT)];
        _detailView.delegate = self;
    }
    return _detailView;
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

- (void)receiveLoginSuccess:(NSNotification *)notify{
    [self loadUserInfo];
}

- (void)publishWorksSuccess:(NSNotification *)notify{
    [self loadUserInfo];
}

/**
 * 获取用户数据
 */
- (void)loadUserInfo{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_GetMyWorksArray:GET_WORKS_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID pageIndex:[NSString stringWithFormat:@"0"] pageSize:[NSString stringWithFormat:@"%d", jjMyworksPageSize] callback:^(NSDictionary *data, NSError *error) {
        
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
        NSArray *nFansList = [[data objectForKey:@"fans"] copy];
        NSArray *nFollowerList = [[data objectForKey:@"followers"] copy];
        weakSelf.fansList = nFansList;
        weakSelf.followersList = nFollowerList;
        //用户作品
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
            BOOL hasLiked = [[dic objectForKey:@"hasLiked"] boolValue];
            Works *postWork = [[Works alloc] initWithPath:photos photoID:photoId userid:userId work:work time:postTime like:likeNum nickName:[JJTokenManager shareInstance].getUserName avatar:[JJTokenManager shareInstance].getUserAvatar hasLiked:hasLiked];
            [photoList addObject:postWork];
        }
        
        // 当前页
        int currentPage = [[data objectForKey:@"currentPage"] intValue];
        int totalPages = [[data objectForKey:@"totalPages"] intValue];
        JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:totalPages size:jjMyworksPageSize currentPage:currentPage];
        // 刷新
        NSString *postCount = [NSString stringWithFormat:@"%lu", (unsigned long)[photoList count]];
        [weakSelf refreshViewInfo:postCount fansNum:[nFansList count] followerNum:[nFollowerList count] pageInfo:pageInfo photoList:photoList];
    }];
}

/**
 获取更多用户信息
 */
- (void)loadMoreUserInfo:(int)page size:(int)pageSize{
    __weak typeof(self) weakSelf = self;
     [HttpRequestUtil JJ_GetMyWorksArray:GET_WORKS_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID pageIndex:[NSString stringWithFormat:@"%d", page] pageSize:[NSString stringWithFormat:@"%d", pageSize] callback:^(NSDictionary *data, NSError *error) {
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
         NSArray *nFansList = [[data objectForKey:@"fans"] copy];
         NSArray *nFollowerList = [[data objectForKey:@"followers"] copy];
         weakSelf.fansList = nFansList;
         weakSelf.followersList = nFollowerList;
         //用户作品
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
             BOOL hasLiked = [[dic objectForKey:@"hasLiked"] boolValue];
             NSArray *photos = [pathStr componentsSeparatedByString:@"|"];
             
             Works *postWork = [[Works alloc] initWithPath:photos photoID:photoId userid:userId work:work time:postTime like:likeNum nickName:[JJTokenManager shareInstance].getUserName avatar:[JJTokenManager shareInstance].getUserAvatar hasLiked:hasLiked];
             [photoList addObject:postWork];
         }
         
         // 当前页
         int currentPage = [[data objectForKey:@"currentPage"] intValue];
         int totalPages = [[data objectForKey:@"totalPages"] intValue];
         JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:totalPages size:jjMyworksPageSize currentPage:currentPage];
         // 刷新
         NSString *postCount = [NSString stringWithFormat:@"%lu", (unsigned long)[photoList count]];
         [weakSelf refreshViewInfo:postCount fansNum:[nFansList count] followerNum:[nFollowerList count] pageInfo:pageInfo photoList:photoList];
    }];
}

/**
 刷新用户界面
 */
- (void)refreshViewInfo:(NSString *)postCount fansNum:(NSUInteger)fans followerNum:(NSUInteger)followers pageInfo:(JJPageInfo *)pageInfo photoList:(NSMutableArray *)photoList{
    
    // 加载基本信息
    [self.detailView updateViewInfo:[JJTokenManager shareInstance].getUserAvatar name:[JJTokenManager shareInstance].getUserName postCount:postCount focus:[NSString stringWithFormat:@"%lu", (unsigned long)followers] fans:[NSString stringWithFormat:@"%lu", (unsigned long)fans]];
    
    if(pageInfo.currentPage == 0){
        [_workView.worksCollection.mj_header endRefreshing];
        [_workView.worksCollection.mj_footer endRefreshing];
        [_photoDataSource removeAllObjects];
    }
    
    [self.workView.worksCollection.mj_header endRefreshing];
    [self.workView.worksCollection.mj_footer endRefreshing];
    _currentPageInfo = pageInfo;
    
    [_photoDataSource addObjectsFromArray:[photoList copy]];
    [_workView updateWorksArray:_photoDataSource];
}


#pragma - mark DetailInfoViewDelegate
- (void)pickUpHeaderImgCallback{
    
}

- (void)appSettingClickCallback{
    SettingViewController *settingView = [SettingViewController new];
    settingView.delegate = self;
    [self.navigationController pushViewController:settingView animated:YES];
}

- (void)showMyFans{
    CandyFansViewController *fansView = [CandyFansViewController new];
    [fansView setShowTitle:@"粉丝"];
    [fansView setCandyFansList:[NSMutableArray arrayWithArray:self.fansList]];
    [self.navigationController pushViewController:fansView animated:YES];
}

- (void)showMyFollowers{
    CandyFollowerViewController *followerView = [CandyFollowerViewController new];
    [followerView setShowTitle:@"关注"];
    [followerView setCandyfollowersList:[NSMutableArray arrayWithArray:self.followersList]];
    [self.navigationController pushViewController:followerView animated:YES];
}

#pragma mark - loginoutCallback
- (void)userLoginOutCallBack:(SettingViewController *)viewController{
    //回到首页
    [self.navigationController pushViewController:[JJLoginViewController new] animated:YES];
}


#pragma - mark WorksViewDelegate
- (void)publishWorksCallback{
    if([JJImageManager requestAlbumPemission] == JJPHAuthorizationStatusNotAuthorized){
        //如果没有获取访问权限，或者访问权限已被明确静止，则显示提示语，引导用户开启授权
        [SVProgressHUD showWithStatus:@"请在设备的\"设置-隐私-照片\"选项中，允许访问你的手机相册"];
        [SVProgressHUD dismissWithDelay:1.0f];
    }else{
        //弹出相册选择器
        PhotosViewController *photosView = [[PhotosViewController alloc] init];
        [photosView setUpGridView:JJ_MAX_PHOTO_NUM min:0];
        //获取相机胶卷的图片
        [self.navigationController pushViewController:photosView animated:YES];
    }
}

- (void)goToWorksDetailViewCallback:(Works *)work{
    OriginalWorksViewController *origialWorksView = [OriginalWorksViewController new];
    [origialWorksView setWorksInfo:work];
    [self.navigationController pushViewController:origialWorksView animated:YES];
}

- (void)worksUpPullFreshDataCallback{
    if(_currentPageInfo.currentPage + 1 >= _currentPageInfo.totalPage){
//       [self loadMoreUserInfo:_currentPageInfo.currentPage size:jjMyworksPageSize];
        [_workView.worksCollection.mj_footer setState:MJRefreshStateNoMoreData];
        [_workView.worksCollection.mj_footer endRefreshing];
    }else{
        [self loadMoreUserInfo:_currentPageInfo?_currentPageInfo.currentPage + 1:0 size:jjMyworksPageSize];
    }
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_detailView release];
    [_workView release];
}

@end
