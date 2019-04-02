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

-(BOOL)parseData:(NSDictionary *)data
{
    if (![data isKindOfClass:[NSDictionary class]]) return FALSE;
    self.totalPage = [JJDataParaseUtil getDataAsInt:[data objectForKey:@"page_count"]];
    self.pageSize = [JJDataParaseUtil getDataAsInt:[data objectForKey:@"limit"]];
    self.currentPage = [JJDataParaseUtil getDataAsInt:[data objectForKey:@"page"]];
    return TRUE;
}

@end
