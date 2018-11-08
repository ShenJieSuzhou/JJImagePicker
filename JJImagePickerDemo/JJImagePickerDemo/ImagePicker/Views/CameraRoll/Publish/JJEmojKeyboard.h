//
//  JJEmojKeyboard.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/7.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiScrollView.h"
#import "NaturalData.h"

@protocol JJEmojDelegate <NSObject>

- (void)faceClick:(NSString*)faceName andFaceNumber:(NSInteger)number;

@end

@interface JJEmojKeyboard : UIView<emojiScrollViewDelegate>

@property (nonatomic,strong) EmojiScrollView  *emojVC;
@property (weak, nonatomic) id<JJEmojDelegate> delegate;

@property (nonatomic, strong) NSArray *titleImages;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton  *starButton;
@property (nonatomic, assign) NSInteger totle;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic,strong) UIPageControl *emojipage;

@end

