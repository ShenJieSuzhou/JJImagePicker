//
//  JJUser.m
//  CommectProj
//
//  Created by shenjie on 2019/8/8.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJUser.h"

@implementation JJUser
@synthesize userId = _userId;
@synthesize nickname = _nickname;
@synthesize avatarUrl = _avatarUrl;

- (id)init{
    self = [super init];
    if(self){
        self.userId = @"";
        self.nickname = @"";
        self.avatarUrl = @"";
    }
    
    return self;
}

@end
