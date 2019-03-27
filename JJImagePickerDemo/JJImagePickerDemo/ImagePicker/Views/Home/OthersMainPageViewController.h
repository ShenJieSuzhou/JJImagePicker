//
//  OthersMainPageViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/27.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "HttpRequestUtil.h"
#import "HttpRequestUrlDefine.h"
#import "JJTokenManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Works.h"

@interface OthersMainPageViewController : UIViewController

- (void)setDetailInfo:(NSString *)userId avater:(UIImage *)avater name:(NSString *)name;

@end
