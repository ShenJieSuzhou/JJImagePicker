//
//  CustomPhotoViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNaviBarView.h"
#import "TabBarView.h"

@interface CustomPhotoViewController : UIViewController

@property (strong, nonatomic) CustomNaviBarView *customNaviBar;
@property (nonatomic, strong) TabBarView *jjTabBarView;
@property (assign) BOOL isPublishViewAsk;
- (void)bringNaviBarToTopmost;

- (void)setNaviBarTitle:(NSString *)strTitle color:(UIColor *)color font:(UIFont *)font;
- (void)setTitlebtn:(UIButton *)titleBtn;
- (void)setNaviBarLeftBtn:(UIButton *)leftBtn;
- (void)setNaviBarRightBtn:(UIButton *)rightBtn;
@end
