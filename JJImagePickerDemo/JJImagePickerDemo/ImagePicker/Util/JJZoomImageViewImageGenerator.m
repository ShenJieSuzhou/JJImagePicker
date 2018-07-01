//
//  JJZoomImageViewImageGenerator.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/7/1.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJZoomImageViewImageGenerator.h"
#import "GlobalDefine.h"

#define kIconsColor UIColorMakeWithRGBA(255, 255, 255, .75)

@implementation JJZoomImageViewImageGenerator

+ (UIImage *)largePlayImage {
    CGFloat width = 60;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextInspectContext(context);
    
    UIColor *color = kIconsColor;
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    // circle outside
    CGContextSetFillColorWithColor(context, UIColorMakeWithRGBA(0, 0, 0, .25).CGColor);
    CGFloat circleLineWidth = 1;
    // consider line width to avoid edge clip
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(circleLineWidth / 2, circleLineWidth / 2, width - circleLineWidth, width - circleLineWidth)];
    [circle setLineWidth:circleLineWidth];
    [circle stroke];
    [circle fill];
    
    // triangle inside
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGFloat triangleLength = width / 2.5;
    UIBezierPath *triangle = [self trianglePathWithLength:triangleLength];
    UIOffset offset = UIOffsetMake(width / 2 - triangleLength * tan(M_PI / 6) / 2, width / 2 - triangleLength / 2);
    [triangle applyTransform:CGAffineTransformMakeTranslation(offset.horizontal, offset.vertical)];
    [triangle fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)smallPlayImage {
    // width and height are equal
    CGFloat width = 17;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextInspectContext(context);
    
    UIColor *color = kIconsColor;
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIBezierPath *path = [self trianglePathWithLength:width];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)pauseImage {
    CGSize size = CGSizeMake(12, 18);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextInspectContext(context);
    
    UIColor *color = kIconsColor;
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lineWidth = 2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(lineWidth / 2, 0)];
    [path addLineToPoint:CGPointMake(lineWidth / 2, size.height)];
    [path moveToPoint:CGPointMake(size.width - lineWidth / 2, 0)];
    [path addLineToPoint:CGPointMake(size.width - lineWidth / 2, size.height)];
    [path setLineWidth:lineWidth];
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


// @param length of the triangle side
+ (UIBezierPath *)trianglePathWithLength:(CGFloat)length {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(length * cos(M_PI / 6), length / 2)];
    [path addLineToPoint:CGPointMake(0, length)];
    [path closePath];
    return path;
}

@end
