//
//  PKMosaicDrawingboard.m
//
//  Created by cuihanxiu on 2017/7/26.
//

#import "PKMosaicDrawingboard.h"
#import "UIImage+Mosaic.h"
#import "PKMosaicImageView.h"
#import "UIView+MosaicExtension.h"
#import "MosaicBitmapData.h"

@interface PKMosaicPointModel : NSObject
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGFloat angle;
@end

@implementation PKMosaicPointModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _point = CGPointZero;
        _angle = 0;
    }
    return self;
}
@end

@interface PKMosaicDrawingboard () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *mosaicCoverView;
@property (nonatomic, strong) PKMosaicImageView *mosaicImageView;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGFloat currentScale;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *allMosaicsArray;
@property (nonatomic, strong) NSMutableArray *oneGroupOfMosaicArray;
@property (nonatomic, assign) NSInteger operationIndex;
@property (nonatomic, assign) CGFloat zoomingScale;
@property (nonatomic, strong) UIView *touchCircleView;
@property (nonatomic, assign) BOOL lastAble;
@property (nonatomic, assign) BOOL nextAble;
@property (nonatomic, assign) BOOL touching;
@property (nonatomic, assign) BOOL painting;
@property (nonatomic, strong) MosaicBitmapData *brushBitmapData;

@end

@implementation PKMosaicDrawingboard

- (void)dealloc {
    self.brushBitmapData = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lastPoint = CGPointMake(0, 0);
        _currentScale = 1;
        _zoomingScale = 1;
        _operationIndex = -1;
        _allMosaicsArray = NSMutableArray.array;
        [self setupViews:frame];
        [self setupEvents];
    }
    return self;
}

- (void)setupViews:(CGRect)frame {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.mosaicImageView];
    [self.scrollView addSubview:self.mosaicCoverView];
    [self.mosaicCoverView addSubview:self.touchCircleView];
    self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
}

- (void)setupEvents {
    __weak typeof(self) wself = self;
    self.mosaicImageView.touchesBeginBlock = ^(NSSet<UITouch *> *touches, UIEvent *event){
        if (wself.mosaicBrushImage == nil) return;
        wself.oneGroupOfMosaicArray = NSMutableArray.array;
        [NSObject cancelPreviousPerformRequestsWithTarget:wself selector:@selector(hideToucheCicle) object:nil];
        wself.touchCircleView.hidden = NO;
        wself.touching = YES;
        [wself addMosaicWithTouches:touches event:event];
    };
    
    self.mosaicImageView.touchesMovedBlock = ^(NSSet<UITouch *> *touches, UIEvent *event){
        if (wself.mosaicBrushImage == nil) return;
        [wself addMosaicWithTouches:touches event:event];
    };
    
    self.mosaicImageView.touchesEndedBlock = ^(NSSet<UITouch *> *touches, UIEvent *event){
        if (wself.mosaicBrushImage == nil) return;
        [wself performSelector:@selector(hideToucheCicle) withObject:nil afterDelay:0.1];
        wself.touching = NO;
        [wself addMosaicOperation];
        wself.lastPoint = CGPointZero;
    };
    
    self.mosaicImageView.touchesCancelledBlock = ^(NSSet<UITouch *> *touches, UIEvent *event){
        if (wself.mosaicBrushImage == nil) return;
        [wself performSelector:@selector(hideToucheCicle) withObject:nil afterDelay:0.1];
        wself.touching = NO;
        [wself addMosaicOperation];
        wself.lastPoint = CGPointZero;
    };
}

- (void)hideToucheCicle {
    self.touchCircleView.hidden = YES;
}

- (void)addMosaicWithTouches:(NSSet<UITouch *> *)touches event:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.mosaicImageView];
    CGFloat angle = 0;
    NSInteger count = 1;
    CGFloat distance = 0;
    NSArray *points = nil;
    if (self.lastPoint.x != 0) {
        angle = atan2(point.y - self.lastPoint.y,
                      point.x - self.lastPoint.x);
        distance = [self distanceFrom:self.lastPoint to:point] * self.zoomingScale;
        CGFloat perW = self.mosaicBrushImage.size.width * 0.5;
        if (distance > perW) {
            count = distance / perW + 1;
        }
        
    }
    points = [self groupPointsFrom:self.lastPoint to:point count:count angle:angle];
    
    for (PKMosaicPointModel *perPointModel in points) {
        CGPoint perPoint = perPointModel.point;
        CGFloat perAngle = perPointModel.angle;
        UIColor *toucheColor = [self.brushBitmapData colorWithPoint:CGPointMake(perPoint.x / self.currentScale, perPoint.y / self.currentScale)];
        UIImage *ref = [self.mosaicBrushImage imageWithTintColor:toucheColor];
        [self add:perPoint image:ref rotate:perAngle];
    }
    
    self.lastPoint = point;
    self.touchCircleView.center = CGPointMake(point.x * self.zoomingScale, point.y * self.zoomingScale);
}

