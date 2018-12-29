//
//  EditNameViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "EditNameViewController.h"

#define TEXTFIELD_HEIGHT 50.0f
#define TEXTFIELD_PADDING 20.0f

@interface EditNameViewController ()

@property (strong, nonatomic) UITextField *nickNameField;

@end

@implementation EditNameViewController
@synthesize nickNameField = _nickNameField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setBackgroundColor:[UIColor clearColor]];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(clickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:saveBtn withFrame:CGRectMake(self.view.bounds.size.width - 65.0f, 30.0f, 45.0f, 25.0f)];

    
    CGFloat w = self.view.frame.size.width;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((w - 200)/2, 25.0f, 200.0f, 40.0f)];
    [title setText:@"昵称"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];
    [self.jjTabBarView setHidden:YES];
    
    [self.view addSubview:self.nickNameField];
}

- (UITextField *)nickNameField{
    if(!_nickNameField){
        _nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height + TEXTFIELD_PADDING, self.view.frame.size.width, TEXTFIELD_HEIGHT)];
        _nickNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nickNameField.borderStyle = UITextBorderStyleLine;
        [_nickNameField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
    return _nickNameField;
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)clickSaveBtn:(UIButton *)sender{
//    [self.nickNameField resignFirstResponder];
    //保存
}

@end
