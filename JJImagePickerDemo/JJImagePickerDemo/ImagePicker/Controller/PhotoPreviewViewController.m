//
//  PhotoPreviewViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoPreviewViewController.h"
#import "PhotoEditingViewController.h"
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
   
    //背景色去除
    [self.customNaviBar setBackgroundColor:[UIColor clearColor]];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"uls_tb_intro_return_n"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:backBtn withFrame:CGRectMake(20.0f, 22.0f, 14.0f, 23.0f)];
    
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
    [self.jjTabBarView setEditBtnHidden:YES];
    if([self.selectedImageAssetArray count] > 0){
         [self.jjTabBarView.selectedNum setText:[NSString stringWithFormat:@"%lu", (unsigned long)[self.selectedImageAssetArray count]]];
        [self.jjTabBarView.finishBtn setEnabled:YES];
    }else{
        [self.jjTabBarView.finishBtn setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSelectMaxnum:(int)maxnum{
    self.maxSelectedNum = maxnum;
    self.minSelectedNum = 0;
}

- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode{
        
    self.imagesAssetArray = imageAssetArray;
    self.selectedImageAssetArray = selectedImageAssetArray;
    self.currentIndex = currentImageIndex;
    self.singleCheckMode = singleCheckMode;
}

- (void)refreshImagePreview{
    [self.photoPreviewView.photoPreviewImage reloadData];
    [self.photoPreviewView.photoPreviewImage scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

//懒加载
- (JJPhotoPreviewView *)photoPreviewView{
    if(!_photoPreviewView){
        _photoPreviewView = [[JJPhotoPreviewView alloc] initWithFrame:self.view.bounds];
        _photoPreviewView.mDelegate = self;
    }
    
    return _photoPreviewView;
}

////新鲜事发表界面
//- (InterestingViewController *)interestingViewController{
//    if(!_interestingViewController){
//        _interestingViewController = [[InterestingViewController alloc] init];
//    }
//
//    return _interestingViewController;
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
        if([self.selectedImageAssetArray count] == self.maxSelectedNum){
            if(!self.alertTitleWhenPhotoExceedMaxCount){
                self.alertTitleWhenPhotoExceedMaxCount = [NSString stringWithFormat:@"你最多只能选择%@张图片", @(self.maxSelectedNum)];
                NSLog(@"%@", self.alertTitleWhenPhotoExceedMaxCount);
            }
            return;
        }
        
        JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:self.currentIndex];
        [self.selectedImageAssetArray addObject:imageAsset];
        [self.jjTabBarView.finishBtn setEnabled:YES];
        [self.jjTabBarView setSelectedLabelHidden:NO];
        [self.jjTabBarView.selectedNum setText:[NSString stringWithFormat:@"%lu", (unsigned long)[self.selectedImageAssetArray count]]];
        
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
        [self.jjTabBarView.selectedNum setText:[NSString stringWithFormat:@"%lu", (unsigned long)[self.selectedImageAssetArray count]]];
        
        if([self.selectedImageAssetArray count] == 0){
            [self.jjTabBarView.finishBtn setEnabled:NO];
            [self.jjTabBarView setSelectedLabelHidden:YES];
        }
    }
}

- (void)editPhotoBtnClicked:(UIButton *)sender{
//    PhotoEditingViewController *photoEditView = [PhotoEditingViewController new];
//    //获得一个照片对象
//    JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:self.currentIndex];
//
//    [self presentViewController:photoEditView animated:YES completion:^{
//
//    }];
}

- (void)finishBtnClicked:(UIButton *)sender{
    if(self.isPublishViewAsk){
        //添加新选择好的图片
        if([_mDelegate respondsToSelector:@selector(imagePickerPreviewDidFinish:)]){
            [_mDelegate imagePickerPreviewDidFinish:self ];
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        //跳转到编辑文本照片界面
        InterestingViewController *interestingView = [InterestingViewController new];
        [interestingView setSeleImages:self.selectedImageAssetArray];
        //跳转到编辑文本照片界面
        [self presentViewController:interestingView animated:YES completion:^{
            
        }];
    }
}

#pragma -mark JJPhotoPreviewDelegate
- (JJAssetSubType)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView assetTypeAtIndex:(NSUInteger)index{
    JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:index];
    if(imageAsset.assetType == JJAssetTypeImage){
        if(@available(iOS 9.1, *)){
            if(imageAsset.assetSubType == JJAssetSubTypeLivePhoto){
                return JJAssetSubTypeLivePhoto;
            }
        }
        return JJAssetSubTypeImage;
    }else if(imageAsset.assetType == JJAssetTypeVideo){
        return JJAssetSubTypeVideo;
    }else{
        return JJAssetSubTypeUnknow;
    }
}

- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView didScrollToIndex:(NSUInteger)index{
    if(!self.singleCheckMode){
        JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:index];
        self.checkBox.selected = [self.selectedImageAssetArray containsObject:imageAsset];
        self.currentIndex = index;
        if(imageAsset.assetType == JJAssetTypeVideo){
            [self.checkBox setHidden:YES];
        }else{
            [self.checkBox setHidden:NO];
        }
    }
}

- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView renderCell:(JJPreviewViewCollectionCell *)cell atIndex:(NSUInteger)index{
    //得到指定的照片资源
    JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:index];
    cell.identifier = imageAsset.identifier;

    //判断照片类型
    if(imageAsset.assetType == JJAssetTypeVideo){
        //视频
        cell.isVideoType = YES;
        [imageAsset requestPlayerItemWithCompletion:^(AVPlayerItem *playerItem, NSDictionary<NSString *,id> *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if([cell.identifier isEqualToString:imageAsset.identifier]){
                    cell.videoPlayerItem = playerItem;
                }else{
                    cell.videoPlayerItem = nil;
                }
                            });
            
        } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
            
        }];
    }else if(imageAsset.assetType == JJAssetTypeImage){
        if(imageAsset.assetSubType == JJAssetSubTypeLivePhoto){
            //获取图片,
            [imageAsset requestPreviewImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
                //在主线程上更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    if([cell.identifier isEqualToString:imageAsset.identifier]){
                        [cell.previewImage setImage:result];
                    }else{
                        [cell.previewImage setImage:nil];
                    }
                });
            } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
                
            }];
        }else if(imageAsset.assetSubType == JJAssetSubTypeGIF){
            
        }else {
            //获取图片,
            [imageAsset requestPreviewImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
                //在主线程上更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    if([cell.identifier isEqualToString:imageAsset.identifier]){
                        [cell.previewImage setImage:result];
                    }else{
                        [cell.previewImage setImage:nil];
                    }
                });
            } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
                
            }];
        }
    }
}

- (void)imagePreviewView:(JJPhotoPreviewView *)imagePreviewView didHideNaviBarAndToolBar:(BOOL)didHide{
    if(didHide){
        [UIView animateWithDuration:0.1f animations:^{
            [self.customNaviBar setHidden:YES];
            [self.jjTabBarView setHidden:YES];
        }];
    }else{
        [UIView animateWithDuration:0.1f animations:^{
            [self.customNaviBar setHidden:NO];
            [self.jjTabBarView setHidden:NO];
        }];
    }
}

- (NSUInteger)numberOfImagesInImagePreviewView:(JJPhotoPreviewView *)imagePreviewView{
    return [self.imagesAssetArray count];
}

@end
