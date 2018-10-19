//
//  UIColor+Extension.h
//

#import "UIColor+MosaicExtension.h"

@implementation UIColor (MosaicExtension)

+ (UIColor *)randomColor
{
    CGFloat x = (CGFloat)(1 + arc4random() % 100) / 100 ;
    CGFloat y = (CGFloat)(1 + arc4random() % 100) / 100 ;
    CGFloat z = (CGFloat)(1 + arc4random() % 100) / 100 ;
    return [self colorWithRed:x green:y blue:z alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr
{
    return [self colorWithHexString:hexStr alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    if (!hexStr || [hexStr isEqualToString:@""]) {
        return nil;
    }
    NSAssert(hexStr.length == 7, @"颜色长度不等于7");
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255. green:green/255. blue:blue/255. alpha:alpha];
    return color;
}

@end
