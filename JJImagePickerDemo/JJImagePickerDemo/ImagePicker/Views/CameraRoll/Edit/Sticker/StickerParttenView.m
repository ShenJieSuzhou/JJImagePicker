//
//  StickerParttenView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "StickerParttenView.h"

#define STICKER_BTN_WIDTH 24.0f
#define STICKER_BTN_HEIGHT 24.0f
#define STICKER_DEFAULT_HEIGHT self.frame.size.width - STICKER_BTN_WIDTH
#define STICKER_DEFAULT_WIDTH self.frame.size.width - STICKER_BTN_WIDTH
#define PADDING 12.0f
#define MIN_WIDTH self.frame.size.width / 2
#define MIN_HEIGHT self.frame.size.height / 2
#define STICKER_MAX_HEIGHT 180
#define STICKER_MAX_WIDTH 180
#define SECURITY_BREADTH 60

@implementation StickerParttenView
@synthesize sticker = _sticker;
@synthesize deleteImageView = _deleteImageView;
@synthesize scaleImageView = _scaleImageView;
@synthesize stickerImageView = _stickerImageView;
@synthesize stickPtDelgate = _stickPtDelgate;

@synthesize prevMovePoint = _prevMovePoint;
@synthesize deltaAngle = _deltaAngle;
@synthesize touchStart = _touchStart;
@synthesize bgRect = _bgRect;
@synthesize minH = _minH;
@synthesize minW = _minW;

@synthesize isHide = _isHide;

- (instancetype)initWithFrame:(CGRect)frame sticker:(UIImage *)pasterImage{
    self = [super initWithFrame:frame];
    if(self){
        self.sticker = pasterImage;
        self.isHide = NO;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    _minW = self.bounds.size.width / 2;
    _minH = self.bounds.size.height / 2;
    _deltaAngle = atan2(self.frame.origin.y+self.frame.size.height - self.center.y, self.frame.origin.x+self.frame.size.width - self.center.x);
    
    [self.stickerImageView setImage:self.sticker];
    [self.stickerImageView setFrame:CGRectMake(PADDING, PADDING, STICKER_DEFAULT_WIDTH, STICKER_DEFAULT_HEIGHT)];
    [self addSubview:self.stickerImageView];
    UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseClicked:)];
    [self.stickerImageView addGestureRecognizer:chooseTap];
    [self addSubview:self.stickerImageView];
    
    [self.deleteImageView setFrame:CGRectMake(0, 0, STICKER_BTN_WIDTH, STICKER_BTN_HEIGHT)];
    UITapGestureRecognizer *deletetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnClicked:)];
    [self.deleteImageView addGestureRecognizer:deletetTap];
    [self addSubview:self.deleteImageView];
    
    [self.scaleImageView setFrame:CGRectMake(self.frame.size.width - STICKER_BTN_WIDTH, self.frame.size.height - STICKER_BTN_WIDTH, STICKER_BTN_WIDTH, STICKER_BTN_HEIGHT)];
    UIPanGestureRecognizer *resizePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)];
    [self.scaleImageView addGestureRecognizer:resizePan];
    [self addSubview:self.scaleImageView];
}

#pragma mark - lazyload
- (UIImageView *)stickerImageView{
    if(!_stickerImageView){
        _stickerImageView = [[UIImageView alloc] init];
        _stickerImageView.backgroundColor = [UIColor clearColor];
        _stickerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _stickerImageView.layer.borderWidth = 2.f;
        _stickerImageView.userInteractionEnabled = YES;
    }
    return _stickerImageView;
}

- (UIImageView *)deleteImageView{
    if(!_deleteImageView){
        _deleteImageView = [[UIImageView alloc] init];
        [_deleteImageView setImage:[UIImage imageNamed:@"bt_paster_delete"]];
        _deleteImageView.userInteractionEnabled = YES;
    }
    return _deleteImageView;
}

- (UIImageView *)scaleImageView{
    if(!_scaleImageView){
        _scaleImageView = [[UIImageView alloc] init];
        [_scaleImageView setImage:[UIImage imageNamed:@"bt_paster_transform"]];
        _scaleImageView.userInteractionEnabled = YES;
    }
    return _scaleImageView;
}

/**
 *  删除贴纸
 */
- (void)deleteBtnClicked:(UITapGestureRecognizer *)recognizer
{
    if(![_stickPtDelgate respondsToSelector:@selector(stickerDidDelete:)]){
        return;
    }
    
    [_stickPtDelgate stickerDidDelete:self];
}



/**
 选中贴纸
 */
- (void)chooseClicked:(UITapGestureRecognizer *)recognizer
{
    if(![_stickPtDelgate respondsToSelector:@selector(stickerDidTapped:)]){
        return;
    }
    
    [_stickPtDelgate stickerDidTapped:self];
}


/**
 *  缩放和旋转手势
 */
