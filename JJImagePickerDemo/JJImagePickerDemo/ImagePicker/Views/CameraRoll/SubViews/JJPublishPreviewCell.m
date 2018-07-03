//
//  JJPublishPreviewCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPublishPreviewCell.h"

@implementation JJPublishPreviewCell

@synthesize contentImageView = _contentImageView;
@synthesize editBtn = _editBtn;

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
    //添加图片视图
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImageView];
    
    //添加 editbutton
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentImageView.frame = self.contentView.bounds;
}

@end
