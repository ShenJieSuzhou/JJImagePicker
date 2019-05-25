//
//  kindWarming.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class kindWarming;
@protocol kindWarmingDelegate <NSObject>

- (void)showUserItem:(kindWarming *)view;

- (void)showPrivacy:(kindWarming *)view;

@end

@interface kindWarming : UIView

@property (weak, nonatomic) id<kindWarmingDelegate> delegate;

+(instancetype)getInstance;

@end

