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
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()<JJTabBarDelegate, LoginSessionDelegate, UNUserNotificationCenterDelegate>

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

- (void)addLocalNotification{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                NSLog(@"注册通知成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    [self registerNotification:5];
                }];
            } else {
                //点击不允许
                NSLog(@"注册通知失败");
            }
        }];
    }
}

/** * 描述 使用 UNNotification 本地通知(iOS 10) * @param alerTime 多长时间后进行推送 **/
-(void)registerNotification:(NSInteger)alerTime
{
    // 1、创建通知内容，注：这里得用可变类型的UNMutableNotificationContent，否则内容的属性是只读的
    if (@available(iOS 10.0, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
        content.title = @"这是通知";
        // 次标题
        content.subtitle = @"这是通知subtitle";
        // 内容
        content.body = @"这是通知body这是通知body这是通知body这是通知body这是通知body这是通知body";
        
        // app显示通知数量的角标
        content.badge = [NSNumber numberWithInteger:4];
        
        // 通知的提示声音，这里用的默认的声音
        content.sound = [UNNotificationSound defaultSound];
        NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"cell2@2x" withExtension:@"png"];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        // 附件 可以是音频、图片、视频 这里是一张图片
        content.attachments = @[attachment];
        // 标识符
        content.categoryIdentifier = @"categoryIndentifier";
        // 2、创建通知触发
        /* 触发器分三种： UNTimeIntervalNotificationTrigger : 在一定时间后触发，如果设置重复的话，timeInterval不能小于60 UNCalendarNotificationTrigger : 在某天某时触发，可重复 UNLocationNotificationTrigger : 进入或离开某个地理区域时触发 */
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
        //    NSDateComponents *components = [NSDateComponents new];
        //    components.second = 2.0f;
        //    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
        
        // 3、创建通知请求
        UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"KFGroupNotification" content:content trigger:trigger];
        // 4、将请求加入通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"已成功加推送%@",notificationRequest.identifier);
            }
        }];
    }
}

#pragma mark - iOS10 推送代理

//不实现，通知不会有提示
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        //应用在前台收到通知
        NSLog(@"========%@", notification);
        
        UNNotificationRequest *request = notification.request; // 原始请求
        NSDictionary * userInfo = notification.request.content.userInfo;//userInfo数据
        UNNotificationContent *content = request.content; // 原始内容
        NSString *title = content.title;  // 标题
        NSString *subtitle = content.subtitle;  // 副标题
        NSNumber *badge = content.badge;  // 角标
        NSString *body = content.body;    // 推送消息体
        UNNotificationSound *sound = content.sound;  // 指定的声音
        //建议将根据Notification进行处理的逻辑统一封装，后期可在Extension中复用~
        //如果需要在应用在前台也展示通知
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 回调block，将设置传入
    }
}

// 对通知进行响应
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    // 根据类别标识符处理目标反应
    if ([response.notification.request.content.categoryIdentifier isEqualToString:@"categoryIndentifier"]) {
        [self handleResponse:response];
        
        UNNotificationRequest *request = response.notification.request; // 原始请求
        UNNotificationContent *content = request.content; // 原始内容
        NSString *title = content.title;  // 标题
        NSString *subtitle = content.subtitle;  // 副标题
        NSNumber *badge = content.badge;  // 角标
        NSString *body = content.body;    // 推送消息体
        UNNotificationSound *sound = content.sound;
        //在此，可判断response的种类和request的触发器是什么，可根据远程通知和本地通知分别处理，再根据action进行后续回调
    }
    completionHandler();
}

- (void)handleResponse:(UNNotificationResponse *)response  API_AVAILABLE(ios(10.0)){
    
    NSString *actionIndentifier = response.actionIdentifier;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSLog(@"%@",@"处理通知");
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
