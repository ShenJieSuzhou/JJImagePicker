//
//  CustomTabbar.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CustomTabbar.h"

@implementation CustomTabbar
@synthesize centerBtn = _centerBtn;
@synthesize mdelegate = _mdelegate;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    // 设置tabbar的子控件
    self.centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.centerBtn setImage:[UIImage imageNamed:@"blur-circle"] forState:UIControlStateNormal];
    [self.centerBtn setImage:[UIImage imageNamed:@"blur-circle-selected"] forState:UIControlStateSelected];
    [self.centerBtn sizeToFit];
    [self.centerBtn addTarget:self action:@selector(clickCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.centerBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width/3;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.subviews) {
        if ([view isEqual:self.centerBtn]) {//self.centerButton
            view.frame = CGRectMake(0, 0, width, self.frame.size.height);
            [view sizeToFit];
            view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        }else if ([view isKindOfClass:class]){//system button
            CGRect frame = view.frame;
            int indexFromOrign = view.frame.origin.x/width;//防止UIView *view in self.subviews 获取到的不是有序的
            if (indexFromOrign >= 1) {
                indexFromOrign++;
            }
            CGFloat x = indexFromOrign * width;
            //如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            view.frame = CGRectMake(x, view.frame.origin.y, width, frame.size.height);
            
            //调整badge postion
            for (UIView *badgeView in view.subviews){
                NSString *className = NSStringFromClass([badgeView class]);
                // Looking for _UIBadgeView
                if ([className rangeOfString:@"BadgeView"].location != NSNotFound){
                    badgeView.layer.transform = CATransform3DIdentity;
                    badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0);
                    break;
                }
            }
        }
    }
}

- (void)clickCameraBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.centerBtn = sender;
    if([_mdelegate respondsToSelector:@selector(tabBar:clickCenterButton:)]){
        [_mdelegate tabBar:self clickCenterButton:sender];
    }
}

@end
