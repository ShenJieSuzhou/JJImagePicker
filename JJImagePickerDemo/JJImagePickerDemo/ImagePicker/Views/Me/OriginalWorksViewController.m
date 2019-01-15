//
//  OriginalWorksViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/15.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "OriginalWorksViewController.h"

@interface OriginalWorksViewController ()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *workView;
@property (strong, nonatomic) UIScrollView *worksInfoView;
@property (strong, nonatomic) UITextView *worksDesc;
@property (strong, nonatomic) UILabel *timeLine;
@property (strong, nonatomic) UIButton *shareBtn;
@end

@implementation OriginalWorksViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.worksInfoView = [[UIScrollView alloc] init];
    [self.view addSubview:self.worksInfoView];
    
    self.iconView = [[UIImageView alloc] init];
    [self.worksInfoView addSubview:self.iconView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.worksInfoView addSubview:self.nameLabel];
    
    self.shareBtn = [[UIButton alloc] init];
    [self.worksInfoView addSubview:self.shareBtn];
    
    self.worksDesc = [[UITextView alloc] init];
    [self.worksInfoView addSubview:self.worksDesc];
    
    self.timeLine = [[UILabel alloc] init];
    [self.worksInfoView addSubview:self.timeLine];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    CGFloat w = self.view.frame.size.width;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((w - 200)/2, 25.0f, 200.0f, 40.0f)];
    [title setText:@"作品详情"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];
    
    [self.jjTabBarView setHidden:YES];
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setWorksInfo:(Works *)workModel{
    
}

@end
