//
//  PhotoPreviewViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoPreviewViewController.h"
#import "GlobalDefine.h"

@interface PhotoPreviewViewController ()

@end

@implementation PhotoPreviewViewController
@synthesize photoPreviewView = _photoPreviewView;
@synthesize imagesAssetArray = _imagesAssetArray;
@synthesize selectedImageAssetArray = _selectedImageAssetArray;
@synthesize mDelegate = _mDelegate;
@synthesize currentIndex = _currentIndex;
@synthesize singleCheckMode = _singleCheckMode;
@synthesize previewSelectedMode = _previewSelectedMode;
@synthesize maxSelectedNum = _maxSelectedNum;
@synthesize minSelectedNum = _minSelectedNum;
@synthesize alertTitleWhenPhotoExceedMaxCount = _alertTitleWhenPhotoExceedMaxCount;
@synthesize checkBox = _checkBox;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.maxSelectedNum = JJ_MAX_PHOTO_NUM;
    self.minSelectedNum = 0;
    
    //背景色去除
    [self.customNaviBar setBackgroundColor:[UIColor clearColor]];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"uls_tb_intro_return_n"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:backBtn withFrame:CGRectMake(20.0f, 22.0f, 14.0f, 23.0f)];
    
    //标题
//    [self.customNaviBar setTitle:@"123/1000" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15.0f]];
    
    //CheckBox
    self.checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkBox setBackgroundImage:[UIImage imageNamed:@"chooseInterest_uncheaked"] forState:UIControlStateNormal];
    [self.checkBox setBackgroundImage:[UIImage imageNamed:@"chooseInterest_cheaked"] forState:UIControlStateSelected];
    [self.checkBox setBackgroundColor:[UIColor clearColor]];
    [self.checkBox addTarget:self action:@selector(checkBoxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:self.checkBox withFrame:CGRectMake(self.view.bounds.size.width - 45.0f, 22.0f, 25.0f, 25.0f)];
    
    //添加预览图视图
    [self.view addSubview:self.photoPreviewView];
    
    [self.jjTabBarView.editBtn addTarget:self action:@selector(editPhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.jjTabBarView.finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshImagePreview];
    //标记该照片是否在选中行列
    if(!self.singleCheckMode){
        JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:self.currentIndex];
        self.checkBox.selected = [self.selectedImageAssetArray containsObject:imageAsset];
    }
    
    [self.jjTabBarView setPreViewBtnHidden:YES];
    [self.jjTabBarView setEditBtnHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode{
        
    self.imagesAssetArray = [imageAssetArray copy];
    self.selectedImageAssetArray = selectedImageAssetArray;
    self.currentIndex = currentImageIndex;
    self.singleCheckMode = singleCheckMode;
//    self.previewSelectedMode = NO;
    
}

//- (void)initImagePickerPreviewWithSelectedImages:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
//                               currentImageIndex:(NSInteger)currentImageIndex{
//
//    self.selectedImageAssetArray = selectedImageAssetArray;
//    self.currentIndex = currentImageIndex;
//    self.previewSelectedMode = YES;
//}

- (void)refreshImagePreview{
//    if(self.previewSelectedMode){
//        [self.photoPreviewView initImagePickerPreviewWithSelectedImages:self.selectedImageAssetArray currentImageIndex:self.currentIndex];
//    }else{
        [self.photoPreviewView initImagePickerPreviewViewWithImagesAssetArray:self.imagesAssetArray selectedImageAssetArray:self.selectedImageAssetArray currentImageIndex:self.currentIndex singleCheckMode:self.singleCheckMode];
//    }
}

//懒加载
- (JJPhotoPreviewView *)photoPreviewView{
    if(!_photoPreviewView){
        _photoPreviewView = [[JJPhotoPreviewView alloc] initWithFrame:self.view.bounds];
        _photoPreviewView.mDelegate = self;
    }
    
    return _photoPreviewView;
}

//- (NSMutableArray<JJPhoto *> *)imagesAssetArray{
//    if(!_imagesAssetArray){
//        _imagesAssetArray = [[NSMutableArray alloc] init];
//    }
//
//    return _imagesAssetArray;
//}
//
//- (NSMutableArray<JJPhoto *> *)selectedImageAssetArray{
//    if(!_selectedImageAssetArray){
//        _selectedImageAssetArray = [[NSMutableArray alloc] init];
//    }
//
//    return _selectedImageAssetArray;
//}

//返回到imagePickView
- (void)backBtnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
//        [self.photoPreviewView removeFromSuperview];
    }];
}

//点击CheckBox
- (void)checkBoxBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        //添加
        if([self.selectedImageAssetArray count] >= self.maxSelectedNum){
            if(!self.alertTitleWhenPhotoExceedMaxCount){
                self.alertTitleWhenPhotoExceedMaxCount = [NSString stringWithFormat:@"你最多只能选择%@张图片", @(self.maxSelectedNum)];
            }
            
            NSLog(@"%@", self.alertTitleWhenPhotoExceedMaxCount);
        }
        
        JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:self.currentIndex];
        [self.selectedImageAssetArray addObject:imageAsset];
        
        if([_mDelegate respondsToSelector:@selector(imagePickerPreviewViewController:didCheckImageAtIndex:)]){
            [_mDelegate imagePickerPreviewViewController:self didCheckImageAtIndex:self.currentIndex];
        }
    }else{
        //删除
        if([_mDelegate respondsToSelector:@selector(imagePickerPreviewViewController:didUncheckImageAtIndex:)]){
            [_mDelegate imagePickerPreviewViewController:self didUncheckImageAtIndex:self.currentIndex];
        }
        
        JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:self.currentIndex];
        [self.selectedImageAssetArray removeObject:imageAsset];
    }
}

- (void)editPhotoBtnClicked:(UIButton *)sender{
    
}

- (void)finishBtnClicked:(UIButton *)sender{
    
}

#pragma -mark JJPhotoPreviewDelegate
- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView didScrollToIndex:(NSUInteger)index{
    if(!self.singleCheckMode){
        JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:index];
        self.checkBox.selected = [self.selectedImageAssetArray containsObject:imageAsset];
        self.currentIndex = index;
    }
}

@end
