//
//  WelcomeViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/11.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "WelcomeViewController.h"
#import "ViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}


- (IBAction)skip:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
