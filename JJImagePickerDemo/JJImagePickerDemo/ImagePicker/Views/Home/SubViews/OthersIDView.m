//
//  OthersIDView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/27.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "OthersIDView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation OthersIDView
@synthesize backgroundView = _backgroundView;
@synthesize iconView = _iconView;
@synthesize concernBtn = _concernBtn;
//@synthesize moreBtn = _moreBtn;
@synthesize goBackBtn = _goBackBtn;
@synthesize delegate = _delegate;
@synthesize userName = _userName;

@synthesize worksNumView = _worksNumView;
@synthesize workTitle = _workTitle;
@synthesize workNum = _workNum;

@synthesize likesView = _likesView;
@synthesize likesTitle = _likesTitle;
@synthesize likesNum = _likesNum;

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
    _personalBKs =  [NSArray arrayWithObjects:@"personal_1", @"personal_2", @"personal_3", @"personal_4", @"personal_5",@"personal_6", @"personal_7", @"personal_8", nil];
    
    NSString *bgName = [self.personalBKs objectAtIndex:[self getRandomNumber:0 to:7]];
    
    // 登录成功后显示的控件
    _backgroundView = [[UIImageView alloc] init];
    _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    [_backgroundView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", bgName]]];
    [self addSubview:_backgroundView];
    
    _iconView = [[UIImageView alloc] init];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    [_iconView setImage:[UIImage imageNamed:@"userPlaceHold"]];
    _iconView.layer.cornerRadius = 40.0f;
    _iconView.layer.borderWidth = 2.0f;
    _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    [_iconView.layer setMasksToBounds:YES];
    [_backgroundView addSubview:_iconView];
    
    _concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_concernBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_concernBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_concernBtn setBackgroundImage:[UIImage imageNamed:@"focusbk"] forState:UIControlStateNormal];
    [_concernBtn setBackgroundImage:[UIImage imageNamed:@"unfocusbk"] forState:UIControlStateSelected];
    [_concernBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_concernBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_concernBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_concernBtn.layer setCornerRadius:8.0f];
    [_concernBtn.layer setMasksToBounds:YES];
    [_concernBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_concernBtn addTarget:self action:@selector(clickConcernBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_concernBtn];
    
    _goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_goBackBtn setBackgroundImage:[UIImage imageNamed:@"arrowBack"] forState:UIControlStateNormal];
    [_goBackBtn setBackgroundColor:[UIColor clearColor]];
    [_goBackBtn addTarget:self action:@selector(clickGoBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goBackBtn];
    
    _userName = [[UILabel alloc] init];
    [_userName setTextColor:[UIColor whiteColor]];
    [_userName setFont:[UIFont fontWithName:@"Verdana" size:20.0f]];
    [_userName setTextAlignment:NSTextAlignmentCenter];
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
    _likesView = [UIView new];
    [_likesView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_likesView];
    
    _likesTitle = [UILabel new];
    [_likesTitle setText:@"被赞"];
    [_likesTitle setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_likesTitle setTextAlignment:NSTextAlignmentCenter];
    [_likesTitle setTextColor:[UIColor blackColor]];
    [_likesView addSubview:_likesTitle];
    
    _likesNum = [UILabel new];
    [_likesNum setText:@"0"];
    [_likesNum setFont:[UIFont systemFontOfSize:15.0f]];
    [_likesNum setTextAlignment:NSTextAlignmentCenter];
    [_likesView addSubview:_likesNum];
    
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
    
    UITapGestureRecognizer *gestureFocus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLikesView:)];
    [_likesView addGestureRecognizer:gestureFocus];
    
    UITapGestureRecognizer *gestureFans = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFansView:)];
    [_fansView addGestureRecognizer:gestureFans];
    
    UITapGestureRecognizer *gestureWorks = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWorksView:)];
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
    
    [_goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.left.mas_equalTo(self.mas_left).offset(20.0f);
        make.top.mas_equalTo(self.mas_top).offset(35.0f);
    }];
    
    [_concernBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 25.0f));
        make.right.mas_equalTo(self.mas_right).offset(-10.0f);
        make.top.mas_equalTo(self.mas_top).offset(35.0f);
    }];
    
    NSArray *array = [NSArray arrayWithObjects:_worksNumView, _fansView, _likesView, nil];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backgroundView.mas_bottom);
        make.width.mas_equalTo(self.frame.size.width / 3);
        make.height.mas_equalTo(80.0f);
    }];
    
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
    [_likesTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.top.mas_equalTo(self.likesView).offset(10.0f);
        make.centerX.mas_equalTo(self.likesView.mas_centerX);
    }];
    
    [_likesNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0f, 30.0f));
        make.centerX.mas_equalTo(self.likesView.mas_centerX);
        make.bottom.mas_equalTo(self.likesView).offset(-10.0f);
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

- (void)updateViewInfo:(UIImage *)avater name:(NSString *)name worksCount:(NSString *)worksCount fans:(NSString *)fansNum likes:(NSString *)likesCount hasFocused:(BOOL)hasFocused isSelf:(BOOL)isSelf{
    
    [_iconView setImage:avater];
    [_userName setText:name];
    [_workNum setText:worksCount];
    [_fansNum setText:fansNum];
    [_likesNum setText:likesCount];
    _concernBtn.selected = hasFocused;
    
    if(isSelf){
        [_concernBtn setHidden:YES];
    }
}

- (void)clickConcernBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    [_delegate focusHerCandy:sender];
}

//- (void)clickMoreBtn:(UIButton *)sender{
//    [_delegate clickMore];
//}

- (void)clickGoBackBtn:(UIButton *)sender{
    [_delegate goback];
}

- (void)clickLikesView:(UIGestureRecognizer *)sender{
//    [_delegate showFansListCallback];
}

- (void)clickFansView:(UIGestureRecognizer *)sender{
    NSLog(@"clickFansView");
    [_delegate showFansListCallback];
}

- (void)clickWorksView:(UIGestureRecognizer *)sender{
    NSLog(@"clickWorksView");
}

@end
