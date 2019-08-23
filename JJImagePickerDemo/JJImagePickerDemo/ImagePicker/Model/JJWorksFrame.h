//
//  JJWorksFrame.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/8/22.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HomeCubeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JJWorksFrame : NSObject

/** 头像frame */
@property (nonatomic, assign) CGRect avatarFrame;

@property (nonatomic, assign) CGRect focusFrame;

/** 昵称frame */
@property (nonatomic, assign) CGRect nicknameFrame;

/** 更多frame */
@property (nonatomic, assign) CGRect moreFrame;

/** 点赞frame */
@property (nonatomic, assign) CGRect likeFrame;

/** 点赞数frame */
@property (nonatomic, assign) CGRect likeNumFrame;

/** 时间frame */
@property (nonatomic, assign ) CGRect createTimeFrame;

/** 内容frame */
@property (nonatomic, assign) CGRect worksFrame;

/** 内容frame */
@property (nonatomic, assign) CGRect textFrame;

/** height 这里只是 整个话题占据的高度 */
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) BOOL isEven;

@property (assign) NSInteger albumRows;
@property (assign) NSInteger albumColums;

/** 模型 */
@property (nonatomic, strong) HomeCubeModel *workModel;



@end

NS_ASSUME_NONNULL_END
