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
//    [JJImageViewPicker showTheActionsheet:self];
    
    UIImage *photoImage = [UIImage imageNamed:@"22.jpg"];
    __weak typeof(self) weakSelf = self;
    [self presentViewController:self.photoEditingView animated:YES completion:^{
        [weakSelf.photoEditingView setEditImage:photoImage];
    }];
}

- (PhotoEditingViewController *)photoEditingView{
    if(!_photoEditingView){
        _photoEditingView = [[PhotoEditingViewController alloc] init];
    }
    return _photoEditingView;
}

@end
