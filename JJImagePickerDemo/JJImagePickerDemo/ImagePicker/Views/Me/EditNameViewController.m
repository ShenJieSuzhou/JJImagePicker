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
@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation EditNameViewController
@synthesize nickNameField = _nickNameField;
@synthesize descLabel = _descLabel;

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
    [self.view addSubview:self.descLabel];
}

- (UITextField *)nickNameField{
    if(!_nickNameField){
        _nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height + TEXTFIELD_PADDING, self.view.frame.size.width, TEXTFIELD_HEIGHT)];
        _nickNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_nickNameField setTextColor:[UIColor blackColor]];
        _nickNameField.borderStyle = UITextBorderStyleLine;
        _nickNameField.layer.borderWidth = 1.0f;
//        [_nickNameField.layer setCornerRadius:8.0f];
        _nickNameField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _nickNameField;
}

- (UILabel *)descLabel{
    if(!_descLabel){
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.customNaviBar.frame.size.height + TEXTFIELD_PADDING + TEXTFIELD_HEIGHT, self.view.frame.size.width - 20.0f, 100.0f)];
        [_descLabel setText:@"最多包含12个中文或24个英文,不支持<>/等特殊符号。"];
        [_descLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_descLabel setNumberOfLines:0];
        [_descLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_descLabel setTextColor:[UIColor grayColor]];
    }
    return _descLabel;
}

- (void)setNickName:(NSString *)name{
    [self.nickNameField setText:name];
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
