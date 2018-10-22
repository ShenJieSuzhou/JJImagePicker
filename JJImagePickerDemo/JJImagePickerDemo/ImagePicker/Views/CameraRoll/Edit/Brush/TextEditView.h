//
//  TextEditView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextEditView;
@protocol TextEditViewDelegate <NSObject>

- (void)keyboardCloseView:(TextEditView *)textView;

@end

@interface TextEditView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textBrushView;
@property (nonatomic, weak) id<TextEditViewDelegate> delegate;

-(void)setEditTextColor:(UIColor *)color;

@end


