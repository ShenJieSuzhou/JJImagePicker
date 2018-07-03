//
//  InterestingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "InterestingViewController.h"

@interface InterestingViewController ()

@property (nonatomic, copy) NSArray *selectedImages;

@end

@implementation InterestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.customNaviBar setBackgroundColor:[UIColor lightGrayColor]];
    
    //取消
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarLeftBtn:cancel];
    
    //发表
    UIButton *publish = [UIButton buttonWithType:UIButtonTypeSystem];
    [publish setTitle:@"发表" forState:UIControlStateNormal];
    [publish addTarget:self action:@selector(OnPublishCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarRightBtn:publish];
    
    //不显示
    [self.jjTabBarView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedImages:(NSArray *)selectedImages{
    if(!selectedImages){
        return;
    }
    _selectedImages = selectedImages;
}

- (void)OnCancelCLick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//发表
- (void)OnPublishCLick:(UIButton *)sender{
    //http 请求发送到服务器
    NSLog(@"send .... ");
    
}



@end
