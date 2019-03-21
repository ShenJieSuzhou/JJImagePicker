//
//  CameraPhotoViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CameraPhotoViewController.h"
#import "PhotosViewController.h"
#import "JJImageManager.h"
#import "CameraRollViewController.h"
#import "GlobalDefine.h"

#define CP_BTN_HEIGHT 60.0f
#define CP_BTN_WIDTH self.view.frame.size.width / 2
#define CP_SCREEN_WIDTH self.view.frame.size.width
#define CP_SCREEN_HEIGHT self.view.frame.size.height

@interface CameraPhotoViewController ()

@property (copy, nonatomic) NSArray *bgArray;
@property (strong, nonatomic) UIImageView *bgImgView;
@property (strong, nonatomic) UIButton *albumBtn;
@property (strong, nonatomic) UIButton *cameraBtn;
@property (strong, nonatomic) UIButton *closeBtn;

@end

@implementation CameraPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.bgArray = [NSArray arrayWithObjects:@"ballon", @"pengke", @"bwgirl", @"night", @"yellow", nil];
    [self setupUI];
}

- (void)setupUI{
    NSString *bgName = [self.bgArray objectAtIndex:[self getRandomNumber:0 to:4]];
    self.bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.bgImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", bgName]]];
    [self.view addSubview:self.bgImgView];
    
    self.albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.albumBtn setBackgroundColor:[UIColor colorWithRed:254/255.0f green:63/255.0f blue:120/255.0f alpha:1.0f]];
    [self.albumBtn setImage:[UIImage imageNamed:@"cam_photo"] forState:UIControlStateNormal];
    [self.albumBtn setFrame:CGRectMake((CP_SCREEN_WIDTH - 100.0f)/2, 150, 100.0f, 100.0f)];
    [self.albumBtn.layer setCornerRadius:50.0f];
    [self.albumBtn.layer setMasksToBounds:YES];
    [self.albumBtn addTarget:self action:@selector(clickAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.albumBtn];
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cameraBtn setBackgroundColor:[UIColor colorWithRed:112/255.0f green:166/255.0f blue:255/255.0f alpha:1.0f]];
    [self.cameraBtn setImage:[UIImage imageNamed:@"cam_cam"] forState:UIControlStateNormal];
    [self.cameraBtn setFrame:CGRectMake((CP_SCREEN_WIDTH - 100.0f)/2, 300, 100.0f, 100.0f)];
    [self.cameraBtn.layer setCornerRadius:50.0f];
    [self.cameraBtn.layer setMasksToBounds:YES];
    [self.cameraBtn addTarget:self action:@selector(clickCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cameraBtn];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundColor:[UIColor colorWithWhite:255/255.0f alpha:0.8f]];
    [self.closeBtn setImage:[UIImage imageNamed:@"cam_cancel"] forState:UIControlStateNormal];
    [self.closeBtn setFrame:CGRectMake(0, CP_SCREEN_HEIGHT - CP_BTN_HEIGHT, CP_SCREEN_WIDTH, CP_BTN_HEIGHT)];
    [self.closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeBtn];
}

- (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)clickAlbum:(UIButton *)sender{
    if([JJImageManager requestAlbumPemission] == JJPHAuthorizationStatusNotAuthorized){
        //如果没有获取访问权限，或者访问权限已被明确静止，则显示提示语，引导用户开启授权
        NSLog(@"请在设备的\"设置-隐私-照片\"选项中，允许访问你的手机相册");
    }else{
        //弹出相册选择器
        PhotosViewController *photosView = [PhotosViewController new];
        [photosView setUpGridView:JJ_MAX_PHOTO_NUM min:0];
        //获取相机胶卷的图片
        [self.navigationController pushViewController:photosView animated:YES];
    }
}

- (void)clickCamera:(UIButton *)sender{
    //弹出相机 📷
    CameraRollViewController *cameraView = [[CameraRollViewController alloc] init];
    [self.navigationController pushViewController:cameraView animated:YES];
}

- (void)closeView:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
