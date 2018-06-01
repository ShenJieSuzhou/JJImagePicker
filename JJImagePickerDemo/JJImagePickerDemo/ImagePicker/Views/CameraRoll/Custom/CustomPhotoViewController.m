//
//  CustomPhotoViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CustomPhotoViewController.h"
#import "GlobalDefine.h"
@interface CustomPhotoViewController ()

@end

@implementation CustomPhotoViewController

@synthesize customNaviBar = _customNaviBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _customNaviBar = [[CustomNaviBarView alloc] initWithFrame:Rect(0, 0, [CustomNaviBarView barSize].width, [CustomNaviBarView barSize].height)];
    [_customNaviBar setBackgroundColor:[UIColor whiteColor]];
    _customNaviBar.m_viewCtrlParent = self;
    
    [self.view addSubview:_customNaviBar];
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_customNaviBar && !_customNaviBar.hidden){
        [self.view bringSubviewToFront:_customNaviBar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bringNaviBarToTopmost
{
    if (_customNaviBar)
    {
        [self.view bringSubviewToFront:_customNaviBar];
    }
}

- (void)setNaviBarTitle:(NSString *)strTitle color:(UIColor *)color font:(UIFont *)font{
    if(_customNaviBar){
        [_customNaviBar setTitle:strTitle textColor:color font:font];
    }
}

- (void)setNaviBarLeftBtn:(UIButton *)leftBtn{
    if(_customNaviBar){
        [_customNaviBar setLeftBtn:leftBtn];
    }
}

- (void)setNaviBarRightBtn:(UIButton *)rightBtn{
    if(_customNaviBar){
        [_customNaviBar setRightBtn:rightBtn];
    }
}

- (void)setTitlebtn:(UIButton *)titleBtn{
    if(_customNaviBar){
        [_customNaviBar setTitleBtn:titleBtn];
    }
}

@end
