//
//  JJEditTool.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJEditTool.h"

@implementation JJEditTool
@synthesize name = _name;
@synthesize imagePath = _imagePath;
@synthesize subToolArrays = _subToolArrays;
@synthesize jjToolType = _jjToolType;

- (instancetype)initWithName:(NSString *)name
                        path:(NSString *)imagePath
                        type:(JJEditToolType)toolType
                       array:(NSMutableArray *)subTools{
    
    if(self = [super init]){
        self.name = name;
        self.imagePath = imagePath;
        self.jjToolType = toolType;
        self.subToolArrays = subTools;
    }
    
    return self;
}


@end
