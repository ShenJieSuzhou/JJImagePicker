//
//  HomeCubeModel.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCubeModel : NSObject

@property (nonatomic, copy) NSArray *path;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *work;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *likeNum;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *postTime;

- (instancetype)initWithPath:(NSArray *)path userid:(NSString *)userid work:(NSString *)work name:(NSString *)name like:(NSString *)likes avater:(NSString *)avater time:(NSString *)postTime;

@end

