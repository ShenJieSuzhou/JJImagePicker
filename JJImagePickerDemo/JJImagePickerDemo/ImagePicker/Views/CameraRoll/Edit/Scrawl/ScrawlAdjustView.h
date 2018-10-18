//
//  ScrawlAdjustView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSlider.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScrawlAdjustView : UIView<CustomSliderDelegate>
@property (nonatomic, strong) NSString *mTitle;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIButton *confirmBtn;
@property (nonatomic, strong) CustomSlider *stoolSlider;

@end

NS_ASSUME_NONNULL_END
