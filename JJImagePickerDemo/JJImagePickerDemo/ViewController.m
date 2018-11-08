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
#import "CameraPhotoViewController.h"
#import "CustomTabbar.h"

#import "InterestingViewController.h"

@interface ViewController ()<JJTabBarDelegate>

@property (strong, nonatomic) PhotoEditingViewController *photoEditingView;
@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) MeViewController *meViewController;
@property (strong, nonatomic) CameraPhotoViewController *cpViewController;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    CustomTabbar *cusTabbar = [[CustomTabbar alloc] init];
    cusTabbar.mdelegate = self;
    [self setValue:cusTabbar forKeyPath:@"tabBar"];
    
    _homeViewController = [HomeViewController new];
    _meViewController = [MeViewController new];

    [self setupChildViewController:@"首页" viewController:_homeViewController image:@"" selectedImage:@""];
    [self setupChildViewController:@"个人中心" viewController:_meViewController image:@"" selectedImage:@""];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)tabBar:(CustomTabbar *)tabBar clickCenterButton:(UIButton *)sender{
    self.cpViewController = [CameraPhotoViewController new];
    [self presentViewController:self.cpViewController animated:YES completion:^{

    }];
    
//    InterestingViewController *publishView = [InterestingViewController new];
//    [publishView setSelectedImages:[[NSMutableArray alloc] init]];
//    [self presentViewController:publishView animated:YES completion:^{
//
//    }];
}

@end
