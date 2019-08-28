//
//  JJCommentDetailController.h
//  CommectProj
//
//  Created by shenjie on 2019/8/13.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTopicFrame.h"
#import "HttpRequestUtil.h"
#import "HttpRequestUrlDefine.h"
#import "JJTokenManager.h"
#import "GlobalDefine.h"
#import "JJPageInfo.h"
#import "JJCommentReplay.h"
#import "NSDate+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface JJCommentDetailController : UIViewController

@property (nonatomic, strong) JJTopicFrame *topicFrame;

@property (nonatomic, strong) JJPageInfo *currentPageInfo;

@end

NS_ASSUME_NONNULL_END
