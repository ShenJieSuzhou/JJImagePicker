//
//  EditingToolCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "EditingToolCell.h"

@implementation EditingToolCell

@synthesize editImage = _editImage;
@synthesize editTitle = _editTitle;
@synthesize editImageSel = _editImageSel;
@synthesize title = _title;
@synthesize iconV = _iconV;

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
    self.iconV = [[UIImageView alloc] init];
    self.editImage = [[UIImage alloc] init];
    
    self.iconV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconV];
    
    self.title = [[UILabel alloc] init];
    [self.title setFont:[UIFont fontWithName:@"Verdana" size:10.0f]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.title];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat padding = 10.0f;
    CGFloat fDeltaWidth = size.width - 2*padding;
    CGFloat fDeltaHeight = fDeltaWidth;
    
    [self.iconV setFrame:CGRectMake(padding, padding, fDeltaWidth, fDeltaHeight)];
    [self.iconV setImage:self.editImage];
    [self.title setFrame:CGRectMake(padding, size.height - 2*padding, fDeltaWidth, size.height - 2*padding - fDeltaWidth)];
    [self.title setText:self.editTitle];
}

@end
