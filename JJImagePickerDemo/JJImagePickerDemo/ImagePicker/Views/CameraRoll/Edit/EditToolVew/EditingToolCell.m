//
//  EditingToolCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "EditingToolCell.h"

@implementation EditingToolCell

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
    CGSize size = self.bounds.size;
    CGFloat fDeltaWidth = 45.0f;
    CGFloat fDeltaHeight = 45.0f;
    CGFloat padding = 10.0f;
    
    self.iconV = [[UIImageView alloc] init];
    [self.iconV setFrame:CGRectMake((size.width - fDeltaWidth)/2, (size.height - fDeltaHeight)/2 - padding, fDeltaWidth, fDeltaHeight)];
    self.iconV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconV];
    
    self.title = [[UILabel alloc] init];
     [self.title setFrame:CGRectMake((size.width - fDeltaWidth)/2, fDeltaHeight + (size.height - fDeltaHeight)/2 - padding, fDeltaWidth, 20.0f)];
    [self.title setFont:[UIFont fontWithName:@"Verdana" size:11.0f]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.title];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)updateCellContent:(UIImage *)image title:(NSString *)title type:(JJ_EDITCELL_TYPE)type{
    if(type == FILTER_CELL){
        CGSize size = self.bounds.size;
        CGFloat padding = 10.0f;
        CGFloat fDeltaWidth = size.width - 2*padding;
        CGFloat fDeltaHeight = 3*fDeltaWidth/2;
        
        [self.iconV setFrame:CGRectMake((size.width - fDeltaWidth)/2, padding, fDeltaWidth, fDeltaHeight)];
        [self.title setFrame:CGRectMake((size.width - fDeltaWidth)/2, fDeltaHeight + (size.height - fDeltaHeight)/2, fDeltaWidth, 20.0f)];
        
        [self.iconV setImage:image];
        [self.title setText:title];
    }else if(type == COMMON_CELL){
        [self.iconV setImage:image];
        [self.title setText:title];
    }else if(type == STICKER_CELL){
        CGSize size = self.bounds.size;
        CGFloat padding = 10.0f;
        CGFloat fDeltaWidth = size.width - 2*padding;
        CGFloat fDeltaHeight = fDeltaWidth;
        
        [self.iconV setFrame:CGRectMake((size.width - fDeltaWidth)/2, padding, fDeltaWidth, fDeltaHeight)];
        [self.title setFrame:CGRectMake((size.width - fDeltaWidth)/2, fDeltaHeight + (size.height - fDeltaHeight)/2, fDeltaWidth, 20.0f)];
        
        [self.iconV setImage:image];
        [self.title setText:title];
    }
}

@end
