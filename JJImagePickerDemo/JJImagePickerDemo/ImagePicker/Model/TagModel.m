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
    }
    
    return self;
}

- (void)updateTagName:(NSString *)tagName{
    self.tagName = tagName;
}

@end
