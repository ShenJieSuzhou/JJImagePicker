//
//  ScrawlModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ScrawlModel.h"

@implementation ScrawlModel
@synthesize patternName = _patternName;

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    if(self){
        self.patternName = name;
    }
    
    return self;
}


@end
