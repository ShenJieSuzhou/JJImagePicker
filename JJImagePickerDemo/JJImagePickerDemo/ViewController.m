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
#import "HomeViewController.h"
#import "MeViewController.h"
#import "CameraRollViewController.h"

@interface ViewController ()

@property (strong, nonatomic) PhotoEditingViewController *photoEditingView;
@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) MeViewController *meViewController;
@property (strong, nonatomic) CameraRollViewController *cameraViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
 
    _homeViewController = [HomeViewController new];
    _meViewController = [MeViewController new];
    _cameraViewController = [CameraRollViewController new];
    
    [self setupChildViewController:@"探索" viewController:_homeViewController image:@"" selectedImage:@""];
    [self setupChildViewController:@"相机" viewController:_cameraViewController image:@"" selectedImage:@""];
    [self setupChildViewController:@"个人中心" viewController:_meViewController image:@"" selectedImage:@""];
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
//    DemoViewController *demoView = [DemoViewController new];
//    [self presentViewController:demoView animated:YES completion:^{
//        
//    }];
}


- (PhotoEditingViewController *)photoEditingView{
    if(!_photoEditingView){
        _photoEditingView = [[PhotoEditingViewController alloc] init];
    }
    return _photoEditingView;
}

- (void)setupChildViewController:(NSString *)title
                  viewController:(UIViewController *)controller
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage {
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    controller.tabBarItem = item;
    controller.title = title;
    [self addChildViewController:controller];
}

@end
