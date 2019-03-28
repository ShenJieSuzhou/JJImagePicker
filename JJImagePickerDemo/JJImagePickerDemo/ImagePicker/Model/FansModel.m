//
//  FansModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/28.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "FansModel.h"

@implementation FansModel
//@synthesize iconUrl = _iconUrl;

- (instancetype)initWithUser:(NSString *)userid name:(NSString *)userName iconUrl:(NSString *)iconUrl{
    self = [super init];
    if(self){
        self.userId = [userid copy];
        self.userName = [userName copy];
        self.iconUrl = [iconUrl copy];
    }
    return self;
    
}

@end
