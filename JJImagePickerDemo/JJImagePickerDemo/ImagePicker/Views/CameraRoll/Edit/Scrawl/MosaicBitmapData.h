//
//  PKBitmapData.h
//
//  Created by cuihanxiu on 2017/8/1.
//

#import <UIKit/UIKit.h>

@interface MosaicBitmapData : NSObject
- (instancetype)initWithImage:(UIImage *)image;

- (UIColor *)colorWithPoint:(CGPoint)point;
@end
