//
//  FansZoneViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/8.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "HttpRequestUtil.h"
#import "HttpRequestUrlDefine.h"
#import "JJTokenManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Works.h"
#import "OthersIDView.h"
#import "WorksView.h"
#import "GlobalDefine.h"
#import "OriginalWorksViewController.h"
#import "CandyFansViewController.h"
#import "JJPageInfo.h"

@interface FansZoneViewController : UIViewController

// 设置粉丝空间信息
- (void)setFansModel:(FansModel *)fansModel;

@end