- (void)resizeTranslate:(UIPanGestureRecognizer *)recognizer{
    if([recognizer state] == UIGestureRecognizerStateBegan){
        _prevMovePoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }else if([recognizer state] == UIGestureRecognizerStateChanged){
        if(self.bounds.size.width < _minW || self.bounds.size.height < _minH){
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, _minW, _minH);
            self.scaleImageView.frame = CGRectMake(self.bounds.size.width - STICKER_BTN_WIDTH, self.bounds.size.height - STICKER_BTN_HEIGHT, STICKER_BTN_WIDTH, STICKER_BTN_HEIGHT);
            _prevMovePoint = [recognizer locationInView:self];
        }else{
            CGPoint point = [recognizer locationInView:self];
            float w_change = 0.0;
            float h_change = 0.0;
            w_change = point.x - _prevMovePoint.x;
            float wRatio = w_change / self.bounds.size.width;
            h_change = wRatio * self.bounds.size.height;
            
            CGFloat finalWidth = self.bounds.size.width + w_change;
            CGFloat finalHeight = self.bounds.size.height + h_change;
            if(finalWidth > STICKER_MAX_HEIGHT){
                finalWidth = STICKER_MAX_WIDTH;
            }
            if(finalWidth < MIN_WIDTH){
                finalWidth = MIN_WIDTH;
            }
            if(finalHeight > STICKER_MAX_HEIGHT){
                finalHeight = STICKER_MAX_HEIGHT;
            }
            if(finalWidth < MIN_WIDTH){
                finalWidth = MIN_WIDTH;
            }
            
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, finalWidth, finalHeight);
            [self.scaleImageView setFrame:CGRectMake(self.bounds.size.width - STICKER_BTN_WIDTH, self.bounds.size.height - STICKER_BTN_HEIGHT, STICKER_BTN_WIDTH, STICKER_BTN_HEIGHT)];
            [self.stickerImageView setFrame:CGRectMake(PADDING, PADDING, self.bounds.size.width - PADDING * 2, self.bounds.size.height - PADDING * 2)];
            
            _prevMovePoint = [recognizer locationOfTouch:0 inView:self];
        }
        
        //旋转
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y, [recognizer locationInView:self.superview].x - self.center.x);
        float angleDiff = _deltaAngle -ang;
        self.transform = CGAffineTransformMakeRotation(-angleDiff);
        [self setNeedsDisplay];
        
    }else if([recognizer state] == UIGestureRecognizerStateEnded){
        _prevMovePoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
    
    //检查是否出界
    [self checkIsOut];
}

/*
 * 检查是否超出了显示范围
 */
-(void)checkIsOut{
    CGPoint point = self.center;
    
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
    
    top = point.y - self.frame.size.height/2;
    bottom = self.superview.frame.size.height - point.y - self.frame.size.height/2;
    
    //超出顶部范围
    if(point.y < self.superview.frame.size.height/2){
        if(top < 0){
            point.y += ABS(top);
        }
    }else{
    //超出底部范围
        if(bottom < 0){
            point.y -= ABS(bottom);
        }
    }
    
    left = point.x - self.frame.size.width / 2;
    right = self.superview.frame.size.width - point.x - self.frame.size.width/2;
    //左边超出范围
    if(point.x < self.superview.frame.size.width/2){
        if(left < 0){
            point.x += ABS(left);
        }
    }else{
    //右边超出范围
        if(right < 0){
            point.x -= ABS(right);
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.center = point;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    _touchStart = [touch locationInView:self.superview];
}

/*
 * Move
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    if(CGRectContainsPoint(self.scaleImageView.frame, touchLocation)){
        return;
    }
    
    CGPoint touch = [[touches anyObject] locationInView:self.superview];
    [self translateUsingTouchLocation:touch];
    [self checkIsOut];
    _touchStart = touch;
}

/*
 * 确保不移出屏幕
 */
- (void)translateUsingTouchLocation:(CGPoint)touchPoint{
    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - _touchStart.x, self.center.y + touchPoint.y - _touchStart.y);
    
    CGFloat midPointX = CGRectGetMidX(self.bounds);
    if(newCenter.x > self.superview.bounds.size.width - midPointX + SECURITY_BREADTH){
        newCenter.x = self.superview.bounds.size.width - midPointX + SECURITY_BREADTH;
    }
    
    if(newCenter.x < midPointX - SECURITY_BREADTH){
        newCenter.x = midPointX - SECURITY_BREADTH;
    }
    
    CGFloat midPointY = CGRectGetMidY(self.bounds);
    if(newCenter.y > self.superview.bounds.size.height - midPointY + SECURITY_BREADTH){
        newCenter.y = self.superview.bounds.size.height - midPointY + SECURITY_BREADTH;
    }
    
    if(newCenter.y < midPointY - SECURITY_BREADTH){
        newCenter.y = midPointY - SECURITY_BREADTH;
    }
    
    self.center = newCenter;
}

- (void)showDelAndMoveBtn{
    [UIView animateWithDuration:0.5f animations:^{
//        self.deleteImageView.alpha = 0.0f;
        self.deleteImageView.hidden = NO;
//        self.scaleImageView.alpha = 0.0f;
        self.scaleImageView.hidden = NO;
        [self.stickerImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        self.isHide = NO;
    }];
}

- (void)hideDelAndMoveBtn{
    [UIView animateWithDuration:0.5f animations:^{
//        self.deleteImageView.alpha = 1.0f;
        self.deleteImageView.hidden = YES;
//        self.scaleImageView.alpha = 1.0f;
        self.scaleImageView.hidden = YES;
        [self.stickerImageView.layer setBorderColor:[UIColor clearColor].CGColor];
        self.isHide = YES;
    }];
}

@end
