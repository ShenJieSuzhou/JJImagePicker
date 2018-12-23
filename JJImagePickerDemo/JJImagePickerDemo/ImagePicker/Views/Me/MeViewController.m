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


#define USERVIEW_WIDTH self.view.frame.size.width
#define USERVIEW_HEIGHT self.view.frame.size.height
#define DETAIL_INFO_VIEW_HEIGHT 180.0f

@interface MeViewController ()<DetailInfoViewDelegate,LoginSessionDelegate>

@property (strong, nonatomic) DetailInfoView *detailView;
@property (strong, nonatomic) WorksView *workView;
@property (assign) BOOL isLogin;

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //判断用户是否登录
    [SVProgressHUD show];
    if(![[LoginSessionManager getInstance] isUserLogin]){
        _isLogin = NO;
        [SVProgressHUD dismiss];
        [self popLoginViewController];
    }else{
        [[LoginSessionManager getInstance] verifyUserToken];
    }
    
    
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.workView];

    
    [self.detailView setLoginState:_isLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 刷新用户界面
 */
- (void)refreshViewInfo{
//    [self.detailView updateViewInfo:<#(NSString *)#> name:<#(NSString *)#> focus:<#(NSString *)#> fans:<#(NSString *)#>]
//    [self.workView updateWorksArray:<#(NSMutableArray *)#>]
    
    
}

/**
 用户信息view

 @return 用户信息视图
 */
-(DetailInfoView *)detailView{
    if(!_detailView){
        _detailView = [[DetailInfoView alloc] initWithFrame:CGRectMake(0, 0, USERVIEW_WIDTH, DETAIL_INFO_VIEW_HEIGHT)];
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
        _workView = [[WorksView alloc] initWithFrame:CGRectMake(0, DETAIL_INFO_VIEW_HEIGHT, USERVIEW_WIDTH, USERVIEW_HEIGHT - DETAIL_INFO_VIEW_HEIGHT)];
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

#pragma - mark DetailInfoViewDelegate
- (void)pickUpHeaderImgCallback{
    
}

- (void)appSettingClickCallback{
    SettingViewController *settingView = [SettingViewController new];
    [self presentViewController:settingView animated:YES completion:^{
        
    }];
}

- (void)clickToLoginCallback{
    JJLoginViewController *loginView = [JJLoginViewController new];
    [self presentViewController:loginView animated:YES completion:^{
        
    }];
}

#pragma - mark LoginSessionDelegate
- (void)tokenVerifySuccessful{
    //刷新数据
    [self refreshViewInfo];
}

- (void)tokenVerifyError{
    [self popLoginViewController];
}

- (void)networkError{
    //网络出错了 请刷新界面
}

@end
