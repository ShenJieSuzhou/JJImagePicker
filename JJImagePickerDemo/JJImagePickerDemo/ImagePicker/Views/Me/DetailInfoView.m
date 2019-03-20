//
//  DetailInfoView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "DetailInfoView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation DetailInfoView
@synthesize backgroundView = _backgroundView;
@synthesize iconView = _iconView;
@synthesize settingBtn = _settingBtn;
@synthesize delegate = _delegate;
@synthesize userName = _userName;

@synthesize worksNumView = _worksNumView;
@synthesize workTitle = _workTitle;
@synthesize workNum = _workNum;

@synthesize focusView = _focusView;
@synthesize focusTitle = _focusTitle;
@synthesize focusNum = _focusNum;

@synthesize fansView = _fansView;
@synthesize fansTitle = _fansTitle;
@synthesize fansNum = _fansNum;

@synthesize personalBKs = _personalBKs;


- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    _personalBKs =  [NSArray arrayWithObjects:@"personal_1", @"personal_2", @"personal_3", @"personal_4", @"personal_5",@"personal_6", @"personal_7", nil];
    
    NSString *bgName = [self.personalBKs objectAtIndex:[self getRandomNumber:0 to:7]];
    
    // 登录成功后显示的控件
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    [_backgroundView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", bgName]]];
    [self addSubview:_backgroundView];
    
    _iconView = [[UIImageView alloc] init];
    [_iconView setImage:[UIImage imageNamed:@"userPlaceHold"]];
    _iconView.layer.cornerRadius = 40.0f;
    _iconView.layer.borderWidth = 2.0f;
    _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    [_iconView.layer setMasksToBounds:YES];
    [_backgroundView addSubview:_iconView];
    
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setBackgroundColor:[UIColor clearColor]];
    [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_settingBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_settingBtn addTarget:self action:@selector(clickSetting:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_settingBtn];
    
    _userName = [[UILabel alloc] init];
    [_userName setTextColor:[UIColor whiteColor]];
    [_userName setFont:[UIFont fontWithName:@"Verdana" size:20.0f]];
    [_userName setTextAlignment:NSTextAlignmentCenter];
    [_userName setText:@""];
    [_backgroundView addSubview:_userName];
    
    // 作品
    _worksNumView = [UIView new];
    [_worksNumView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_worksNumView];
    
    _workTitle = [UILabel new];
    [_workTitle setText:@"发布"];
    [_workTitle setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_workTitle setTextAlignment:NSTextAlignmentCenter];
    [_worksNumView addSubview:_workTitle];
    
    _workNum = [UILabel new];
    [_workNum setText:@"0"];
    [_workNum setFont:[UIFont systemFontOfSize:15.0f]];
    [_workNum setTextAlignment:NSTextAlignmentCenter];
    [_worksNumView addSubview:_workNum];
    
    // 关注
    _focusView = [UIView new];
    [_focusView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_focusView];

    _focusTitle = [UILabel new];
    [_focusTitle setText:@"关注"];
    [_focusTitle setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_focusTitle setTextAlignment:NSTextAlignmentCenter];
    [_focusTitle setTextColor:[UIColor blackColor]];
    [_focusView addSubview:_focusTitle];

    _focusNum = [UILabel new];
    [_focusNum setText:@"0"];
    [_focusNum setFont:[UIFont systemFontOfSize:15.0f]];
    [_focusNum setTextAlignment:NSTextAlignmentCenter];
    [_focusView addSubview:_focusNum];
    
    // 粉丝
    _fansView = [UIView new];
    [_fansView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_fansView];
    
    _fansTitle = [UILabel new];
    [_fansTitle setText:@"粉丝"];
    [_fansTitle setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_fansTitle setTextAlignment:NSTextAlignmentCenter];
    [_fansView addSubview:_fansTitle];
    
    _fansNum = [UILabel new];
    [_fansNum setText:@"0"];
    [_fansNum setFont:[UIFont systemFontOfSize:15.0f]];
    [_fansNum setTextAlignment:NSTextAlignmentCenter];
    [_fansView addSubview:_fansNum];
    
    UIGestureRecognizer *gestureFocus = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickFocusView:)];
    [_focusView addGestureRecognizer:gestureFocus];

    UIGestureRecognizer *gestureFans = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickFansView:)];
    [_fansView addGestureRecognizer:gestureFans];

    UIGestureRecognizer *gestureWorks = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickWorksView:)];
    [_worksNumView addGestureRecognizer:gestureWorks];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-80.0f);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80.0f, 80.0f));
        make.center.mas_equalTo(self.backgroundView);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200.0f, 30.0f));
        make.top.equalTo(self.iconView.mas_bottom).offset(10.0f);
        make.centerX.mas_equalTo(self.backgroundView);
    }];
    
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 30.0f));
        make.right.mas_equalTo(self.backgroundView.mas_right).offset(-20.0f);
        make.top.mas_equalTo(self.backgroundView.mas_top).offset(35.0f);
    }];
    
    NSArray *array = [NSArray arrayWithObjects:_worksNumView, _focusView, _fansView, nil];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backgroundView.mas_bottom);
        make.width.mas_equalTo(self.frame.size.width / 3);
        make.height.mas_equalTo(80.0f);
    }];
    
//    [_worksNumView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(self.frame.size.width / 3, 80.0f));
//        make.top.mas_equalTo(self.backgroundView.mas_bottom);
//        make.left.mas_equalTo(self.mas_left);
//    }];
//
    [_workTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.top.mas_equalTo(self.worksNumView).offset(10.0f);
        make.centerX.mas_equalTo(self.worksNumView.mas_centerX);
    }];

    [_workNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.centerX.mas_equalTo(self.worksNumView.mas_centerX);
        make.bottom.mas_equalTo(self.worksNumView).offset(-10.0f);
    }];

    // 关注
    [_focusTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.top.mas_equalTo(self.focusView).offset(10.0f);
        make.centerX.mas_equalTo(self.focusView.mas_centerX);
    }];

    [_focusNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.centerX.mas_equalTo(self.focusView.mas_centerX);
        make.bottom.mas_equalTo(self.focusView).offset(-10.0f);
    }];

    // 粉丝
    [_fansTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.top.mas_equalTo(self.fansView).offset(10.0f);
        make.centerX.mas_equalTo(self.fansView.mas_centerX);
    }];

    [_fansNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.centerX.mas_equalTo(self.fansTitle.mas_centerX);
        make.bottom.mas_equalTo(self.fansView).offset(-10.0f);
    }];
}

- (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)updateViewInfo:(NSString *)iconurl name:(NSString *)name focus:(NSString *)focusNum fans:(NSString *)fansNum{
    [_iconView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl]]]];
    [_userName setText:name];
//    [_focusNum setText:@""];
//    [_fansNum setText:@""];
}

- (void)clickSetting:(UIButton *)sender{
    [_delegate appSettingClickCallback];
}

- (void)clickFocusView:(UIGestureRecognizer *)sender{
    NSLog(@"clickFocusView");
}

- (void)clickFansView:(UIGestureRecognizer *)sender{
    NSLog(@"clickFansView");
}

- (void)clickWorksView:(UIGestureRecognizer *)sender{
    NSLog(@"clickWorksView");
}

@end
