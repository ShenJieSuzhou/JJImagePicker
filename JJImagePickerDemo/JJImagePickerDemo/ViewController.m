//
//  ViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ViewController.h"
#import "JJImageViewPicker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    [JJImageViewPicker showTheActionsheet:self];
}



@end
