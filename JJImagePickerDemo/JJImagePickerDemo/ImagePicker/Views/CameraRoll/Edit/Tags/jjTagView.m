//
//  jjTagView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJTagView.h"

#define jXPadding 8.0                            /** 距离父视图边界横向最小距离 */
#define jYPadding 0.0                            /** 距离父视图边界纵向最小距离 */
#define jTagHorizontalSpace 20.0                 /** 标签左右空余距离 */
#define jTagVerticalSpace 10.0                   /** 标签上下空余距离 */
#define jPointDiameter 8.0                       /** 白点直径 */
#define jPointSpace 2.0                          /** 白点和阴影尖角距离 */
#define jAngleLength (self.zy_height / 2.0 - 2)  /** 黑色阴影尖交宽度 */
#define jDeleteBtnWidth self.zy_height           /** 删除按钮宽度 */
#define jBackCornerRadius 1.0                    /** 黑色背景圆角半径 */


@implementation JJTagView
@synthesize delegate = _delegate;
@synthesize tagModel = _tagModel;
@synthesize startPoint = _startPoint;
@synthesize arrowPoint = _arrowPoint;
@synthesize pointLayer = _pointLayer;
@synthesize pointShadowLayer = _pointShadowLayer;
@synthesize titleLabel = _titleLabel;
@synthesize deleteBtn = _deleteBtn;
@synthesize separateLine = _separateLine;
@synthesize criticalY = _criticalY;
@synthesize criticalX = _criticalX;

- (instancetype)initWithTagModel:(TagModel *)tagModel{
    if(self = [super initWithFrame:CGRectZero]){
        self.tagModel = tagModel;
        [self setupUI];
        [self addGesture];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.tagModel.tagName;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel sizeToFit];
    self.titleLabel.zy_width += jTagHorizontalSpace;
    self.titleLabel.zy_height += jTagVerticalSpace;
    
    CGPoint point = self.tagModel.point;
    if(CGPointEqualToPoint(point, CGPointZero)){
        point = self.superview.center;
    }
    
    // 调整方向
    if((point.x + self.frame.size.width) < self.superview.frame.size.width){
        self.direction = TAG_DIRECTION_LEFT;
    }else {
        self.direction = TAG_DIRECTION_RIGHT;
    }
    
    [self reLayoutWithPoint:point withDirection:self.direction];
    
    //临界点处理
    if(self.direction == TAG_DIRECTION_LEFT){
        if (self.frame.origin.x < jXPadding) {
            self.criticalX = jXPadding;
        }
    }else {
        if(self.frame.origin.x > self.superview.frame.size.width - self.frame.size.width - jXPadding){
            self.criticalX = self.superview.frame.size.width - self.frame.size.width - jXPadding;
        }
    }
    
    if(self.frame.origin.y < jYPadding){
        self.criticalY = jYPadding;
    }else if(self.frame.origin.y > self.superview.frame.size.height - self.frame.size.height - jYPadding){
        self.criticalY = self.superview.frame.size.height - self.frame.size.height - jYPadding;
    }
    
    //更新 tag
    [self updateLocationInfoWithSuperview];
    
    [self showAnimation];
}

- (CGPoint)arrowPoint{
    CGPoint arrowPoint = CGPointZero;
    if (self.direction == TAG_DIRECTION_LEFT) {
        arrowPoint = CGPointMake(self.zy_x + jPointDiameter / 2.0, self.zy_centerY);
    }else if (self.direction == TAG_DIRECTION_RIGHT) {
        arrowPoint = CGPointMake(self.zy_right - jPointDiameter / 2.0, self.zy_centerY);
    }else if (self.direction == TAG_DIRECTION_LEFT_DELETE) {
        arrowPoint = CGPointMake(self.zy_x + jPointDiameter / 2.0, self.zy_centerY);
    }else if(self.direction == TAG_DIRECTION_RIGHT_DELETE) {
        arrowPoint = CGPointMake(self.zy_right - jPointDiameter / 2.0, self.zy_centerY);
    }
    return arrowPoint;
}

/*
 * 设置 UI
 */
