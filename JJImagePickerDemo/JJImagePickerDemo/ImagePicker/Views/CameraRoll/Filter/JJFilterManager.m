//
//  JJFilterManager.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/6.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJFilterManager.h"
#import <CoreImage/CoreImage.h>
static JJFilterManager *m_instance = nil;

@implementation JJFilterManager
@synthesize renderBlock = _renderBlock;

+ (JJFilterManager *)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[JJFilterManager alloc] init];
    });
    
    return m_instance;
}

- (UIImage *)renderImage:(NSString *)filterName image:(UIImage *)image{
    return [m_instance addFilterToImage:filterName withImage:image];
}

- (UIImage *)addFilterToImage:(NSString *)filterName withImage:(UIImage *)image{
    if([filterName isEqualToString:@"CLDefaultEmptyFilter"]){
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    
    //NSLog(@"%@", [filter attributes]);
    
    [filter setDefaults];
    
    if([filterName isEqualToString:@"CIVignetteEffect"]){
        // parameters for CIVignetteEffect
        CGFloat R = MIN(image.size.width, image.size.height)*image.scale/2;
        CIVector *vct = [[CIVector alloc] initWithX:image.size.width*image.scale/2 Y:image.size.height*image.scale/2];
        [filter setValue:vct forKey:@"inputCenter"];
        [filter setValue:[NSNumber numberWithFloat:0.9] forKey:@"inputIntensity"];
        [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
    }
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}

- (UIImage *)renderImageWithBeauty:(UIImage *)image inputAmount:(CGFloat)amount{
    if(!image){
        NSLog(@"renderImage nil");
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"YUCIHighPassSkinSmoothing" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:8.0f] forKey:kCIInputRadiusKey];
    [filter setValue:[NSNumber numberWithFloat:amount] forKey:@"inputAmount"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    return result;
}

- (UIImage *)renderImageWithExposure:(UIImage *)image inputAmount:(CGFloat)amount{
    if(!image){
        NSLog(@"renderImage nil");
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:[NSNumber numberWithFloat:amount] forKey:@"inputEV"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    return result;
}

- (UIImage *)renderImageWithTemperature:(UIImage *)image inputAmount:(CGFloat)amount{
    if(!image){
        NSLog(@"renderImage nil");
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CITemperatureAndTint" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:[CIVector vectorWithX:6500 Y:0] forKey:@"inputTargetNeutral"];
    [filter setValue:[CIVector vectorWithX:amount Y:0] forKey:@"inputNeutral"];

    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];

    UIImage *result = [UIImage imageWithCGImage:cgImage];

    CGImageRelease(cgImage);
    
    return result;
}

- (UIImage *)renderImageWithContrast:(UIImage *)image inputAmount:(CGFloat)amount{
    if(!image){
        NSLog(@"renderImage nil");
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputSaturation"];
    [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputContrast"];
    [filter setValue:[NSNumber numberWithFloat:amount] forKey:@"inputBrightness"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    return result;
}


- (UIImage *)renderImageWithSaturation:(UIImage *)image inputAmount:(CGFloat)amount{
    if(!image){
        NSLog(@"renderImage nil");
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIVibrance" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:[NSNumber numberWithFloat:amount] forKey:@"inputAmount"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    return result;
}

- (UIImage *)renderImageWithSharpen:(UIImage *)image inputAmount:(CGFloat)amount{
    if(!image){
        NSLog(@"renderImage nil");
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CISharpenLuminance" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:[NSNumber numberWithFloat:amount] forKey:@"inputSharpness"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    return result;
}

- (UIImage *)renderImageWithDarkangle:(UIImage *)image inputAmount:(CGFloat)amount{
    if(!image){
        NSLog(@"renderImage nil");
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIVignette" keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputRadius"];
    [filter setValue:[NSNumber numberWithFloat:amount] forKey:@"inputIntensity"];
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    return result;
}

- (NSArray *)getFiltersArray{
    return @[
             @{@"name":@"CLDefaultEmptyFilter",     @"title":@"原图", @"placeholder":@"filterDemo",    @"version":@(0.0)},
             @{@"name":@"CISRGBToneCurveToLinear",  @"title":@"暮光", @"placeholder":@"filterDemo",    @"version":@(7.0)},
             @{@"name":@"CIVignetteEffect",         @"title":@"LOMO",@"placeholder":@"filterDemo",   @"version":@(7.0)},
             @{@"name":@"CIPhotoEffectInstant",     @"title":@"流年", @"placeholder":@"filterDemo",   @"version":@(7.0)},
             @{@"name":@"CIPhotoEffectProcess",     @"title":@"雪青", @"placeholder":@"filterDemo",   @"version":@(7.0)},
             @{@"name":@"CIPhotoEffectTransfer",    @"title":@"优格", @"placeholder":@"filterDemo",  @"version":@(7.0)},
             @{@"name":@"CISepiaTone",              @"title":@"晚秋", @"placeholder":@"filterDemo",     @"version":@(5.0)},
             @{@"name":@"CIPhotoEffectChrome",      @"title":@"淡雅", @"placeholder":@"filterDemo",    @"version":@(7.0)},
             @{@"name":@"CIPhotoEffectFade",        @"title":@"拿铁", @"placeholder":@"filterDemo",      @"version":@(7.0)},
             @{@"name":@"CILinearToSRGBToneCurve",  @"title":@"丽日", @"placeholder":@"filterDemo",     @"version":@(7.0)},
             @{@"name":@"CIPhotoEffectTonal",       @"title":@"灰度", @"placeholder":@"filterDemo",     @"version":@(7.0)},
             @{@"name":@"CIPhotoEffectNoir",        @"title":@"暗调", @"placeholder":@"filterDemo",      @"version":@(7.0)},
             @{@"name":@"CIPhotoEffectMono",        @"title":@"黑白", @"placeholder":@"filterDemo",      @"version":@(7.0)},
             @{@"name":@"CIColorInvert",            @"title":@"负片", @"placeholder":@"filterDemo",    @"version":@(6.0)},
             ];
}

@end
