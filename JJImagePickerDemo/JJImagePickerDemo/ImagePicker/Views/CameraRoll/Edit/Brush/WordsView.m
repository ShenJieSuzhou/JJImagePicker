//
//  WordsView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/22.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WordsView.h"

@implementation WordsView
@synthesize wModel = _wModel;
@synthesize deleteImageView = _deleteImageView;
@synthesize textView = _textView;
@synthesize touchStart = _touchStart;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    if(!self.wModel){
        return;
    }
    
    [self.textView setFont:self.wModel.font];
    [self.textView setTextColor:self.wModel.color];
    [self.textView setText:self.wModel.words];
    [self addSubview:self.textView];
    
    [self.deleteImageView setFrame:CGRectMake(self.frame.size.width + 12.0f, 0, 24.0f, 24.0f)];
    UITapGestureRecognizer *deletetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnClicked:)];
    [self.deleteImageView addGestureRecognizer:deletetTap];
    [self addSubview:self.deleteImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)deleteBtnClicked:(UITapGestureRecognizer *)recognizer
{
    [self removeFromSuperview];
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
    self.center = touch;
    _touchStart = touch;
}

- (UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc] initWithFrame:self.frame];
        _textView.editable = NO;
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
