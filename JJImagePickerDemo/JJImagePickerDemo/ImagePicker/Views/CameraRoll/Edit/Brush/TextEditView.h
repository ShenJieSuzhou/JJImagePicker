//
//  TextEditView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextEditView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textBrushView;

-(void)setTextColor:(UIColor *)color;

@end


