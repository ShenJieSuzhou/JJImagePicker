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

@end

@implementation MeViewController
@synthesize photoDataSource = _photoDataSource;
@synthesize detailView = _detailView;
@synthesize workView = _workView;
@synthesize currentPageInfo = _currentPageInfo;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLoginSuccess:) name:LOGINSUCCESS_NOTIFICATION object:nil];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.workView];
    
    // 加载基本信息
    [self.detailView updateViewInfo:[JJTokenManager shareInstance].getUserAvatar name:[JJTokenManager shareInstance].getUserName focus:[JJTokenManager shareInstance].getFocusPlayerNum fans:[JJTokenManager shareInstance].getUserFans];
    
    // 我的作品数据
    _photoDataSource = [NSMutableArray new];
    
    // 加载作品信息
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
            
            Works *postWork = [[Works alloc] initWithPath:photos photoID:photoId userid:userId work:work time:postTime like:likeNum];
            [photoList addObject:postWork];
        }
        
        // 当前页
        int currentPage = [[data objectForKey:@"currentPage"] intValue];
        JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:0 size:jjMyworksPageSize currentPage:currentPage];
        // 刷新
        [weakSelf refreshViewInfo:pageInfo photoList:photoList];
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
             
             Works *postWork = [[Works alloc] initWithPath:photos photoID:photoId userid:userId work:work time:postTime like:likeNum];
             [photoList addObject:postWork];
         }
         
         // 当前页
         int currentPage = [[data objectForKey:@"currentPage"] intValue];
         JJPageInfo *pageInfo = [[JJPageInfo alloc] initWithTotalPage:0 size:jjMyworksPageSize currentPage:currentPage];
         // 刷新
         [weakSelf refreshViewInfo:pageInfo photoList:photoList];
    }];
}

/**
 刷新用户界面
 */
- (void)refreshViewInfo:(JJPageInfo *)pageInfo photoList:(NSMutableArray *)photoList{
    
    if(pageInfo.currentPage == 0){
        [_workView.worksCollection.mj_header endRefreshing];
        [_workView.worksCollection.mj_footer endRefreshing];
    }else{
        if([photoList count] < jjMyworksPageSize){
            [_workView.worksCollection.mj_footer setState:MJRefreshStateNoMoreData];
        }
        [_workView.worksCollection.mj_footer endRefreshing];
    }
    
    _currentPageInfo = pageInfo;
    if(_currentPageInfo.currentPage == 0){
        [_photoDataSource removeAllObjects];
    }
    
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

#pragma mark - loginoutCallback
- (void)userLoginOutCallBack:(SettingViewController *)viewController{
    //回到首页
    [self.navigationController pushViewController:[JJLoginViewController new] animated:YES];
}



#pragma - mark WorksViewDelegate
- (void)publishWorksCallback{
    NSLog(@"跳转到拍照 选择相片界面");
}

- (void)goToWorksDetailViewCallback:(Works *)work{
    OriginalWorksViewController *origialWorksView = [OriginalWorksViewController new];
    [origialWorksView setWorksInfo:work];
    [self.navigationController pushViewController:origialWorksView animated:YES];
}

- (void)worksUpPullFreshDataCallback{
    [self loadMoreUserInfo:_currentPageInfo?_currentPageInfo.currentPage + 1:0 size:jjMyworksPageSize];
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_detailView release];
    [_workView release];
}

@end
