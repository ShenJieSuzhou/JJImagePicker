//
//  SelectedListModel.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/30.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "SelectedListModel.h"

@implementation SelectedListModel

- (instancetype)initWithSid:(NSInteger)sid
                      Title:(NSString *)title{
    
    return [[SelectedListModel alloc] initWithSid:sid Title:title Context:nil];
}

- (instancetype)initWithSid:(NSInteger)sid
                      Title:(NSString *)title
                    Context:(id)context{
    
    self = [super init];
    
    if (self) {
        
        _sid = sid;
        
        _title = title;
        
        _context = context;
    }
    
    return self;
}

@end
