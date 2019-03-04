//
//  JJWechatManager.m
//  wxIntegrate
//
//  Created by shenjie on 2019/3/4.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJWechatManager.h"
#import <AFNetwork/AFNetwork.h>
#import "HttpRequestUtil.h"
#import "JJTokenManager.h"

#import <SVProgressHUD/SVProgressHUD.h>

@implementation JJWechatManager

+ (JJWechatManager *)shareInstance{
    static JJWechatManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JJWechatManager alloc] init];
    });
    
    return instance;
}

- (void)clickWechatLogin:(UIViewController *)baseView{
    //加载loading
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    
    NSLog(@"%s", __func__);
    //如果已经授权过微信登录
    NSString *accessToken = [JJTokenManager shareInstance].getWechatToken;
    NSString *openId = [JJTokenManager shareInstance].getWechatOpenID;
    if(accessToken && openId){
        
        
        
    }else{
        [self wechatLogin:baseView];
    }
}


- (void)wechatLogin:(UIViewController *)baseView{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"wechat_sdk_demo_test";
        [WXApi sendAuthReq:req viewController:baseView delegate:self];
    }else{
        [SVProgressHUD showWithStatus:@"请先安装微信客户端"];
        [SVProgressHUD dismissWithDelay:2.0f];
    }
}

//获取用户信息
- (void)wechatLoginByRequestForUserInfo{
    NSString *accessToken = [JJTokenManager shareInstance].getWechatToken;
    NSString *openId = [JJTokenManager shareInstance].getWechatOpenID;
    
    
    
}

#pragma mark - WXApiDelegate
/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
- (void)onReq:(BaseReq*)req{
    
}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
- (void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode == 0){
            //成功
            NSLog(@"code %@",aresp.code);
            //请求access_token
            NSString *wxUrl = @"https://api.weixin.qq.com/sns/oauth2/access_token?";
            [HttpRequestUtil JJ_WechatLogin:wxUrl appid:@"" secret:@"" code:aresp.code callback:^(NSDictionary *data, NSError *error) {
                if(error){
                    [SVProgressHUD showErrorWithStatus:@"网络错误请重试"];
                    [SVProgressHUD dismissWithDelay:2.0];
                    return ;
                }

                if([data objectForKey:@"errcode"]){
                    [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errmsg"]];
                    [SVProgressHUD dismissWithDelay:2.0];
                    return;
                }
                
                NSString *accessToken = [data objectForKey:@"access_token"];
                NSString *openID = [data objectForKey:@"openid"];
                NSString *refreshToken = [data objectForKey:@"refresh_token"];
                // 本地持久化，自动登录
                if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                    [[JJTokenManager shareInstance] saveWechatToken:accessToken];
                    [[JJTokenManager shareInstance] saveWechatRefreshtoken:refreshToken];
                    [[JJTokenManager shareInstance] saveWechatOpenID:openID];
                }
                
            }];
        }else if(aresp.errCode == -4){
            //拒绝
            [SVProgressHUD showErrorWithStatus:@"用户拒绝"];
            [SVProgressHUD dismissWithDelay:2.0];
        }else if(aresp.errCode == -2){
            //取消
            [SVProgressHUD showErrorWithStatus:@"用户取消"];
            [SVProgressHUD dismissWithDelay:2.0];
        }
    }
}

@end
