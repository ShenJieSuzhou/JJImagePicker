//
//  JJCommentDecorateHeader.m
//  CommectProj
//
//  Created by shenjie on 2019/8/12.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJCommentDecorateHeader.h"
#import <Masonry/Masonry.h>
#import "JJCommentConstant.h"

@implementation JJCommentDecorateHeader
@synthesize titleLabel = _titleLabel;
@synthesize cubeView = _cubeView;
@synthesize picView = _picView;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.picView = [[UIView alloc] init];
    [self addSubview:self.picView];
    
    self.titleLabel = [[YYLabel alloc] init];
    self.titleLabel.text = @"观点";
    self.titleLabel.font = JJBlodFont(18);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.cubeView = [[UIImageView alloc] init];
    [self.cubeView setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.cubeView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(50.0f);
    }];
    
    [self.cubeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picView.mas_bottom).offset(10.0f);
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(20.0f);
        make.width.mas_equalTo(5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picView.mas_bottom).offset(10.0f);
        make.left.mas_equalTo(self).offset(20);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(100);
    }];
}


@end
