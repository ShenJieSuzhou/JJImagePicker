//
//  WordBrushCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WordBrushCell.h"

@implementation WordBrushCell
@synthesize colorImg = _colorImg;

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
    self.colorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    [self.colorImg.layer setCornerRadius:self.colorImg.frame.size.width/2];
    [self.colorImg.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.colorImg.layer.borderWidth = 1.5f;
    self.colorImg.center = self.center;
    self.colorImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.colorImg setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.colorImg];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)updateCellContent:(UIColor *)color{
    [self.colorImg setBackgroundColor:color];
}

@end
