//
//  JJPageInfo.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/2.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJPageInfo.h"
#import "JJDataParaseUtil.h"

@implementation JJPageInfo

- (instancetype)initWithTotalPage:(int)totalPage size:(int)pageSize currentPage:(int)currentPage{
    self = [super init];
    if(self){
        self.totalPage = totalPage;
        self.pageSize = pageSize;
        self.currentPage = currentPage;
    }
    return self;
}

@end
