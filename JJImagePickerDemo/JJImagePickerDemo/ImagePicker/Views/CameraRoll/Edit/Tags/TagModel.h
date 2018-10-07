//
//  TagModel.h
//  testTag
//
//  Created by silicon on 2018/10/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject

@property (assign) NSInteger tagID;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithID:(NSInteger) mId Name:(NSString *)name;

@end
