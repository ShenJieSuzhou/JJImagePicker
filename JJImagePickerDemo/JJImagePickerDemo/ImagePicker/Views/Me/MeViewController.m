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

#define USERVIEW_WIDTH self.view.frame.size.width
#define USERVIEW_HEIGHT self.view.frame.size.height
#define DETAIL_INFO_VIEW_HEIGHT 180.0f

@interface MeViewController ()<DetailInfoViewDelegate>

@property (strong, nonatomic) DetailInfoView *detailView;
@property (strong, nonatomic) WorksView *workView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.workView];
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

@end
