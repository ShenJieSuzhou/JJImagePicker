//
//  JJPageInfo.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/2.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJPageInfo : NSObject

@property (assign, nonatomic) int totalPage;         //总页数
@property (assign, nonatomic) int pageSize;          //页大小
@property (assign, nonatomic) int currentPage;        //当前页

- (BOOL)parseData:(NSDictionary *)data;

@end
