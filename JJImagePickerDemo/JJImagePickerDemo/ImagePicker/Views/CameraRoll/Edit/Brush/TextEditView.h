//
//  TextEditView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordsModel.h"

@class TextEditView;
@protocol TextEditViewDelegate <NSObject>

- (void)textEditFinished:(TextEditView *)textView text:(WordsModel *)model;

@end

@interface TextEditView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textBrushView;
@property (nonatomic, weak) id<TextEditViewDelegate> delegate;
@property (nonatomic, strong) WordsModel *wordsModel;

-(void)setEditTextColor:(UIColor *)color;

@end


