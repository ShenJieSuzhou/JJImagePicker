//
//  NetworkConfig.h
//  NextQueen
//
//  Created by pcjbird on 15/3/5.
//  Copyright (c) 2015年 SnailGames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef enum
{
   NetStatus_None = 0,
   NetStatus_2G,
   NetStatus_3G,
   NetStatus_4G,
   NetStatus_WIFI = 5,
}NetStatus;

@interface NetworkConfig : NSObject

@property(nonatomic, assign) NetworkStatus status;

+ (NetworkConfig *) sharedConfig;

-(NetStatus) getNetStatus;

@end
