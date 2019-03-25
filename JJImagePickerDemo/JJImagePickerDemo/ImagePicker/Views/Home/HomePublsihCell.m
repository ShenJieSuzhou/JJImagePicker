//
//  HomePublsihCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomePublsihCell.h"
#import <Masonry/Masonry.h>


@implementation HomePublsihCell
@synthesize hpImageView = _hpImageView;
@synthesize imgDesclabel = _imgDesclabel;
@synthesize avaterView = _avaterView;
@synthesize likeBtn = _likeBtn;
@synthesize likeCount = _likeCount;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    _hpImageView = [[UIImageView alloc] init];
    _hpImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_hpImageView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_hpImageView];
    
    _imgDesclabel = [[UILabel alloc] init];
    [_imgDesclabel setTextAlignment:NSTextAlignmentLeft];
    [_imgDesclabel setText:@""];
    [_imgDesclabel setTextColor:[UIColor blackColor]];
    [_imgDesclabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self addSubview:_imgDesclabel];
    
    _avaterView = [[UIImageView alloc] init];
    [_avaterView setImage:[UIImage imageNamed:@"userPlaceHold"]];
    _avaterView.layer.cornerRadius = 20.0f;
    [_avaterView.layer setMasksToBounds:YES];
    [self addSubview:_avaterView];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn setBackgroundColor:[UIColor clearColor]];
    [_likeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_likeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [_likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeBtn];
    
    _likeCount = [[UILabel alloc] init];
    [_likeCount setText:@"0"];
    [_imgDesclabel setTextAlignment:NSTextAlignmentCenter];
    [_likeCount setTextColor:[UIColor blackColor]];
    [_likeCount setFont:[UIFont systemFontOfSize:13.0f]];
    [self addSubview:_likeCount];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_hpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-80.0f);
    }];
    
    [_imgDesclabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hpImageView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-30.0f);
    }];
    
    [_avaterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10.0f);
    }];
    
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-50.0f);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10.0f);
    }];
    
    [_likeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 20.0f));
        make.left.mas_equalTo(self.likeBtn.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10.0f);
    }];
}

- (void)clickLikeBtn:(UIButton *)sender{
    NSLog(@"%s", __func__);
    
}

- (void)updateCell:(Works *)work{
    
}


@end
