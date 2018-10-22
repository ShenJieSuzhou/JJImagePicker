//
//  TextEditView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "TextEditView.h"

@implementation TextEditView
@synthesize textBrushView = _textBrushView;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.textBrushView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.textBrushView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)setEditTextColor:(UIColor *)color{
    [self.textBrushView setTextColor:color];
}

#pragma mark - lazylaod
- (UITextView *)textBrushView{
    if(!_textBrushView){
        _textBrushView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textBrushView.returnKeyType = UIReturnKeyDone;
        [_textBrushView setBackgroundColor:[UIColor clearColor]];
        _textBrushView.delegate = self;
        [_textBrushView setFont:[UIFont systemFontOfSize:35.0f]];
        [_textBrushView setTextColor:[UIColor whiteColor]];
        [_textBrushView becomeFirstResponder];
    }
    
    return _textBrushView;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    float textViewHeight =  [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height;
    CGRect frame = textView.frame;
    frame.size.height = textViewHeight;
    textView.frame = frame;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if(![_delegate respondsToSelector:@selector(keyboardCloseView:)]){
            return YES;
        }
        [textView resignFirstResponder];
        [_delegate keyboardCloseView:self];
        return NO;
    }
    return YES;
}

@end
