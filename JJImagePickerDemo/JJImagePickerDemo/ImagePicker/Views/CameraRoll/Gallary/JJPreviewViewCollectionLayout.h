//
//  JJPreviewViewCollectionLayout.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJPreviewViewCollectionLayout : UICollectionViewFlowLayout

//翻页的滚动速度,超过该速度就强制翻页。默认速度为 0.4
@property (nonatomic, assign) CGFloat velocityForPageDown;

//是否支持可以滑动多个 item
@property (nonatomic, assign) BOOL allowMultipleItemScroll;

/*
 * 当支持一次滑动允许滚动多个 item 的时候，滑动速度要达到多少才会滚动多个 item，默认为 0.7
 * allowMultipleItemScroll 为 YES 时生效
 */
@property(nonatomic, assign) CGFloat multipleItemScrollVelocityLimit;



@end
