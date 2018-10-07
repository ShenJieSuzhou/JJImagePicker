//
//  TagEditView.m
//  testTag
//
//  Created by shenjie on 2018/9/30.
//  Copyright © 2018年 shenjie. All rights reserved.
//


#define TagEditViewMargin 10.0f
#define EDITBUTTONWIDTH 50.0f
#define EDITBUTTONHEIGHT 30.0f

#import "TagEditView.h"

@implementation TagEditView
@synthesize imageV = _imageV;
@synthesize tagTextField = _tagTextField;
@synthesize addBtn = _addBtn;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:[UIImage imageNamed:@"phototagbrandcheck"]];
    self.imageV = imageView;
    [self addSubview:self.imageV];
    
    UITextField *textF = [[UITextField alloc] init];
    [textF setDelegate:self];
    [textF setFont:[UIFont systemFontOfSize:12.0f]];
    textF.placeholder = @"  添加你的标签";
    textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    textF.layer.cornerRadius = 5.0f;
    textF.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    self.tagTextField = textF;
    [self addSubview:self.tagTextField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(addTagEvent:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius = 5.0f;
    self.addBtn = button;
    [self addSubview:self.addBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageV setFrame:CGRectMake(20, TagEditViewMargin + 5.0f, 20.0f, 20.0f)];
    
    [self.tagTextField setFrame:CGRectMake(60.0f, TagEditViewMargin, self.frame.size.width - 60 - EDITBUTTONWIDTH - TagEditViewMargin - 20.0f, EDITBUTTONHEIGHT)];
    
    [self.addBtn setFrame:CGRectMake(self.frame.size.width - EDITBUTTONWIDTH - 20.0f, TagEditViewMargin, EDITBUTTONWIDTH, EDITBUTTONHEIGHT)];
}

/*
 * 标签按钮点击事件
 */
- (void)addTagEvent:(UIButton *)sender{
    NSString *tagValue = self.tagTextField.text;
    
    if([_delegate respondsToSelector:@selector(TagAdd:tag:)]){
        [_delegate TagAdd:self tag:tagValue];
    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

@end
