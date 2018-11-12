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
@synthesize jjTabBarView = _jjTabBarView;
@synthesize isPublishViewAsk = _isPublishViewAsk;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _customNaviBar = [[CustomNaviBarView alloc] initWithFrame:Rect(0, 0, [CustomNaviBarView barSize].width, [CustomNaviBarView barSize].height)];
    [_customNaviBar setBackgroundColor:[UIColor whiteColor]];
    _customNaviBar.m_viewCtrlParent = self;
    
    [self.view addSubview:_customNaviBar];
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0]];
    
    [self.view addSubview:self.jjTabBarView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_customNaviBar && !_customNaviBar.hidden){
        [self.view bringSubviewToFront:_customNaviBar];
    }
    
    if(self.jjTabBarView && !self.jjTabBarView.hidden){
        [self.view bringSubviewToFront:self.jjTabBarView];
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

//底部视图
- (TabBarView *)jjTabBarView{
    if(!_jjTabBarView){
        _jjTabBarView = [[TabBarView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
        [_jjTabBarView setBackgroundColor:[UIColor whiteColor]];
    }
    
    return _jjTabBarView;
}

@end
