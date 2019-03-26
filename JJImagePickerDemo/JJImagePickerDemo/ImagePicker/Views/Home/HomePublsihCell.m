//
//  HomePublsihCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomePublsihCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>


@implementation HomePublsihCell
@synthesize hpImageView = _hpImageView;
@synthesize imgDesclabel = _imgDesclabel;
@synthesize avaterView = _avaterView;
@synthesize likeBtn = _likeBtn;
@synthesize likeCount = _likeCount;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:2.0f];
        [self.layer setMasksToBounds:YES];
        
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    _hpImageView = [[UIImageView alloc] init];
    _hpImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_hpImageView setBackgroundColor:[UIColor whiteColor]];
    [_hpImageView.layer setCornerRadius:3.0f];
    [_hpImageView.layer setMasksToBounds:YES];
    [self addSubview:_hpImageView];
    
    _imgDesclabel = [[UILabel alloc] init];
    [_imgDesclabel setTextAlignment:NSTextAlignmentLeft];
    _imgDesclabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_imgDesclabel setText:@""];
    [_imgDesclabel setTextColor:[UIColor blackColor]];
    [_imgDesclabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];//Helvetica
    [self addSubview:_imgDesclabel];
    
    _avaterView = [[UIImageView alloc] init];
    [_avaterView setImage:[UIImage imageNamed:@"userPlaceHold"]];
    _avaterView.layer.cornerRadius = 12.5f;
    [_avaterView.layer setMasksToBounds:YES];
    [self addSubview:_avaterView];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn setBackgroundColor:[UIColor clearColor]];
    [_likeBtn setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [_likeBtn setBackgroundImage:[UIImage imageNamed:@"like_sel"] forState:UIControlStateSelected];
    [_likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeBtn];
    
    _likeCount = [[UILabel alloc] init];
    [_likeCount setText:@"0"];
    [_likeCount setTextAlignment:NSTextAlignmentCenter];
    [_likeCount setTextColor:[UIColor blackColor]];
    [_likeCount setFont:[UIFont systemFontOfSize:13.0f]];
    [self addSubview:_likeCount];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_hpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(5.0f);
        make.left.mas_equalTo(self.mas_left).offset(5.0f);
        make.right.mas_equalTo(self.mas_right).offset(-5.0f);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-80.0f);
    }];
    
    [_imgDesclabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 15, 30.0f));
        make.top.mas_equalTo(self.hpImageView.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.mas_left).offset(10.0f);
        make.right.mas_equalTo(self.mas_right).offset(-5.0f);
    }];
    
    [_avaterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.mas_left).offset(10.0f);
    }];

    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_bottom).offset(5.0f);
        make.right.mas_equalTo(self.mas_right).offset(-50.0f);
    }];

    [_likeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 20.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.likeBtn.mas_right).offset(5.0f);
        make.right.mas_equalTo(self.mas_right).offset(5.0f);
    }];
}

- (void)clickLikeBtn:(UIButton *)sender{
    NSLog(@"%s", __func__);
    sender.selected = !sender.selected;
}

- (void)updateCell:(HomeCubeModel *)work{
    NSString *showedImgUrl = [work.path objectAtIndex:0];
    NSString *avater = work.iconUrl;
    NSString *desc = work.work;
    NSString *likeCount = work.likeNum;
    
    [_hpImageView sd_setImageWithURL:[NSURL URLWithString:showedImgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [_imgDesclabel setText:desc];
    [_avaterView sd_setImageWithURL:[NSURL URLWithString:avater] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [_likeCount setText:likeCount];
}


@end
