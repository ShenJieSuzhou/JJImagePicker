//
//  WelocomePageController.h
//  JJImagePickerDemo
//
//  Created by silicon on 2019/5/8.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelocomePageController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *guideScrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

