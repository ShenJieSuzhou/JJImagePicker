//
//  ViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ViewController.h"
#import "JJImageViewPicker.h"
#import "PhotoEditingViewController.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "CameraPhotoViewController.h"
#import "CustomTabbar.h"
#import "InterestingViewController.h"
#import "LoginSessionManager.h"
#import "HttpRequestUrlDefine.h"
#import "WelcomeViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>


@interface ViewController ()<JJTabBarDelegate, LoginSessionDelegate>

@property (strong, nonatomic) PhotoEditingViewController *photoEditingView;
@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) MeViewController *meViewController;
@property (strong, nonatomic) CameraPhotoViewController *cpViewController;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    // 判断用户是否是第一次进APP
    if (![[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_firstStart", version]]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@_firstStart", version]];
        [self.navigationController pushViewController:[WelcomeViewController new] animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    CustomTabbar *cusTabbar = [[CustomTabbar alloc] init];
    cusTabbar.mdelegate = self;
    [self setValue:cusTabbar forKeyPath:@"tabBar"];
    
    _homeViewController = [HomeViewController new];
    _meViewController = [MeViewController new];

    [self setupChildViewController:@"精选" viewController:_homeViewController image:@"hot" selectedImage:@"hot_sel"];
    [self setupChildViewController:@"我" viewController:_meViewController image:@"me" selectedImage:@"me_sel"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PhotoEditingViewController *)photoEditingView{
    if(!_photoEditingView){
        _photoEditingView = [[PhotoEditingViewController alloc] init];
    }
    return _photoEditingView;
}

- (void)setupChildViewController:(NSString *)title
                  viewController:(UIViewController *)controller
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage {
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];

    controller.tabBarItem = item;
    controller.title = title;
    [self addChildViewController:controller];
}

-(void)tabBar:(CustomTabbar *)tabBar clickCenterButton:(UIButton *)sender{
    self.cpViewController = [CameraPhotoViewController new];
//    [self presentViewController:self.cpViewController animated:YES completion:^{
//
//    }];
    
    [self.navigationController pushViewController:self.cpViewController animated:YES];
}

//#pragma - mark LoginSessionDelegate
//- (void)tokenVerifySuccessful{
//    [SVProgressHUD dismiss];
//    //刷新数据
////    [self refreshViewInfo];
//}
//
//#pragma mark - notification
//- (void)receiveLoginSuccess:(NSNotification *)notify{
//    //刷新数据
////    [self refreshViewInfo];
//}
//
//- (void)tokenVerifyError:(NSString *)errorDesc{
//    [SVProgressHUD showErrorWithStatus:errorDesc];
//    [SVProgressHUD dismissWithDelay:2.0f];
//
//    [self popLoginViewController];
//}
//
//- (void)networkError:(NSError *)error{
//    //网络出错了 请刷新界面
//    [SVProgressHUD showErrorWithStatus:@"网络连接错误，请检查网络"];
//    [SVProgressHUD dismissWithDelay:2.0f];
//
//    [self popLoginViewController];
//}

@end
