//
//  JJImagePickerHelper.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJImagePickerHelper.h"

NSString *const JJSpringAnimationKey = @"JJSpringAnimationKey";

@implementation JJImagePickerHelper

+ (void)actionSpringAnimationForView:(UIView *)view{
    NSTimeInterval duration = 0.6;
    CAKeyframeAnimation *springAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    springAnimation.values = @[@.85, @1.15, @.9, @1.0,];
    springAnimation.keyTimes = @[@(0.0 / duration), @(0.15 / duration) , @(0.3 / duration), @(0.45 / duration),];
    springAnimation.duration = duration;
    [view.layer addAnimation:springAnimation forKey:JJSpringAnimationKey];
}

+ (void)removeactionSpringAnimationForView:(UIView *)view{
    [view.layer removeAnimationForKey:JJSpringAnimationKey];
}

+ (void)startLoadingAnimation:(UIView *)baseView{
    UIView *view = [[UIView alloc] initWithFrame:baseView.bounds];
    [view setTag:8090];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    indicator.color = [UIColor colorWithRed:248.0f green:201.0f blue:65.0f alpha:1.0f];
    [indicator setTag:8091];
    [indicator setFrame:CGRectMake((baseView.frame.size.width - 100) / 2, (baseView.frame.size.height - 100) / 2, 100, 100)];
    [view addSubview:indicator];
    [baseView addSubview:view];
    [indicator startAnimating];
}

+ (void)stopLoadingAnimation:(UIView *)baseView{
    UIView *view = [baseView viewWithTag:8090];
    UIActivityIndicatorView *indicator = [view viewWithTag:8091];
    [indicator stopAnimating];
    [indicator removeFromSuperview];
    [view removeFromSuperview];
}


@end
