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
#import "HomeCubeModel.h"
#import "FansModel.h"


@interface OthersMainPageViewController : UIViewController

// 设置空间信息
- (void)setUserZone:(HomeCubeModel *)zoneInfo;

// 设置粉丝空间信息
- (void)setFansModel:(FansModel *)fansModel;

@end
