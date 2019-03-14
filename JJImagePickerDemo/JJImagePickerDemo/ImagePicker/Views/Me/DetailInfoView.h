//
//  DetailInfoView.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailInfoViewDelegate <NSObject>
- (void)appSettingClickCallback;

@optional
- (void)changeBackgroundCallback;

@end

@interface DetailInfoView : UIView

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel  *userName;

@property (nonatomic, strong) UIView *worksNumView;
@property (nonatomic, strong) UILabel *workTitle;
@property (nonatomic, strong) UILabel *workNum;

@property (nonatomic, strong) UIView *focusView;
@property (nonatomic, strong) UILabel *focusTitle;
@property (nonatomic, strong) UILabel *focusNum;

@property (nonatomic, strong) UIView *fansView;
@property (nonatomic, strong) UILabel *fansTitle;
@property (nonatomic, strong) UILabel *fansNum;


@property (weak, nonatomic) id<DetailInfoViewDelegate> delegate;

- (void)updateViewInfo:(NSString *)iconurl name:(NSString *)name focus:(NSString *)focusNum fans:(NSString *)fansNum;

@end
