//
//  StickerModel.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StickerModel : NSObject

@property (strong, nonatomic) NSString *stickName;

@property (strong, nonatomic) NSMutableArray *stickArray;

- (void)setStickers:(NSString *)name withArray:(NSMutableArray *)array;

@end
