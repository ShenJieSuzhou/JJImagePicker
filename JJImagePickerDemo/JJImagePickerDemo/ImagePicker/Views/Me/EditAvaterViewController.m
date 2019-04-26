//
//  EditAvaterViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "EditAvaterViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define MODIFIY_BUTTON_WIDTH 140.0f
#define MODIFIY_BUTTON_HEIGHT 45.0f

@interface EditAvaterViewController ()

@property (strong, nonatomic) UIButton *changeAvaterBtn;
@property (strong, nonatomic) UIImageView *avaterView;

@end

@implementation EditAvaterViewController
@synthesize delegate = _delegate;
@synthesize avaterUrl = _avaterUrl;
@synthesize changeAvaterBtn = _changeAvaterBtn;
@synthesize avaterView = _avaterView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.navigationItem setTitle:@"个人头像"];
    UIImage *img = [[UIImage imageNamed:@"in_pay_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClicked)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self.view addSubview:self.avaterView];
    [self.view addSubview:self.changeAvaterBtn];
    
    [self.avaterView sd_setImageWithURL:[NSURL URLWithString:_avaterUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (UIImageView *)avaterView{
    if(!_avaterView){
        _avaterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    }
    return _avaterView;
}

- (UIButton *)changeAvaterBtn{
    if(!_changeAvaterBtn){
        _changeAvaterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeAvaterBtn setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - MODIFIY_BUTTON_WIDTH) / 2, [UIScreen mainScreen].bounds.size.height - 120, MODIFIY_BUTTON_WIDTH, MODIFIY_BUTTON_HEIGHT)];
        [_changeAvaterBtn setTitle:@"修改头像" forState:UIControlStateNormal];
        [_changeAvaterBtn setBackgroundColor:[UIColor clearColor]];
        [_changeAvaterBtn.layer setCornerRadius:12.0f];
        [_changeAvaterBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_changeAvaterBtn.layer setBorderWidth:1.0f];
        [_changeAvaterBtn.layer setMasksToBounds:YES];
        [_changeAvaterBtn addTarget:self action:@selector(clickChangeAvaterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeAvaterBtn;
}

// 修改头像， 进入相册选择后上传服务器
- (void)clickChangeAvaterBtn:(UIButton *)sender{
    
    
}

- (void)leftBarBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
