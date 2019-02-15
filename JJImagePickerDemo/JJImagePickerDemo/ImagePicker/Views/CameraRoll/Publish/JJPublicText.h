//
//  JJPublicText.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+Placeholder.h"
//#import "JJEmojKeyboard.h"
#import <YYText/YYTextView.h>

@class JJPublicText;
@protocol JJPublicTextDelegate<NSObject>

- (void)textViewShouldBeginEditing:(UITextView *)publishView;

@end

@interface JJPublicText : UIView<YYTextViewDelegate>
@property (nonatomic, strong) YYTextView *publishText;
@property (nonatomic, weak) id<JJPublicTextDelegate> delegate;
@property  (nonatomic, assign) BOOL  isFaceDel;

- (NSString *)getInterestInfo;

@end

