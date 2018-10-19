//
//  UIImage+Mosaic.h
//
//  Created by cuihanxiu on 2017/7/26.
//

#import <UIKit/UIKit.h>

@interface UIImage (Mosaic)

+ (UIImage *)mosaicResize:(UIImage *)image scaleToSize:(CGSize)size;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
+ (UIColor *)mosaicColorWithRGBA:(UInt32)rgba;
+ (unsigned char *)mosaicBitmapForImage:(UIImage *)image;
+ (void)logBitmap:(unsigned char *)bitmap width:(long)width height:(long)height;
@end

