//
//  Works.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/12/27.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Works : NSObject

@property (nonatomic, copy) NSArray *path;

@property (nonatomic, copy) NSString *photoid;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *work;

@property (nonatomic, copy) NSString *postTime;

@property (nonatomic, copy) NSString *likeNum;

@property (assign) BOOL hasLiked;

- (instancetype)initWithPath:(NSArray *)path photoID:(NSString *)photoID userid:(NSString *)userid work:(NSString *)work time:(NSString *)postTime like:(NSString *)likes hasLiked:(BOOL)hasLiked;


@end


