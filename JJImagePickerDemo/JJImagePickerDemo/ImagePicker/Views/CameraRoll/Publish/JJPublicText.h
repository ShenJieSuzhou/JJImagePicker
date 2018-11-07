//
//  JJPublicText.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+Placeholder.h"
#import "JJEmojKeyboard.h"

@interface JJPublicText : UIView<JJEmojDelegate>

@property (nonatomic, strong) UITextView *publishText;


@end

