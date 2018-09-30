//
//  TagModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel
@synthesize tagName = _tagName;

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    if(self){
        self.tagName = name;
        self.point = CGPointMake(0, 0);
        self.dircetion = TAG_DIRECTION_LEFT;
    }
    
    return self;
}

- (void)updateTagName:(NSString *)tagName{
    self.tagName = tagName;
}

@end