- (void)setupUI{
    self.userInteractionEnabled = YES;
    CAShapeLayer *backLayer = [[CAShapeLayer alloc] init];
    backLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:.7].CGColor;
    backLayer.shadowOffset = CGSizeMake(0, 2);
    backLayer.shadowColor = [UIColor blackColor].CGColor;
    backLayer.shadowRadius = 3;
    backLayer.shadowOpacity = 0.5;
    [self.layer addSublayer:backLayer];
    self.backLayer = backLayer;
    
    CAShapeLayer *pointShadowLayer = [[CAShapeLayer alloc] init];
    pointShadowLayer.hidden = YES;
    pointShadowLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    [self.layer addSublayer:pointShadowLayer];
    self.pointShadowLayer = pointShadowLayer;
    
    CAShapeLayer *pointLayer = [[CAShapeLayer alloc] init];
    pointLayer.backgroundColor = [UIColor whiteColor].CGColor;
    pointLayer.shadowOffset = CGSizeMake(0, 1);
    pointLayer.shadowColor = [UIColor blackColor].CGColor;
    pointLayer.shadowRadius = 1.5;
    pointLayer.shadowOpacity = 0.2;
    [self.layer addSublayer:pointLayer];
    self.pointLayer = pointLayer;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setImage:[UIImage imageNamed:@"deleteTag"] forState:UIControlStateNormal];
    [self addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    
    UIImageView *separateLine = [[UIImageView alloc] init];
    [separateLine setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.5]];
    [self addSubview:separateLine];
    self.separateLine = separateLine;
}

/*
 * 添加手势
 */
- (void)addGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:pan];
}

/*
 * 重新调整位置跟方向
 */
