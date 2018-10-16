//
//  ViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ViewController.h"
#import "JJImageViewPicker.h"
#import "PhotoEditingViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@property (strong, nonatomic) PhotoEditingViewController *photoEditingView;

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
    UIImage *photoImage = [UIImage imageNamed:@"p1"];
    [self.photoEditingView setEditImage:photoImage];
    [self presentViewController:self.photoEditingView animated:YES completion:^{
        
    }];
}

- (IBAction)openWeb:(id)sender {
    DemoViewController *demoView = [DemoViewController new];
    [self presentViewController:demoView animated:YES completion:^{
        
    }];
}


- (PhotoEditingViewController *)photoEditingView{
    if(!_photoEditingView){
        _photoEditingView = [[PhotoEditingViewController alloc] init];
    }
    return _photoEditingView;
}

@end
