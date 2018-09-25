//
//  StickerModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "StickerModel.h"

@implementation StickerModel
@synthesize stickName = _stickName;
@synthesize stickArray = _stickArray;

- (void)setStickers:(NSString *)name withArray:(NSMutableArray *)array{
    self.stickName = name;
    self.stickArray = array;
}

- (NSMutableArray *)stickArray{
    if(!_stickArray){
        _stickArray = [[NSMutableArray alloc] init];
    }
    return _stickArray;
}

@end
