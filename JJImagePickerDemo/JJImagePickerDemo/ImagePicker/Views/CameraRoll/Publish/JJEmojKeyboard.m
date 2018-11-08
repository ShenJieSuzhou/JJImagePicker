//
//  JJEmojKeyboard.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/7.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJEmojKeyboard.h"

#define  MAXWIDTH  [UIScreen mainScreen].bounds.size.width
#define  MAXHIGHT  [UIScreen mainScreen].bounds.size.height

@implementation JJEmojKeyboard

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    [self addSubview:self.emojVC];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

//懒加载
- (EmojiScrollView*)emojVC{
    if (!_emojVC) {
        _emojVC = [[EmojiScrollView alloc] initWithFrame:CGRectMake(0, 0, MAXWIDTH, self.frame.size.height - 20) AndImageArray:[NaturalData shareInStance].imageFaceArray];
        _emojVC.emojiDelegate = self;
        [_emojVC emjiScrollBack];
    }
    return _emojVC;
}

- (UIPageControl*)emojipage{
    if (!_emojipage) {
        _emojipage = [[UIPageControl alloc]initWithFrame:CGRectMake((MAXWIDTH -150)/2, self.frame.size.height -30, 150, 20)];
        _emojipage.pageIndicatorTintColor=[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
        _emojipage.currentPageIndicatorTintColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
        _emojipage.userInteractionEnabled = NO;
    }
    return _emojipage;
}

#pragma mark - emojiScrollViewDelegate

- (void)emojiBackPageNumber:(NSInteger)number andIndex:(NSInteger)index
{
    [self addSubview:self.emojipage];
    self.emojipage.numberOfPages = number;
    self.emojipage.currentPage = index;
}

- (void)deleteString{
    NSString *nameStr = @"[删除]";
    if (self.delegate &&[self.delegate respondsToSelector:@selector(faceClick:andFaceNumber:)]) {
        [self.delegate faceClick:nameStr andFaceNumber:0];
    }
}

- (void)emojiSelcet:(NSInteger)numface{
    NSString *faceName =[[NaturalData shareInStance].faceArray objectAtIndex:numface];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(faceClick:andFaceNumber:)]) {
        [self.delegate faceClick:faceName andFaceNumber:numface];
    }
}

@end
