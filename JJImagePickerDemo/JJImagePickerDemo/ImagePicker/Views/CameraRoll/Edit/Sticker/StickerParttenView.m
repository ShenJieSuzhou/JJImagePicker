//
//  StickerParttenView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "StickerParttenView.h"

@implementation StickerParttenView
@synthesize sticker = _sticker;

- (instancetype)initWithFrame:(CGRect)frame sticker:(UIImage *)pasterImage{
    self = [super initWithFrame:frame];
    self.sticker = pasterImage;
    return self;
}

- (void)deleteTheSticker{
    
}

- (void)showDelAndMoveBtn{
    
}

- (void)hideDelAndMoveBtn{
    
}


@end
