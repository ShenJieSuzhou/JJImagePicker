//
//  PhotosViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotosViewController.h"
#import "DropButton.h"
#import "CameraRollView.h"
#import "GridView.h"
#import "JJImageManager.h"
#import "PhotoPreviewViewController.h"
#import "InterestingViewController.h"
#import "PhotoEditingViewController.h"

@interface PhotosViewController ()<CameraRollViewDelegate, JJImagePickerViewControllerDelegate, PhotoPreviewViewControllerDelegate>

@property (nonatomic, strong) CameraRollView *cameraRollView;

@property (nonatomic, strong) GridView *photoGridView;

@property (nonatomic, strong) NSMutableArray<JJPhotoAlbum *> *albumsArray;

@property (nonatomic, strong) DropButton *cameraRoll;

@property (nonatomic, strong) PhotoPreviewViewController *photoPreviewViewController;

@property (nonatomic, strong) InterestingViewController *interestingViewController;

@property (assign) int maxImgNum;

@property (nonatomic, strong) NSMutableArray *imageAssetsArray;

@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;

@end

@implementation PhotosViewController
@synthesize cameraRollView = _cameraRollView;
@synthesize photoGridView = _photoGridView;
@synthesize albumsArray = _albumsArray;
@synthesize cameraRoll = _cameraRoll;
@synthesize photoPreviewViewController = _photoPreviewViewController;
@synthesize interestingViewController = _interestingViewController;
@synthesize delegate = _delegate;
@synthesize maxImgNum = _maxImgNum;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageAssetsArray = [[NSMutableArray alloc] init];
    self.selectedAssetsArray = [[NSMutableArray alloc] init];
    
    [self setupUI];
    [self loadAlbumAsset];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //网格照片
    [self.view addSubview:self.photoGridView];
}

- (void)setupUI{
    //设置标题
    _cameraRoll = [DropButton buttonWithType:UIButtonTypeCustom withSpace:12.0f];
    _cameraRoll.buttonStyle = JJSButtonImageRight;
    [_cameraRoll setTitle:@"相机胶卷" forState:UIControlStateNormal];
    [_cameraRoll setImage:[UIImage imageNamed:@"gallery_title_arrow"] forState:UIControlStateNormal];
    [_cameraRoll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cameraRoll.backgroundColor = [UIColor clearColor];
    [_cameraRoll addTarget:self action:@selector(OnCameraRollClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setTitlebtn:_cameraRoll];
    
    //取消
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"edit_close"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:backBtn withFrame:CGRectMake(20.0f, 29.0f, 16.0f, 16.0f)];
    
    //相簿
    _cameraRollView = [[CameraRollView alloc] initWithFrame:CGRectMake(0, [CustomNaviBarView barSize].height, self.view.frame.size.width, self.view.frame.size.height - [CustomNaviBarView barSize].height)];
    _cameraRollView.delegate = self;
    
    //底部tabBarView按钮添加事件
    [self.jjTabBarView.previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.jjTabBarView.finishBtn addTarget:self action:@selector(imagePickViewFinishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if(!self.photoGridView.isAllowedMutipleSelect){
        [self.jjTabBarView setHidden:YES];
    }
    
    [self.jjTabBarView.previewBtn setEnabled:NO];
    [self.jjTabBarView setPreViewBtnHidden:NO];
    [self.jjTabBarView setEditBtnHidden:YES];
}

- (void)loadAlbumAsset{
    self.albumsArray = [[NSMutableArray alloc] init];
    //获取相册的耗时操作，交由子线程去处理 ,开启loading效果
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __weak typeof(self)weakSelf = self;
        [[JJImageManager getInstance] getAllAlbumsWithAlbumContentType:JJAlbumContentTypeAll showEmptyAlbum:NO showSmartAlbum:YES usingBlock:^(JJPhotoAlbum *resultAlbum) {
            //需要对界面进行操作，放入主线程执行
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if(resultAlbum){
                    [strongSelf.albumsArray addObject:resultAlbum];
                }else{
                    [strongSelf refreshAlbumAndShow];
                }
            });
        }];
    });
}