- (void)add:(CGPoint)point image:(UIImage *)image rotate:(CGFloat)rotate {
    UIImageView *brushImageView = [self brushImageView];
    [self.mosaicImageView addSubview:brushImageView];
    brushImageView.frame = CGRectMake(0, 0, self.mosaicBrushImage.size.width, self.mosaicBrushImage.size.height);
    brushImageView.center = point;
    brushImageView.image = image;
    brushImageView.transform = CGAffineTransformMakeScale(1 / self.zoomingScale, 1 / self.zoomingScale);
    brushImageView.transform = CGAffineTransformRotate(brushImageView.transform, rotate);
    
    [self.oneGroupOfMosaicArray addObject:brushImageView];
}

- (UIImageView *)brushImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    return imageView;
}

- (void)mosaicCoverSizeToFit {
    self.mosaicCoverView.frame = self.mosaicImageView.frame;
}

#pragma mark - private mehods
- (void)addMosaicOperation {
    if (self.nextAble) {
        [self removeInvalidMosaic];
    }
    if (self.oneGroupOfMosaicArray) {
        [self.allMosaicsArray addObject:self.oneGroupOfMosaicArray];
    }
    self.operationIndex = [self getTailIndex];
    [self checkOperationState];
}

- (void)checkOperationState {
    self.lastAble = (self.operationIndex >= 0);
    self.nextAble = (self.operationIndex  < (NSInteger)(self.allMosaicsArray.count - 1));
}

- (void)removeInvalidMosaic {
    if (self.operationIndex >= [self getTailIndex]) {
        return;
    }
    [self.allMosaicsArray removeLastObject];
    [self removeInvalidMosaic];
}

- (NSInteger)getTailIndex {
    return self.allMosaicsArray.count - 1;
}

- (void)clean {
    self.painting = NO;
    [self.allMosaicsArray enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj) [obj makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
    [self.allMosaicsArray removeAllObjects];
    self.nextAble = NO;
    self.lastAble = NO;
    self.oneGroupOfMosaicArray = nil;
    self.lastPoint = CGPointMake(0, 0);
    self.operationIndex = -1;
    
    self.scrollView.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.mosaicImageView.userInteractionEnabled = NO;
}

- (UIImage *)screenOriginRectImage {
    CGSize size = self.mosaicImageView.image.size;
    CGRect originRect = self.mosaicImageView.frame;
    CGFloat wScale = (size.width / originRect.size.width) ?: 1;
    CGFloat hScale = (size.height / originRect.size.height) ?: 1;
    [self.mosaicImageView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            obj.bounds = CGRectMake(0, 0, obj.bounds.size.width * wScale, obj.bounds.size.height * hScale);
            obj.center = CGPointMake(obj.center.x * wScale, obj.center.y * hScale);
        }
    }];
    self.mosaicImageView.frame = CGRectMake(originRect.origin.x, originRect.origin.y, size.width, size.height);
    [self.mosaicImageView layoutIfNeeded];
    UIImage *screenImage = [self.mosaicImageView screenshotRender];
    self.mosaicImageView.frame = originRect;
    return screenImage;
}

- (CGFloat)distanceFrom:(CGPoint)from to:(CGPoint)to {
    return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y));
}

- (NSArray *)groupPointsFrom:(CGPoint)from to:(CGPoint)to count:(NSInteger)count angle:(CGFloat)angle {
    PKMosaicPointModel *(^makePointModelBlock)(CGPoint, CGFloat) = ^PKMosaicPointModel *(CGPoint point, CGFloat b_angle){
        PKMosaicPointModel *pm = [[PKMosaicPointModel alloc] init];
        pm.point = point;
        pm.angle = b_angle;
        return pm;
    };
    NSMutableArray *points = NSMutableArray.array;
    if (count <= 1) {
        [points addObject:makePointModelBlock(to, angle)];
    } else {
        CGFloat w = (to.x - from.x);
        CGFloat h = (to.y - from.y);
        CGFloat xMargin = w / (count - 1);
        CGFloat yMargin = h / (count - 1);
        for (NSInteger i = 0; i < count; i++) {
            [points addObject:makePointModelBlock(CGPointMake(from.x + xMargin * i, from.y + yMargin * i), angle)];
        }
    }
    return points.copy;
}


