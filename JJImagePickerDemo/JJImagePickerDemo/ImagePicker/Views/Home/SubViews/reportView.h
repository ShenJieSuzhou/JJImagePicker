//
//  reportView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/29.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol reportViewDelegate

- (void)clickTipOffCallBack;

- (void)clickPullBlackCallBack;

@end

@interface reportView : UIView

@property (weak, nonatomic) id<reportViewDelegate> delegate;

+(instancetype)getInstance;

@end

