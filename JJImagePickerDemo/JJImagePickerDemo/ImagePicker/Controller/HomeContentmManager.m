//
//  HomeContentmManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "HomeContentmManager.h"

@interface HomeContentmManager()
@property (nonatomic, strong) NSMutableArray *homeDataArray;
@end

@implementation HomeContentmManager

static HomeContentmManager *m_instance = nil;
+ (HomeContentmManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[HomeContentmManager alloc] init];
        m_instance.homeDataArray = [[NSMutableArray alloc] init];
    });
    
    return m_instance;
}

- (void)setHomeContent:(NSDictionary *)dic{
    [m_instance.homeDataArray addObject:dic];
}

- (NSMutableArray *)getHomeContent{
    return m_instance.homeDataArray;
}

@end
