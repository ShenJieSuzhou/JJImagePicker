//
//  JJFilterManager.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/6.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^jjFilterRenderBlock)(UIImage *image);

@interface JJFilterManager : NSObject

@property (nonatomic, weak) jjFilterRenderBlock renderBlock;

+ (JJFilterManager *)getInstance;
- (UIImage *)renderImage:(NSString *)filterName image:(UIImage *)image;
- (UIImage *)renderImageWithBeauty:(UIImage *)image inputAmount:(CGFloat)amount;
- (UIImage *)renderImageWithExposure:(UIImage *)image inputAmount:(CGFloat)amount;
- (UIImage *)renderImageWithTemperature:(UIImage *)image inputAmount:(CGFloat)amount;
- (UIImage *)renderImageWithSaturation:(UIImage *)image inputAmount:(CGFloat)amount;

- (NSArray *)getFiltersArray;
@end
