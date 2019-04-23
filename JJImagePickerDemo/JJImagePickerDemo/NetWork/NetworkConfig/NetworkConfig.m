//
//  NetworkConfig.m
//  NextQueen
//
//  Created by pcjbird on 15/3/5.
//  Copyright (c) 2015年 SnailGames. All rights reserved.
//

#import "NetworkConfig.h"


@implementation NetworkConfig
static NetworkConfig* _sharedConfig = nil;

+ (NetworkConfig *)sharedConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedConfig) {
            if (!_sharedConfig) _sharedConfig=[[NetworkConfig alloc] init];
        }
    });
    return _sharedConfig;
}

-(NetStatus) getNetStatus
{
    NetStatus netType = NetStatus_None;
    switch (self.status)
    {
        case NotReachable:
            netType = NetStatus_None;
            break;
        case ReachableVia2G:
            netType = NetStatus_2G;
            break;
        case ReachableViaWWAN:
            netType = NetStatus_3G;
            break;
        case ReachableViaWiFi:
            netType = NetStatus_WIFI;
            break;
        default:
            netType = 10000;
            break;
    }
       return netType;
}
@end
