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

- (void)renderImage:(NSString *)filterName image:(UIImage *)image withBlock:(jjFilterRenderBlock)block{
    _renderBlock = block;
    [m_instance addFilterToImage:filterName withImage:image];
}

- (void)addFilterToImage:(NSString *)filterName withImage:(UIImage *)image{
    if([filterName isEqualToString:@"CLDefaultEmptyFilter"]){
        _renderBlock(image);
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
    
    _renderBlock(result);
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
