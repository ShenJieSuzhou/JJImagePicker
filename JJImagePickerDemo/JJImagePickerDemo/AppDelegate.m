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
#import "ViewController.h"
#import "CustomNaviViewController.h"
#import "Reachability.h"
#import "NetworkConfig.h"
#import <UserNotifications/UserNotifications.h>
#import "PushUtil.h"
#import "GlobalDefine.h"

#import <SDWebImage/SDImageCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

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

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    if (application.applicationState == UIApplicationStateActive) {
        // 这里真实需要处理交互的地方
        // 获取通知所带的数据
//        NSString *content = [notification.userInfo objectForKey:@"content"];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"本地推送" message:content preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        }];
//        [alertController addAction:alertAction];
//
//        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        
//    }
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge --;
    badge = badge >= 0? badge: 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    NSArray *localNotification = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotification) {
        // 在不需要再推送时，可以取消推送
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
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
    [PushUtil authLocalNotifition];
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //清除SDWebImage图片缓存
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [SVProgressHUD showSuccessWithStatus:@"缓存清理成功"];
            [SVProgressHUD dismissWithDelay:1.0f];
            [[NSNotificationCenter defaultCenter] postNotificationName:JJ_CLEAR_CACHE_SUCCESS object:nil];
        }];
    });
}

- (long) getCacheSize{
    long totalSize = (long)[[SDImageCache sharedImageCache] getSize];

    totalSize += (long)[[NSURLCache sharedURLCache] currentDiskUsage];
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            totalSize += [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error] fileSize];
        }
    }
    
    return totalSize / (1024*1024);
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

@end
