//
//  AppDelegate.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "AppDelegate.h"
#import "HttpRequestUtil.h"
#import "HomeContentmManager.h"

#import "WXApi.h"
#import "JJWechatManager.h"
#import "WelcomeViewController.h"
#import "ViewController.h"
#import "CustomNaviViewController.h"
#import "Reachability.h"
#import "NetworkConfig.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@property (strong, nonatomic) CustomNaviViewController *navigationController;
@property (strong, nonatomic) Reachability *netReach;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 微信注册
    [WXApi registerApp:@"wx544a9dd772ec8e0d"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.navigationController = [[CustomNaviViewController alloc] initWithRootViewController:[ViewController new]];
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    
    // 启动App
    [self startApp];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //停止监听网络
    [self.netReach stopNotifier];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:[JJWechatManager shareInstance]];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[JJWechatManager shareInstance]];
}

#pragma mark - my logic
- (void) startApp{
    // 检测更新
    [self checkNewRelease];
    
    // 注册网路状态改变通知
    NSLog(@"注册网路状态改变通知");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.netReach = [Reachability reachabilityForInternetConnection];
    [NetworkConfig sharedConfig].status = [self.netReach currentReachabilityStatus];
    [self.netReach startNotifier];
    
    //本地推送
    [self registerAPN];
}

- (void)reachabilityChanged:(NSNotification *)note{
    Reachability *reach = [note object];
    if (![reach isKindOfClass:[Reachability class]]) return;
    [NetworkConfig sharedConfig].status = [reach currentReachabilityStatus];
}

- (void)checkNewRelease{
    NSLog(@"检测更新");
}

#pragma mark - Clear Cache
- (void) clearCache{
    
}

- (void)clearCacheSuccess{
    
}

- (long) getCacheSize{
//    long totalSize = (long)[[SDImageCache sharedImageCache] getSize];
//
//    totalSize += (long)[[NSURLCache sharedURLCache] currentDiskUsage];
//    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
//    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
//    for (NSString *p in files) {
//        NSError *error;
//        NSString *path = [cachPath stringByAppendingPathComponent:p];
//        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//            totalSize += [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error] fileSize];
//        }
//    }
    
    return 0;
}

#pragma mark - welcome
- (void) showWelcomeView{
//    WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
//    [_navController presentViewController:welcomeVC animated:NO completion:^{
//    }];
}

- (void) dismissSignView{
//    if ([_navController.presentedViewController isKindOfClass:[SignViewController class]]) {
//        [_navController dismissViewControllerAnimated:NO completion:^{
//            CurrentSession * session = [CurrentSession sharedSession];
//            if (session.memberType == MemberType_Unknown)
//            {
//                [self ShowRoleSelectView];
//                return;
//            }
//        }];
//    }
}


#pragma mark -localNotication
- (void)registerAPN{
    if ([[UIApplication sharedApplication]  respondsToSelector:@selector(registerForRemoteNotifications)]) {
        // 这里 types 可以自定义，如果 types 为 0，那么所有的用户通知均会静默的接收，系统不会给用户任何提示(当然，App 可以自己处理并给出提示)
        UIUserNotificationType types = (UIUserNotificationType) (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
        // 这里 categories 可暂不深入，本文后面会详细讲解。
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        // 当应用安装后第一次调用该方法时，系统会弹窗提示用户是否允许接收通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    }
    [self registerLocalNotificationInOldWay:10];
}

- (void)registerLocalNotificationInOldWay:(NSInteger)alertTime {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  @"该起床了...";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 移除某一个指定的通知
- (void)removeOneNotificationWithID:(NSString *)noticeId {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            for (UNNotificationRequest *req in requests){
                NSLog(@"存在的ID:%@\n",req.identifier);
            }
            NSLog(@"移除currentID:%@",noticeId);
        }];
        
        [center removePendingNotificationRequestsWithIdentifiers:@[noticeId]];
    }else {
        NSArray *array=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (UILocalNotification *localNotification in array){
            NSDictionary *userInfo = localNotification.userInfo;
            NSString *obj = [userInfo objectForKey:@"noticeId"];
            if ([obj isEqualToString:noticeId]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            }
        }
    }
}

// 移除所有通知
- (void)removeAllNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
    }else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"didReceiveLocalNotification notification");
    application.applicationIconBadgeNumber -= 1;
}

@end
