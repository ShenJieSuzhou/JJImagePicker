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

@property (nonatomic, strong) NSMutableArray *photosArray;

@end

@implementation PhotosViewController
@synthesize cameraRollView = _cameraRollView;
@synthesize photoGridView = _photoGridView;
@synthesize photosArray = _photosArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([JJImageManager requestAlbumPemission] == JJPHAuthorizationStatusNotAuthorized){
        //如果没有获取访问权限，或者访问权限已被明确静止，则显示提示语，引导用户开启授权
//        NSString *tipString =
    }else{
        self.photosArray = [[NSMutableArray alloc] init];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            __weak typeof(self)weakSelf = self;
            
            
            
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


//懒加载
- (void)setCameraRollView:(CameraRollView *)cameraRollView{
    
    
}


@end