#pragma mark - public methods
- (void)setImage:(UIImage *)image {
    _image = image;
    if (!image) return;
    CGFloat maxHeight = self.bounds.size.height;
    CGFloat maxWidth = self.bounds.size.width;
    CGSize imgSize = image.size;
    if (imgSize.width == 0 || imgSize.height == 0) {
        return;
    }
    BOOL fitHeightOrWidth = NO;
    CGFloat scale = 1;
    scale =  maxHeight / imgSize.height;
    CGFloat renderWidth = imgSize.width * scale;
    CGFloat renderHeight = imgSize.height * scale;
    
    fitHeightOrWidth = renderWidth < maxWidth;
    if (fitHeightOrWidth == NO) {
        scale = maxWidth / imgSize.width;
        renderWidth = imgSize.width * scale;
        renderHeight = imgSize.height * scale;
        
    }
    CGSize renderSize = CGSizeMake(renderWidth, renderHeight);
    
    self.mosaicImageView.image = image;
    self.mosaicImageView.size = renderSize;
    self.mosaicImageView.centerX = maxWidth * 0.5;
    self.mosaicImageView.centerY = maxHeight * 0.5;
    self.currentScale = scale;
    [self mosaicCoverSizeToFit];
    self.brushBitmapData = [[MosaicBitmapData alloc] initWithImage:image];
}

- (void)setMosaicBrushImage:(UIImage *)mosaicBrushImage {
    _mosaicBrushImage = mosaicBrushImage;
    CGFloat width = mosaicBrushImage.size.width;
    self.touchCircleView.layer.cornerRadius = width * 0.5;
    self.touchCircleView.size = CGSizeMake(width, width);
}

- (void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;
    self.scrollView.userInteractionEnabled = scrollEnable;
}

- (void)beginPaint {
    if (self.image == nil) return;
    self.painting = YES;
    self.scrollView.panGestureRecognizer.minimumNumberOfTouches = 2;
    self.mosaicImageView.userInteractionEnabled = YES;
}

- (UIImage *)compeletePaint {
    [self.scrollView setZoomScale:1.0];
    self.zoomingScale = 1;
    UIImage *image = [self screenOriginRectImage];
    self.image = image;
    [self clean];
    return image;
}

- (void)cancelPaint {
    [self clean];
}

- (void)last {
    if (!self.lastAble) return;
    NSMutableArray<UIImageView *> *oneGroupOfMosaic = [self.allMosaicsArray objectAtIndex:self.operationIndex];
    [oneGroupOfMosaic makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.operationIndex--;
    [self checkOperationState];
}

- (void)next {
    if (!self.nextAble) return;
    self.operationIndex++;
    NSMutableArray<UIImageView *> *oneGroupOfMosaic = [self.allMosaicsArray objectAtIndex:self.operationIndex];
    __weak typeof(self) wself = self;
    [oneGroupOfMosaic enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) [wself.mosaicImageView addSubview:obj];
    }];
    [self checkOperationState];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mosaicImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    CGFloat xInset = view.frame.origin.x > 0 ? view.frame.origin.x * 2 : 0;
    scrollView.contentSize = CGSizeMake(xInset + view.frame.size.width, scrollView.contentSize.height);
    self.zoomingScale = scale;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGSize boundsSize = self.scrollView.size;
    CGRect frameToCenter = self.mosaicImageView.frame;
    // horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        // 向下取整
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    self.mosaicImageView.frame = frameToCenter;
    [self mosaicCoverSizeToFit];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bouncesZoom = NO;
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 10;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (PKMosaicImageView *)mosaicImageView {
    if (!_mosaicImageView) {
        _mosaicImageView = [[PKMosaicImageView alloc] init];
        _mosaicImageView.userInteractionEnabled = NO;
        _mosaicImageView.layer.masksToBounds = YES;
    }
    return _mosaicImageView;
}

- (UIImageView *)mosaicCoverView {
    if (!_mosaicCoverView) {
        _mosaicCoverView = [[UIImageView alloc] init];
    }
    return _mosaicCoverView;
}

- (UIView *)touchCircleView {
    if (!_touchCircleView) {
        _touchCircleView = [[UIView alloc] init];
        _touchCircleView.layer.borderWidth = 2.0;
        _touchCircleView.layer.borderColor = [UIColor whiteColor].CGColor;
        _touchCircleView.layer.masksToBounds = YES;
        _touchCircleView.hidden = YES;
    }
    return _touchCircleView;
}

@end
