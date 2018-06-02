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
@interface PhotosViewController ()

@property (nonatomic, strong) CameraRollView *cameraRollView;

@end

@implementation PhotosViewController
@synthesize cameraRollView = _cameraRollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        
        
    }else{
        [cameraRollBtn setImage:[UIImage imageNamed:@"gallery_title_arrow"] forState:UIControlStateNormal];
        
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
