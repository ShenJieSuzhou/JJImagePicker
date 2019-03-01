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
    [self setBackgroundColor:[UIColor whiteColor]];
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setBackgroundColor:[UIColor clearColor]];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.editBtn];
    
    self.previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    self.previewBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [self.previewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.previewBtn setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.previewBtn];
    
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn.layer.cornerRadius = 4.0;
    self.finishBtn.layer.masksToBounds = YES;
    [self.finishBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.finishBtn setBackgroundColor:[UIColor colorWithRed:255/255.0f green:32/255.0f blue:69/255.0f alpha:1.0f]];
    self.finishBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [self.finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishBtn setEnabled:NO];
    [self addSubview:self.finishBtn];
    
    self.selectedNum = [[UILabel alloc] init];
    [self.selectedNum setBackgroundColor:[UIColor colorWithRed:255/255.0f green:32/255.0f blue:69/255.0f alpha:1.0f]];
    [self.selectedNum setFont:[UIFont systemFontOfSize:18.0]];
    [self.selectedNum setTextColor:[UIColor whiteColor]];
    [self.selectedNum setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.selectedNum];
    [self.selectedNum setHidden:YES];
    
    self.gallaryView = [[UIView alloc] init];
    [self.gallaryView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.gallaryView];
    [self.gallaryView setHidden:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    [self.previewBtn setFrame:CGRectMake(previewBtnMargins.left, previewBtnMargins.top, 50, 30)];
    [self.editBtn setFrame:CGRectMake(editBtnMargins.left, editBtnMargins.top, 50, 30)];
    [self.finishBtn setFrame:CGRectMake(width - 60 - finishBtnMargins.right, finishBtnMargins.top, 60, 30)];
    [self.selectedNum setFrame:CGRectMake(width - 30 - finishBtnMargins.right - 65, finishBtnMargins.top, 30, 30)];
    self.selectedNum.layer.cornerRadius = self.selectedNum.bounds.size.width / 2;
    self.selectedNum.layer.masksToBounds = YES;
}

- (void) setEditBtnHidden:(BOOL) hidden{
    [self.editBtn setHidden:hidden];
}

- (void)setPreViewBtnHidden:(BOOL) hidden{
    [self.previewBtn setHidden:hidden];
}

- (void)setSelectedLabelHidden:(BOOL) hidden{
    [self.selectedNum setHidden:hidden];
}

@end
