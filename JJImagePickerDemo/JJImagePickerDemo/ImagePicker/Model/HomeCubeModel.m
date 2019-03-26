//
//  HomeCubeModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomeCubeModel.h"

@implementation HomeCubeModel

- (instancetype)initWithPath:(NSArray *)path userid:(NSString *)userid work:(NSString *)work name:(NSString *)name like:(NSString *)likes avater:(NSString *)avater time:(NSString *)postTime{
    self = [super init];
    if(self){
        self.path = [path copy];
        self.userid = [userid copy];
        self.work = [work copy];
        self.name = [name copy];
        self.likeNum = [likes copy];
        self.iconUrl = [avater copy];
        self.postTime = [postTime copy];
    }
    return self;
}

@end