- (void)reLayoutWithPoint:(CGPoint)point withDirection:(TAG_DIRECTION)direction{
    self.direction = direction;
    
    [CATransaction setDisableActions:YES];
    
    UIBezierPath *backPath = [UIBezierPath bezierPath];
    self.pointLayer.bounds = CGRectMake(0, 0, jPointDiameter, jPointDiameter);
    self.pointLayer.cornerRadius = jPointDiameter / 2;
    self.zy_height = self.titleLabel.zy_height;
    self.zy_centerY = point.y;
    self.titleLabel.zy_y = 0;
    
    if(direction == TAG_DIRECTION_LEFT || direction == TAG_DIRECTION_RIGHT){
        self.zy_width = self.titleLabel.zy_width + jAngleLength + jPointDiameter + jPointSpace;
        self.deleteBtn.hidden = YES;
        self.separateLine.hidden = YES;
    }else{
        self.zy_width = self.titleLabel.zy_width + jAngleLength + jPointSpace + jPointDiameter + jDeleteBtnWidth;
        self.deleteBtn.hidden = NO;
        self.separateLine.hidden = NO;
    }
    
    if(direction == TAG_DIRECTION_LEFT || direction == TAG_DIRECTION_LEFT_DELETE){
        self.zy_x = point.x - jPointDiameter / 2;
        [backPath moveToPoint:CGPointMake(jPointDiameter + jPointSpace, self.zy_height / 2.0)];
        [backPath addLineToPoint:CGPointMake(jPointDiameter + jPointSpace + jAngleLength, 0)];
        [backPath addLineToPoint:CGPointMake(self.zy_width - jBackCornerRadius, 0)];
        [backPath addArcWithCenter:CGPointMake(self.zy_width - jBackCornerRadius, jBackCornerRadius) radius:jBackCornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
        [backPath addLineToPoint:CGPointMake(self.zy_width, self.zy_height - jBackCornerRadius)];
        [backPath addArcWithCenter:CGPointMake(self.zy_width - jBackCornerRadius, self.zy_height - jBackCornerRadius) radius:jBackCornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [backPath addLineToPoint:CGPointMake(jPointDiameter + jPointSpace + jAngleLength, self.zy_height)];
        [backPath closePath];
        
        self.pointLayer.position = CGPointMake(jPointDiameter / 2, self.zy_height / 2);
        self.titleLabel.zy_x = jPointDiameter + jAngleLength;
        
        if(direction == TAG_DIRECTION_LEFT_DELETE){
            [self.deleteBtn setFrame:CGRectMake(self.zy_width - jDeleteBtnWidth, 0, jDeleteBtnWidth, jDeleteBtnWidth)];
            [self.separateLine setFrame:CGRectMake(self.deleteBtn.zy_x - 0.5, 0, 0.5, self.zy_height)];
        }
    }else if(direction == TAG_DIRECTION_RIGHT || direction == TAG_DIRECTION_RIGHT_DELETE){
        self.zy_right = point.x + jPointDiameter / 2;
        
        // 背景
        [backPath moveToPoint:CGPointMake(self.zy_width - jPointDiameter - jPointSpace, self.zy_height / 2.0)];
        [backPath addLineToPoint:CGPointMake(self.zy_width - jAngleLength - jPointDiameter - jPointSpace, self.zy_height)];
        [backPath addLineToPoint:CGPointMake(jBackCornerRadius, self.zy_height)];
        [backPath addArcWithCenter:CGPointMake(jBackCornerRadius, self.zy_height - jBackCornerRadius) radius:jBackCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [backPath addLineToPoint:CGPointMake(0, jBackCornerRadius)];
        [backPath addArcWithCenter:CGPointMake(jBackCornerRadius, jBackCornerRadius) radius:jBackCornerRadius startAngle:M_PI endAngle:M_PI + M_PI_2 clockwise:YES];
        [backPath addLineToPoint:CGPointMake(self.zy_width - jAngleLength - jPointDiameter - jPointSpace, 0)];
        [backPath closePath];
        // 点
        self.pointLayer.position = CGPointMake(self.zy_width - jPointDiameter / 2.0, self.zy_height / 2.0);

        if(direction == TAG_DIRECTION_RIGHT){
            self.titleLabel.zy_x = 0;
        }else{
            self.titleLabel.zy_x = jDeleteBtnWidth;
            // 关闭
            self.deleteBtn.frame = CGRectMake(0, 0, jDeleteBtnWidth, jDeleteBtnWidth);
            self.separateLine.frame = CGRectMake(self.deleteBtn.zy_right + 0.5, 0, 0.5, self.zy_height);
        }
    }
    
    self.backLayer.path = backPath.CGPath;
    self.pointShadowLayer.bounds = self.pointLayer.bounds;
    self.pointShadowLayer.position = self.pointLayer.position;
    self.pointShadowLayer.cornerRadius = self.pointLayer.cornerRadius;
    
    [CATransaction setDisableActions:NO];
}

/*
 * 更新 Tag 信息
 */
- (void)updateLocationInfoWithSuperview{
    if(self.direction == TAG_DIRECTION_LEFT || self.direction == TAG_DIRECTION_LEFT_DELETE){
        self.tagModel.point = CGPointMake(self.zy_x + jPointDiameter / 2, self.zy_y + self.zy_height/2);
        self.tagModel.dircetion = TAG_DIRECTION_LEFT;
    }else{
        self.tagModel.point = CGPointMake(self.zy_right - jPointDiameter/2, self.zy_y + self.zy_height / 2.0);
        self.tagModel.dircetion = TAG_DIRECTION_RIGHT;
    }
}

/*
 * 显示动画
 */
- (void)showAnimation{
    CAKeyframeAnimation *cka = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    cka.values =   @[@0.7, @1.32, @1,   @1];
    cka.keyTimes = @[@0.0, @0.3,  @0.3, @1];
    cka.repeatCount = CGFLOAT_MAX;
    cka.duration = 1.8;
    [self.pointLayer addAnimation:cka forKey:@"cka"];
    
    CAKeyframeAnimation *cka2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    cka2.values =   @[@0.7, @0.9, @0.9, @3.5,  @0.9,  @3.5];
    cka2.keyTimes = @[@0.0, @0.3, @0.3, @0.65, @0.65, @1];
    cka2.repeatCount = CGFLOAT_MAX;
    cka2.duration = 1.8;
    self.pointShadowLayer.hidden = NO;
    [self.pointShadowLayer addAnimation:cka2 forKey:@"cka2"];
}

/*
 * 移除动画
 */
- (void)removeAnimation{
    [self.pointLayer removeAnimationForKey:@"cka"];
    [self.pointShadowLayer removeAnimationForKey:@"cka2"];
    self.pointShadowLayer.hidden = YES;
}

/*
 * 显示删除按钮
 */
- (void)showDeleteBtn{
    if(self.direction == TAG_DIRECTION_LEFT){
        [self reLayoutWithPoint:self.arrowPoint withDirection:TAG_DIRECTION_LEFT_DELETE];
    }else if(self.direction == TAG_DIRECTION_RIGHT){
        [self reLayoutWithPoint:self.arrowPoint withDirection:TAG_DIRECTION_RIGHT_DELETE];
    }
}

/*
 * 隐藏删除按钮
 */
- (void)hiddenDeleteBtn{
    if(self.direction == TAG_DIRECTION_LEFT_DELETE){
        [self reLayoutWithPoint:self.arrowPoint withDirection:TAG_DIRECTION_LEFT];
    }else if(self.direction == TAG_DIRECTION_RIGHT_DELETE){
        [self reLayoutWithPoint:self.arrowPoint withDirection:TAG_DIRECTION_RIGHT];
    }
}

/*
 * 删除标签
 */
- (void)clickDeleteBtn{
    [self removeFromSuperview];
}

- (void)changeLocationWithGestureState:(UIGestureRecognizerState)gestureState locationPoint:(CGPoint)point{
    
//    if (self.isEditEnabled == NO) {
//        return;
//    }
    
    CGPoint referencePoint = CGPointMake(0, point.y + self.zy_height / 2.0);
    switch (self.direction) {
        case TAG_DIRECTION_LEFT:
        case TAG_DIRECTION_LEFT_DELETE:
            referencePoint.x = point.x + jPointDiameter / 2.0;
            break;
        case TAG_DIRECTION_RIGHT:
        case TAG_DIRECTION_RIGHT_DELETE:
            referencePoint.x = point.x + self.zy_width - jPointDiameter / 2.0;
            break;
        default:
            break;
    }
    
    if (referencePoint.x < jXPadding + jPointDiameter / 2.0) {
        referencePoint.x = jXPadding + jPointDiameter / 2.0;
    }else if (referencePoint.x > self.superview.zy_width - jXPadding - jPointDiameter /2.0){
        referencePoint.x = self.superview.zy_width - jXPadding - jPointDiameter /2.0;
    }
    
    if (referencePoint.y < jYPadding + self.zy_height / 2.0 ) {
        referencePoint.y = jYPadding + self.zy_height / 2.0;
    }else if (referencePoint.y > self.superview.zy_height - jYPadding - self.zy_height / 2.0){
        referencePoint.y = self.superview.zy_height - jYPadding - self.zy_height / 2.0;
    }
    // 更新位置
    self.arrowPoint = referencePoint;
    
    if (gestureState == UIGestureRecognizerStateEnded) {
        // 翻转
        switch (self.direction) {
            case TAG_DIRECTION_LEFT:
            case TAG_DIRECTION_LEFT_DELETE:
            {
                if (self.zy_right > self.superview.zy_width - jXPadding - jDeleteBtnWidth
                    && self.arrowPoint.x > self.superview.zy_width / 2.0) {
                    [self reLayoutWithPoint:self.arrowPoint withDirection:TAG_DIRECTION_RIGHT];
                }
            }
                break;
            case TAG_DIRECTION_RIGHT:
            case TAG_DIRECTION_RIGHT_DELETE:
                if (self.zy_x < jXPadding + jDeleteBtnWidth
                    && self.arrowPoint.x < self.superview.zy_width / 2.0) {
                    [self reLayoutWithPoint:self.arrowPoint withDirection:TAG_DIRECTION_LEFT];
                }
                break;
            default:
                break;
        }
        // 更新tag信息
        [self updateLocationInfoWithSuperview];
    }
}

/*
 * 点击切换删除按钮显示
 */
- (void)switchDeleteState{
    if(self.direction == TAG_DIRECTION_LEFT || self.direction == TAG_DIRECTION_RIGHT){
        [self showDeleteBtn];
    }else{
        [self hiddenDeleteBtn];
    }
}

#pragma mark - Gesture event
- (void)handleTapGesture:(UITapGestureRecognizer *)tap{
    if(tap.state == UIGestureRecognizerStateEnded){
        //切换删除按钮
        NSLog(@"切换删除按钮");
        [self.superview bringSubviewToFront:self];
        [self switchDeleteState];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan{
    CGPoint panPoint = [pan locationInView:self.superview];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self hiddenDeleteBtn];
            [self.superview bringSubviewToFront:self];
            self.startPoint = [pan locationInView:self];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self changeLocationWithGestureState:UIGestureRecognizerStateChanged
                                   locationPoint:CGPointMake(panPoint.x - self.startPoint.x, panPoint.y - self.startPoint.y)];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self changeLocationWithGestureState:UIGestureRecognizerStateEnded
                                   locationPoint:CGPointMake(panPoint.x - self.startPoint.x, panPoint.y - self.startPoint.y)];
            self.startPoint = CGPointZero;
        }
            break;
        default:
            break;
    }
}

@end
