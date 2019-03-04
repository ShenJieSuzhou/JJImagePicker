//
//  JJWechatManager.h
//  wxIntegrate
//
//  Created by shenjie on 2019/3/4.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"

typedef NS_ENUM(NSUInteger, JJWXRESPCODE) {
    JJ_WECHAT_OK,
    JJ_WECHAT_DENIED,
    JJ_WECHAT_CANCEL,
};

//微信登录回调
@protocol JJWXLoginDelegate <NSObject>

- (void)wechatLoginSuccess;

- (void)wechatLoginDenied;

- (void)wechatLoginCancel;

@end

@interface JJWechatManager : NSObject<WXApiDelegate>
@property (weak, nonatomic) id<JJWXLoginDelegate> delegate;


+ (JJWechatManager *)shareInstance;

- (void)clickWechatLogin:(UIViewController *)baseView;

@end

