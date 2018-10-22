//
//  WordsView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/22.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordsModel.h"
@interface WordsView : UIView<UITextViewDelegate>

@property (strong, nonatomic) WordsModel *wModel;
@property (strong, nonatomic) UIImageView *deleteImageView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *textLabel;
@property (assign) CGPoint touchStart;

- (void)hideBoardAndCloseImg;

@end

