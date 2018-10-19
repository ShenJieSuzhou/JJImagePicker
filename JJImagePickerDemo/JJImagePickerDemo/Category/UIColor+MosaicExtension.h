//
//  UIColor+Extension.h
//

#import <UIKit/UIKit.h>

@interface UIColor (MosaicExtension)

+ (UIColor *)randomColor;
+ (UIColor *)colorWithHexString:(NSString *)hexStr;
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end
