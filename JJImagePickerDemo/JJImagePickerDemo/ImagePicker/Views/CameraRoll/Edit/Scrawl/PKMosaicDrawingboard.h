//
//  PKMosaicDrawingboard.h
//
//  Created by cuihanxiu on 2017/7/26.
//

#import <UIKit/UIKit.h>

@interface PKMosaicDrawingboard : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *mosaicBrushImage;
@property (nonatomic, assign, readonly) BOOL lastAble;
@property (nonatomic, assign, readonly) BOOL nextAble;
@property (nonatomic, assign, readonly) BOOL touching;
@property (nonatomic, assign, readonly) BOOL painting;
@property (nonatomic, assign) BOOL scrollEnable;

- (void)beginPaint;
- (UIImage *)compeletePaint;
- (void)cancelPaint;
- (void)last;
- (void)next;
@end
