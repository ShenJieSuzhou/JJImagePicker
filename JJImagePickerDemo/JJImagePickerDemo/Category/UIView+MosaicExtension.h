#import <UIKit/UIKit.h>

@interface UIView (MasaicExtension)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (UIImage*)screenshot;
- (UIImage*)screenshotRender;

@end