- (GridView *)photoGridView{
    if(!_photoGridView){
        _photoGridView = [[GridView alloc] initWithFrame:CGRectMake(0, [CustomNaviBarView barSize].height, self.view.frame.size.width, self.view.frame.size.height - [CustomNaviBarView barSize].height - 50.0f)];
        [_photoGridView setGridImagesAsset:self.imageAssetsArray];
        [_photoGridView setGridselectedImagesAsset:self.selectedAssetsArray];
        
        _photoGridView.mDelegate = self;
        _photoGridView.isAllowedMutipleSelect = YES;
    }
    return _photoGridView;
}

- (void)setUpGridView:(int)maxNum min:(int)minNum{
    _maxImgNum = maxNum;
    self.photoGridView.maxSelectedNum = maxNum;
    self.photoGridView.minSelectedNum = minNum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedPhotos:(NSMutableArray *)selectedImages{
    if(!self.photoGridView){
//        [self.photoGridView updateSelectedImageArray:selectedImages];
    }
}

- (void)OnCameraRollClick:(id)sender{
    DropButton *cameraRollBtn = (DropButton *)sender;
    
    [cameraRollBtn setSelected:!cameraRollBtn.isSelected];
    if(cameraRollBtn.isSelected){
        [cameraRollBtn setImage:[UIImage imageNamed:@"gallery_title_arrow_up"] forState:UIControlStateNormal];
        [self.view addSubview:_cameraRollView];
    }else{
        [cameraRollBtn setImage:[UIImage imageNamed:@"gallery_title_arrow"] forState:UIControlStateNormal];
        [_cameraRollView removeFromSuperview];
    }
}

//点击取消操作，跳转到app主界面
- (void)OnCancelCLick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.photoGridView.selectedImageAssetArray removeAllObjects];
    }];
}

//调整标题按钮的箭头方向
- (void)adjustTitleButtonStyle{
    [_cameraRoll setSelected:!_cameraRoll.isSelected];
    if(_cameraRoll.isSelected){
        [_cameraRoll setImage:[UIImage imageNamed:@"gallery_title_arrow_up"] forState:UIControlStateNormal];
    }else{
        [_cameraRoll setImage:[UIImage imageNamed:@"gallery_title_arrow"] forState:UIControlStateNormal];
    }
}

//大图预览界面
- (PhotoPreviewViewController *)photoPreviewViewController{
    if(!_photoPreviewViewController){
        _photoPreviewViewController = [[PhotoPreviewViewController alloc] init];
        _photoPreviewViewController.mDelegate = self;
        [_photoPreviewViewController setUpSelectMaxnum:_maxImgNum];
    }
    
    return _photoPreviewViewController;
}

//新鲜事发表界面
- (InterestingViewController *)interestingViewController{
    if(!_interestingViewController){
        _interestingViewController = [[InterestingViewController alloc] init];
    }
    return _interestingViewController;
}

/*
 * 刷新相册
 */
- (void)refreshAlbumAndShow{
    if([self.albumsArray count] > 0){
        //hide loading

        //初始化网格照片界面
        JJPhotoAlbum *album = [self.albumsArray objectAtIndex:0];
        [_cameraRoll setTitle:[album albumName] forState:UIControlStateNormal];
        [self.photoGridView refreshPhotoAsset:album];

        //初始化相薄界面
        [_cameraRollView refreshAlbumAseets:self.albumsArray];
    }else{
        NSLog(@"+++++没有照片++++++");
    }
}

#pragma -mark CameraRollViewDelegate
- (void)imagePickerViewControllerForCameraRollView:(JJPhotoAlbum *)album{
    [self adjustTitleButtonStyle];
    [_cameraRoll setTitle:[album albumName] forState:UIControlStateNormal];
    //加载网格照片界面
    [_photoGridView refreshPhotoAsset:album];
}

#pragma -mark JJImagePickerViewControllerDelegate
- (void)JJImagePickerViewController:(GridView *)gridView selectAtIndex:(NSIndexPath *)indexath{
    if(self.isPublishViewAsk){
        self.photoPreviewViewController.isPublishViewAsk = YES;
    }
    //初始化预览相册，当前显示的照片索引
    [self.photoPreviewViewController initImagePickerPreviewViewWithImagesAssetArray:self.imageAssetsArray selectedImageAssetArray:self.selectedAssetsArray currentImageIndex:indexath.row singleCheckMode:NO];

    [self presentViewController:self.photoPreviewViewController animated:YES completion:^{

    }];
}

