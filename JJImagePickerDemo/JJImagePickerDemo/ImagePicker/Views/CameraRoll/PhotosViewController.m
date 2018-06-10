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

@interface PhotosViewController ()

@property (nonatomic, strong) CameraRollView *cameraRollView;

@property (nonatomic, strong) GridView *photoGridView;

@property (nonatomic, strong) NSMutableArray<JJPhotoAlbum *> *albumsArray;

@end

@implementation PhotosViewController
@synthesize cameraRollView = _cameraRollView;
@synthesize photoGridView = _photoGridView;
@synthesize albumsArray = _albumsArray;;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([JJImageManager requestAlbumPemission] == JJPHAuthorizationStatusNotAuthorized){
        //如果没有获取访问权限，或者访问权限已被明确静止，则显示提示语，引导用户开启授权
        NSLog(@"请在设备的\"设置-隐私-照片\"选项中，允许访问你的手机相册");
    }else{
        self.albumsArray = [[NSMutableArray alloc] init];
        //获取相册的耗时操作，交由子线程去处理 ,开启loading效果
        
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            __weak typeof(self)weakSelf = self;
            [[JJImageManager getInstance] getAllAlbumsWithAlbumContentType:JJAlbumContentTypeAll showEmptyAlbum:NO showSmartAlbum:YES usingBlock:^(JJPhotoAlbum *resultAlbum) {
                //需要对界面进行操作，放入主线程执行
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    if(resultAlbum){
                        [strongSelf.albumsArray addObject:resultAlbum];
                    }else{
                        [strongSelf refreshAlbumAndShow];
                    }
                });
            }];
        });
    }
    
    //设置标题
    DropButton *cameraRoll = [DropButton buttonWithType:UIButtonTypeCustom withSpace:12.0f];
    cameraRoll.buttonStyle = JJSButtonImageRight;
    [cameraRoll setTitle:@"相机胶卷" forState:UIControlStateNormal];
    [cameraRoll setImage:[UIImage imageNamed:@"gallery_title_arrow"] forState:UIControlStateNormal];
    [cameraRoll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cameraRoll.backgroundColor = [UIColor clearColor];
    [cameraRoll addTarget:self action:@selector(OnCameraRollClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setTitlebtn:cameraRoll];
    
    //取消
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarRightBtn:cancel];
    
    //相簿
    _cameraRollView = [[CameraRollView alloc] initWithFrame:CGRectMake(0, [CustomNaviBarView barSize].height, self.view.frame.size.width, self.view.frame.size.height - [CustomNaviBarView barSize].height)];
    
    _photoGridView = [[GridView alloc] initWithFrame:CGRectMake(0, [CustomNaviBarView barSize].height, self.view.frame.size.width, self.view.frame.size.height - [CustomNaviBarView barSize].height)];
    
    [self.view addSubview:_photoGridView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)OnCancelCLick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


/*
 * 刷新相册
 */
- (void)refreshAlbumAndShow{
    if([self.albumsArray count] > 0){
        //hide loading
        //初始化网格照片界面
        JJPhotoAlbum *album = [self.albumsArray objectAtIndex:0];
        [_photoGridView refreshPhotoAsset:album];
        //初始化相薄界面
//        [_cameraRollView refreshAlbumAseets:self.albumsArray];
    }else{
        NSLog(@"没有照片");
    }
}



@end