//
//  Works.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/27.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "Works.h"

@implementation Works

- (instancetype)initWithPath:(NSArray *)path photoID:(NSString *)photoID userid:(NSString *)userid work:(NSString *)work{
    self = [super init];
    if(self){
        self.path = [path copy];
        self.photoid = photoID;
        self.userid = userid;
        self.work = work;
    }
    return self;
}

@end
