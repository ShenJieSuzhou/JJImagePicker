//
//  UIImage+Mosaic.m
//
//  Created by cuihanxiu on 2017/7/26.
//

#import "UIImage+Mosaic.h"
//#import "UIView+Extension.h"

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r,g,b,a) ((a << 24) + (b << 16) + (g << 8) + r)

static NSInteger const kBitsPerComponent = 8;
//static NSInteger const kBitsPerPixel = 32;
static NSInteger const kPixelChannelCount = 4;

static UIColor *colorRGB(int r, int g, int b) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@implementation UIImage (Mosaic)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (unsigned char *)mosaicBitmapForImage:(UIImage *)image {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 kBitsPerComponent,
                                                 width * kPixelChannelCount,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData(context);
    size_t dataLength = kPixelChannelCount * width * height;
    unsigned char *bitmap_copy = (unsigned char *)malloc(kPixelChannelCount * width * height);
    memcpy(bitmap_copy, bitmapData, dataLength);
    if (context) {
        CGContextRelease(context);
    }
    if (colorSpace) {
        CGColorSpaceRelease(colorSpace);
    }
    
    return bitmap_copy;
}

+ (UIColor *)mosaicColorWithRGBA:(UInt32)rgba {
    UInt32 r = R(rgba);
    UInt32 g = G(rgba);
    UInt32 b = B(rgba);
    UInt32 a = A(rgba);
    return colorRGB(r,g,b);
}

+ (void)logBitmap:(unsigned char *)bitmap width:(long)width height:(long)height {
    UInt32 * currentPixel = (UInt32 *)bitmap;
    for (NSUInteger j = 0; j < height; j++) {
        for (NSUInteger i = 0; i < width; i++) {
            UInt32 color = *currentPixel;
            printf("%3.0f ", (R(color)+G(color)+B(color))/3.0);
            currentPixel++;
        }
        printf("\n");
    }
}

+ (UIImage *)mosaicResize:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIColor *)colorWithIntR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
