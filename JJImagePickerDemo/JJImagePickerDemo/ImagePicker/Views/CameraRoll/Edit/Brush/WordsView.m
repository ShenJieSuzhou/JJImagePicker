//
//  WordsView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/22.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WordsView.h"
#define WORDS_SPACE 20.0f
#define SECURITY_BREADTH 60

@implementation WordsView
@synthesize wModel = _wModel;
@synthesize deleteImageView = _deleteImageView;
@synthesize textView = _textView;
@synthesize touchStart = _touchStart;
@synthesize textLabel = _textLabel;
@synthesize isSelected = _isSelected;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    [self setBackgroundColor:[UIColor clearColor]];
    self.isSelected = YES;
    [self addSubview:self.textView];
    [self addSubview:self.deleteImageView];
    
    UITapGestureRecognizer *deletetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnClicked:)];
    [self.deleteImageView addGestureRecognizer:deletetTap];
    
    UITapGestureRecognizer *selfTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewSelfClicked:)];
    [self.textView addGestureRecognizer:selfTap];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(!self.wModel){
        return;
    }
    
    CGSize textSize = [self.wModel.words sizeWithAttributes:@{NSFontAttributeName:self.wModel.font}];
    if(textSize.width > self.superview.frame.size.width){
        CGSize textSize1 = [self.wModel.words boundingRectWithSize:CGSizeMake(self.frame.size.width - 40, CGFLOAT_MAX)
                                                          options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:self.wModel.font}
                                                          context:nil].size;
        [self setFrame:CGRectMake(0, 0, textSize1.width + WORDS_SPACE, textSize1.height + WORDS_SPACE)];
    }else{
         [self setFrame:CGRectMake(0, 0, textSize.width + WORDS_SPACE, textSize.height + WORDS_SPACE)];
    }
    
    [self.textView setFrame:self.frame];
    [self.textView setFont:self.wModel.font];
    [self.textView setTextColor:self.wModel.color];
    [self.textView setText:self.wModel.words];
    [self.textView setTextAlignment:NSTextAlignmentLeft];

    [self.deleteImageView setFrame:CGRectMake(-12.0f, -12.0f, 24.0f, 24.0f)];
}

- (void)deleteBtnClicked:(UITapGestureRecognizer *)recognizer{
    if(![_delegate respondsToSelector:@selector(WordsBrushDelete:)]){
        return;
    }
    
    [_delegate WordsBrushDelete:self];
}

- (void)viewSelfClicked:(UITapGestureRecognizer *)recognizer{
    if(![_delegate respondsToSelector:@selector(WordsBrushTapped:)]){
        return;
    }
    
    [_delegate WordsBrushTapped:self];
    
//    if(!self.isSelected){
//        [self.textView.layer setBorderColor:[UIColor whiteColor].CGColor];
//        [self.deleteImageView setHidden:NO];
//        self.isSelected = YES;
//    }else{
//        [self.textView.layer setBorderColor:[UIColor clearColor].CGColor];
//        [self.deleteImageView setHidden:YES];
//        self.isSelected = NO;
//    }
}

- (void)hideBoardAndCloseImg{
    self.isSelected = NO;
    [self.textView.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.deleteImageView setHidden:YES];
}

- (void)showBoardAndCloseImg{
    self.isSelected = YES;
    [self.textView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.deleteImageView setHidden:NO];
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
    if(CGRectContainsPoint(self.textView.frame, touchLocation)){
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

- (UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.delegate = self;
        [_textView setBackgroundColor:[UIColor clearColor]];
        _textView.editable = NO;
        _textView.selectable = NO;
        _textView.scrollEnabled = NO;
        [_textView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_textView.layer setBorderWidth:1.5f];
    }
    return _textView;
}

- (UIImageView *)deleteImageView{
    if(!_deleteImageView){
        _deleteImageView = [[UIImageView alloc] init];
        [_deleteImageView setImage:[UIImage imageNamed:@"bt_paster_delete"]];
        _deleteImageView.userInteractionEnabled = YES;
    }
    return _deleteImageView;
}

@end
