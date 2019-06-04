//
//  ContactUsViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/6/4.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController
@synthesize contactText = _contactText;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationItem setTitle:@"联系我们"];
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    _contactText = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 100)];
    _contactText.numberOfLines = 0;
    _contactText.text = @"谢谢你使用我的应用，现在我们是朋友了，有任何问题都可以通过邮件联系我，我会在24小时内处理.\n邮箱：745689122@qq.com";
    [_contactText setTextColor:[UIColor blackColor]];
    [_contactText setFont:[UIFont systemFontOfSize:16.0f]];
    
    [self.view addSubview:_contactText];
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (UILabel *)contactText{
//    if(!_contactText){
//
//
//    }
//    return _contactText;
//}


@end
