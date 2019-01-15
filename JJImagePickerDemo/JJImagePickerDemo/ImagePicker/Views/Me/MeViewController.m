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


#define USERVIEW_WIDTH self.view.frame.size.width
#define USERVIEW_HEIGHT self.view.frame.size.height
#define DETAIL_INFO_VIEW_HEIGHT 150.0f

@interface MeViewController ()<DetailInfoViewDelegate,LoginSessionDelegate,LoginOutDelegate>

@property (strong, nonatomic) DetailInfoView *detailView;
@property (strong, nonatomic) WorksView *workView;
@property (assign) BOOL isLogin;

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated{
    //判断用户是否登录
//    [SVProgressHUD show];
//    [LoginSessionManager getInstance].delegate = self;
//
//    if(![[LoginSessionManager getInstance] isUserLogin]){
//        _isLogin = NO;
//        [SVProgressHUD dismiss];
//        [self popLoginViewController];
//    }else{
//        [[LoginSessionManager getInstance] verifyUserToken];
//    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.workView];
    [self.workView updateWorksArray:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLoginSuccess:) name:LOGINSUCCESS_NOTIFICATION object:nil];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
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
    }
    return _workView;
}


/**
 弹出登录界面
 */
- (void)popLoginViewController{
    JJLoginViewController *jjLoginView = [JJLoginViewController new];
    [self presentViewController:jjLoginView animated:YES completion:^{
        
    }];
}

/**
 刷新用户界面
 */
- (void)refreshViewInfo{

    [self.detailView updateViewInfo:[JJTokenManager shareInstance].getUserAvatar name:[JJTokenManager shareInstance].getUserName focus:[JJTokenManager shareInstance].getFocusPlayerNum fans:[JJTokenManager shareInstance].getUserFans];
        
        //异步去请求自己的作品
    
//        if(!userModel.worksArray){
//            return;
//        }
//
//        NSMutableArray *workArray = [[NSMutableArray alloc] init];
//        for (int i = 0; i < [userModel.worksArray count]; i++) {
//            NSDictionary *workInfo = [userModel.worksArray objectAtIndex:i];
//            NSString *path = [workInfo objectForKey:@"path"];
//            NSString *photoid = [NSString stringWithFormat:@"%@", [workInfo objectForKey:@"photoid"]];
//            NSString *userid = [NSString stringWithFormat:@"%@",[workInfo objectForKey:@"userid"]];
//            NSString *work = [workInfo objectForKey:@"work"];
//
//            Works *obj = [[Works alloc] initWithPath:path photoID:photoid userid:userid work:work];
//            [workArray addObject:obj];
//        }
//
//        [self.workView updateWorksArray:workArray];
}

#pragma - mark DetailInfoViewDelegate
- (void)pickUpHeaderImgCallback{
    
}

- (void)appSettingClickCallback{
    SettingViewController *settingView = [SettingViewController new];
    settingView.delegate = self;
    [self presentViewController:settingView animated:YES completion:^{
        
    }];
}

- (void)clickToLoginCallback{
    JJLoginViewController *loginView = [JJLoginViewController new];
    [self presentViewController:loginView animated:YES completion:^{
        
    }];
}

#pragma mark - notification
- (void)receiveLoginSuccess:(NSNotification *)notify{
    _isLogin = YES;
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.workView];
    [self.detailView setLoginState:_isLogin];
    //刷新数据
    [self refreshViewInfo];
}

#pragma mark - loginoutCallback
- (void)userLoginOutCallBack:(SettingViewController *)viewController{
    //回到首页
    UIWindow *windowW = [UIApplication sharedApplication].keyWindow;
    UITabBarController *tabBarVC = (UITabBarController *)windowW.rootViewController;
    if(tabBarVC) {
        [tabBarVC setSelectedIndex:0];
    }
    
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma - mark LoginSessionDelegate
- (void)tokenVerifySuccessful{
    [SVProgressHUD dismiss];
    _isLogin = YES;
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.workView];
    [self.detailView setLoginState:_isLogin];
    //刷新数据
    [self refreshViewInfo];
}

- (void)tokenVerifyError:(NSString *)errorDesc{
    [SVProgressHUD showErrorWithStatus:errorDesc];
    [SVProgressHUD dismissWithDelay:2.0f];

    [self popLoginViewController];
}

- (void)networkError:(NSError *)error{
    //网络出错了 请刷新界面
    [SVProgressHUD showErrorWithStatus:@"网络连接错误，请检查网络"];
    [SVProgressHUD dismissWithDelay:2.0f];
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_detailView release];
    [_workView release];
}

@end
