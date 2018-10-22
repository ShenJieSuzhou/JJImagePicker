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
@synthesize textLabel = _textLabel;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.textView];
    [self addSubview:self.deleteImageView];
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
        [self setFrame:CGRectMake(0, 0, textSize1.width, textSize1.height + 15.0f)];
    }else{
         [self setFrame:CGRectMake(0, 0, textSize.width, textSize.height + 15.0f)];
    }
    
    [self.textView setFrame:self.frame];
    [self.textView setFont:self.wModel.font];
    [self.textView setTextColor:self.wModel.color];
    [self.textView setText:self.wModel.words];
    [self.textView setTextAlignment:NSTextAlignmentCenter];

    [self.deleteImageView setFrame:CGRectMake(self.frame.size.width - 12.0f, -12.0f, 24.0f, 24.0f)];
    UITapGestureRecognizer *deletetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnClicked:)];
    [self.deleteImageView addGestureRecognizer:deletetTap];
}

- (void)deleteBtnClicked:(UITapGestureRecognizer *)recognizer{
    [self removeFromSuperview];
}

- (void)hideBoardAndCloseImg{
    [self.deleteImageView setHidden:YES];
}

#pragma mark - UITextViewDelegate
//- (void)textViewDidChange:(UITextView *)textView{
//    float textViewHeight =  [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height;
//    CGRect frame = textView.frame;
//    frame.size.height = textViewHeight;
//    textView.frame = frame;
//}

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
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.delegate = self;
        [_textView setBackgroundColor:[UIColor clearColor]];
        _textView.editable = NO;
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
