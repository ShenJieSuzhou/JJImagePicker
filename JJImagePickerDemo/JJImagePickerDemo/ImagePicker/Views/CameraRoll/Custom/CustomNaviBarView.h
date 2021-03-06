//
//  CustomNaviBarView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNaviBarView : UIView
@property (nonatomic, strong) UIViewController *m_viewCtrlParent;
@property (nonatomic, strong) UIImage *m_background;

@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *imgViewBg;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
//@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UIButton *btnTitle;


//创建一个自定义按钮
+ (UIButton *)createNavBarImageBtn:(NSString *)imgStr
                       Highligthed:(NSString *)imgHighStr
                            Target:(id)target
                            Action:(SEL)action;

//设置按钮与标题
- (void)setLeftBtn:(UIButton *)btn;
- (void)setRightBtn:(UIButton *)btn;
- (void)setTitleBtn:(UIButton *)btn;
- (void)setTitle:(NSString *)titleStr textColor:(UIColor *)color font:(UIFont *)font;
//- (void)setTitleImg:(NSString *)imgStr;

//设置按钮+大小
- (void)setLeftBtn:(UIButton *)btn withFrame:(CGRect)frame;
- (void)setRightBtn:(UIButton *)btn withFrame:(CGRect)frame;


// 在导航条上覆盖一层自定义视图。
- (void)showCoverView:(UIView *)view;
- (void)showCoverView:(UIView *)view animation:(BOOL)bIsAnimation;
- (void)showCoverViewOnTitleView:(UIView *)view;
- (void)hideCoverView:(UIView *)view;

+ (CGRect)leftBtnFrame;
+ (CGRect)rightBtnFrame;
+ (CGRect)titleBtnFrame;
+ (CGSize)barBtnSize;
+ (CGSize)barSize;
+ (CGRect)titleViewFrame;
//+ (CGRect)titleImageViewFrame;

@end
