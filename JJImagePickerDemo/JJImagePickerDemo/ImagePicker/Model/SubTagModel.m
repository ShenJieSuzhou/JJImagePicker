//
//  TagModel.m
//  testTag
//
//  Created by silicon on 2018/10/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "SubTagModel.h"

@implementation SubTagModel
@synthesize name = _name;
@synthesize tagID = _tagID;

-(instancetype)initWithID:(NSInteger)mId Name:(NSString *)name{
    if(self = [super init]){
        self.tagID = mId;
        self.name = name;
    }
    return self;
}

@end
