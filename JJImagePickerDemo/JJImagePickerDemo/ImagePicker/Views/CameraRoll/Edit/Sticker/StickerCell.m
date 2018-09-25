//
//  StickerCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/21.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "StickerCell.h"

@implementation StickerCell
@synthesize stickerName = _stickerName;
@synthesize imgView = _imgView;

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

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)commonInitlization{
    CGFloat padding = 10.0f;
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, self.frame.size.width - padding*2, self.frame.size.height - padding*2)];
    [self addSubview:self.imgView];
}

- (void)updateStickerImage:(NSString *)name{
    UIImage *sticker = [UIImage imageNamed:name];
    [self.imgView setImage:sticker];
}


@end
