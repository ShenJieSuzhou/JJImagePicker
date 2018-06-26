//
//  TabBarView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "TabBarView.h"

const UIEdgeInsets previewBtnMargins = {10, 10, 10, 0};
const UIEdgeInsets finishBtnMargins = {10, 0, 10, 10};
const UIEdgeInsets editBtnMargins = {10, 10, 10, 0};

@implementation TabBarView

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
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    [self.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn setBackgroundColor:[UIColor blueColor]];
    [self addSubview:self.editBtn];
    
    self.previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [self.previewBtn setBackgroundColor:[UIColor blueColor]];
//    [self.previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.previewBtn];
    
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.finishBtn setBackgroundColor:[UIColor blueColor]];
//    [self.finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.finishBtn];
    
    self.gallaryView = [[UIView alloc] init];
    [self.gallaryView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.gallaryView];
    [self.gallaryView setHidden:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
    }else{
        [self.previewBtn setFrame:CGRectMake(previewBtnMargins.left, previewBtnMargins.top, 50, 30)];
        [self.editBtn setFrame:CGRectMake(editBtnMargins.left, editBtnMargins.top, 50, 30)];
        [self.finishBtn setFrame:CGRectMake(width - 50 - finishBtnMargins.right, finishBtnMargins.top, 50, 30)];
    }
    
}

//- (void)editBtnClick:(UIButton *)sender{
//
//}
//
//- (void)previewBtnClick:(UIButton *)sender{
//
//}
//
//- (void)finishBtnClick:(UIButton *)sender{
//
//}

- (void)setEditBtnHidden:(BOOL) hidden{
    [self.editBtn setHidden:hidden];
}

- (void)setPreViewBtnHidden:(BOOL) hidden{
    [self.previewBtn setHidden:hidden];
}

@end
