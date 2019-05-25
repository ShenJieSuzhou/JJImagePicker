//
//  MyWebViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "MyWebViewController.h"

@interface MyWebViewController ()

@end

@implementation MyWebViewController
@synthesize itemWebView = _itemWebView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}


- (void)loadRequest:(NSString *)url{
    [self.itemWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:self.itemWebView];
}


- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (WKWebView *)itemWebView{
    if(!_itemWebView){
        _itemWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    }
    
    return _itemWebView;
}

@end
