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

@property (nonatomic, copy) NSString *photoId;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *work;

@property (nonatomic, copy) NSString *name;

@property (assign) int likeNum;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *postTime;

@property (assign) BOOL hasLiked;

- (instancetype)initWithPath:(NSArray *)path photoId:(NSString *)photoId userid:(NSString *)userid work:(NSString *)work name:(NSString *)name like:(int)likes avater:(NSString *)avater time:(NSString *)postTime hasLiked:(BOOL)hasLiked;

@end

