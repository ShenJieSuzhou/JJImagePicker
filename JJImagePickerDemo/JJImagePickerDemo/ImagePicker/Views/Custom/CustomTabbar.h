//
//  CustomTabbar.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabbar;
@protocol JJTabBarDelegate <NSObject>

-(void)tabBar:(CustomTabbar *)tabBar clickCenterButton:(UIButton *)sender;

@end

@interface CustomTabbar : UITabBar

@property (strong, nonatomic) UIButton *centerBtn;
@property (weak, nonatomic) id<JJTabBarDelegate> mdelegate;


@end

