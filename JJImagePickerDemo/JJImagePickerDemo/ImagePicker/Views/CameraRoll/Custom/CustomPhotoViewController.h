//
//  CustomPhotoViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNaviBarView.h"

@interface CustomPhotoViewController : UIViewController

@property (strong, nonatomic) CustomNaviBarView *customNaviBar;

- (void)bringNaviBarToTopmost;

- (void)setNaviBarTitle:(NSString *)strTitle color:(UIColor *)color font:(UIFont *)font;
- (void)setTitleImg:(NSString *)imgStr;
- (void)setNaviBarLeftBtn:(UIButton *)leftBtn;
- (void)setNaviBarRightBtn:(UIButton *)rightBtn;
@end