- (void)JJImagePickerViewController:(GridView *)gridView selectedNum:(NSUInteger)selectedCounts{
    if(selectedCounts > 0){
        [self.jjTabBarView.previewBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.jjTabBarView.previewBtn setEnabled:YES];
        [self.jjTabBarView setSelectedLabelHidden:NO];
        [self.jjTabBarView.finishBtn setEnabled:YES];
        [self.jjTabBarView.selectedNum setText:[NSString stringWithFormat:@"%lu", (unsigned long)selectedCounts]];
    }else{
        [self.jjTabBarView.previewBtn setEnabled:NO];
        [self.jjTabBarView.previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.jjTabBarView.finishBtn setEnabled:NO];
        [self.jjTabBarView setSelectedLabelHidden:YES];
    }
}

- (void)JJImagePickerViewController:(GridView *)gridView exceedMaxCount:(NSString *)alert{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"" message:alert preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertView animated:YES completion:nil];
    [self performSelector:@selector(dismiss:) withObject:alertView afterDelay:1.0];
}

- (void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark 底部按钮点击事件
- (void)previewBtnClick:(UIButton *)sender{
    if(self.isPublishViewAsk){
        self.photoPreviewViewController.isPublishViewAsk = YES;
    }
    //初始化预览相册，当前显示的照片索引
    [self.photoPreviewViewController initImagePickerPreviewViewWithImagesAssetArray:self.imageAssetsArray selectedImageAssetArray:self.selectedAssetsArray currentImageIndex:0 singleCheckMode:NO];
    
    [self presentViewController:self.photoPreviewViewController animated:YES completion:^{
        
    }];
}

- (void)imagePickViewFinishBtnClick:(UIButton *)sender{
    if(self.isPublishViewAsk){
        //添加新选择好的图片
        if([_delegate respondsToSelector:@selector(photoViewToPublishCallback:viewCtrl:)]){
            [_delegate photoViewToPublishCallback:self.photoGridView.selectedImageAssetArray viewCtrl:self];
        }
    }else{
        //跳转到编辑文本照片界面
        [self.interestingViewController setPublishSelectedImages:self.selectedAssetsArray];
        //跳转到编辑文本照片界面
        [self presentViewController:self.interestingViewController animated:YES completion:^{
            
        }];
    }
}

#pragma -mark PhotoPreviewViewControllerDelegate
- (void)imagePickerPreviewViewController:(PhotoPreviewViewController *)previewViewController didCheckImageAtIndex:(NSInteger)index{
    if([self.selectedAssetsArray count] > 0){
        [self.jjTabBarView.previewBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.jjTabBarView.previewBtn setEnabled:YES];
        [self.jjTabBarView setSelectedLabelHidden:NO];
        [self.jjTabBarView.finishBtn setEnabled:YES];
        [self.jjTabBarView.selectedNum setText:[NSString stringWithFormat:@"%lu", (unsigned long)[self.selectedAssetsArray count]]];
    }
    
    [self.photoGridView.photoCollectionView reloadData];
}


- (void)imagePickerPreviewViewController:(PhotoPreviewViewController *)previewViewController didUncheckImageAtIndex:(NSInteger)index{
    if([self.selectedAssetsArray count] == 0){
        [self.jjTabBarView.previewBtn setEnabled:NO];
        [self.jjTabBarView.previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.jjTabBarView.finishBtn setEnabled:NO];
        [self.jjTabBarView setSelectedLabelHidden:YES];
    }
    [self.photoGridView.photoCollectionView reloadData];
}

- (void)imagePickerPreviewDidFinish:(PhotoPreviewViewController *)previewViewController{
    if([_delegate respondsToSelector:@selector(photoViewToPublishCallback:viewCtrl:)]){
        [_delegate photoViewToPublishCallback:self.photoGridView.selectedImageAssetArray viewCtrl:self];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
