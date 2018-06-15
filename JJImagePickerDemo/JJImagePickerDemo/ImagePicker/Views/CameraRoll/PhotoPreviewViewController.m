//
//  PhotoPreviewViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoPreviewViewController.h"

@interface PhotoPreviewViewController ()

@end

@implementation PhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //背景色去除
    [self.customNaviBar setBackgroundColor:[UIColor clearColor]];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"uls_tb_intro_return_n"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:backBtn];
    
    //标题
    [self.customNaviBar setTitle:@"123/1000" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15.0f]];
    
    //CheckBox
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBox setBackgroundImage:[UIImage imageNamed:@"QMUI_previewImage_checkbox"] forState:UIControlStateNormal];
    [checkBox setBackgroundImage:[UIImage imageNamed:@"QMUI_previewImage_checkbox_checked"] forState:UIControlStateSelected];
    [checkBox setBackgroundColor:[UIColor clearColor]];
    [checkBox addTarget:self action:@selector(checkBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:checkBox];
    
    //添加预览图视图
    [self.view addSubview:self.photoPreviewView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode{
        
    [self.photoPreviewView initImagePickerPreviewViewWithImagesAssetArray:imageAssetArray selectedImageAssetArray:selectedImageAssetArray currentImageIndex:currentImageIndex singleCheckMode:singleCheckMode];
    
}


//懒加载
- (JJPhotoPreviewView *)photoPreviewView{
    if(!_photoPreviewView){
        _photoPreviewView = [[JJPhotoPreviewView alloc] initWithFrame:self.view.bounds];
    }
    
    return _photoPreviewView;
}

//返回到imagePickView
- (void)backBtnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//点击CheckBox
- (void)checkBoxBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

@end
