//
//  JJCollectionViewCell.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/11.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJCollectionViewCell.h"

@implementation JJCollectionViewCell
@synthesize contentImageView = _contentImageView;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentImageView.frame = self.contentView.bounds;
}

@end
