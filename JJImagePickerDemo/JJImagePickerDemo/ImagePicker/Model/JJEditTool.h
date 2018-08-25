//
//  JJEditTool.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger{
    JJEditToolCrop,
    JJEditToolAdjust,
    JJEditToolFilter,
    JJEditToolSticker,
    JJEditToolWords,
    JJEditToolBrush,
    JJEditToolTag,
    JJEditToolscrawl
} JJEditToolType;

@interface JJEditTool : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSMutableArray *subToolArrays;
@property (assign) JJEditToolType jjToolType;

- (instancetype)initWithName:(NSString *)name
                        path:(NSString *)imagePath
                        type:(JJEditToolType)toolType
                       array:(NSMutableArray *)subTools;

@end
