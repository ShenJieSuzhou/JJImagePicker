//
//  EditAvaterViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/4/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "EditAvaterViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CropAvaterViewController.h"
#import "JJImageUploadManager.h"
#import "GlobalDefine.h"
#import "JJTokenManager.h"


#import <SVProgressHUD/SVProgressHUD.h>


#define MODIFIY_BUTTON_WIDTH 140.0f
#define MODIFIY_BUTTON_HEIGHT 45.0f

@interface EditAvaterViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, EditAvaterDelegate, CropAvaterDelegate>

@property (strong, nonatomic) UIButton *changeAvaterBtn;
@property (strong, nonatomic) UIImageView *avaterView;

@end

@implementation EditAvaterViewController
@synthesize delegate = _delegate;
@synthesize avaterUrl = _avaterUrl;
@synthesize changeAvaterBtn = _changeAvaterBtn;
@synthesize avaterView = _avaterView;
@synthesize cropAvaterView = _cropAvaterView;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.navigationItem setTitle:@"个人头像"];
    UIImage *img = [[UIImage imageNamed:@"in_pay_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClicked)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self.view addSubview:self.avaterView];
    [self.view addSubview:self.changeAvaterBtn];
    
    [self.avaterView sd_setImageWithURL:[NSURL URLWithString:_avaterUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (UIImageView *)avaterView{
    if(!_avaterView){
        _avaterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    }
    return _avaterView;
}

- (UIButton *)changeAvaterBtn{
    if(!_changeAvaterBtn){
        _changeAvaterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeAvaterBtn setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - MODIFIY_BUTTON_WIDTH) / 2, [UIScreen mainScreen].bounds.size.height - 120, MODIFIY_BUTTON_WIDTH, MODIFIY_BUTTON_HEIGHT)];
        [_changeAvaterBtn setTitle:@"修改头像" forState:UIControlStateNormal];
        [_changeAvaterBtn setBackgroundColor:[UIColor clearColor]];
        [_changeAvaterBtn.layer setCornerRadius:12.0f];
        [_changeAvaterBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_changeAvaterBtn.layer setBorderWidth:1.0f];
        [_changeAvaterBtn.layer setMasksToBounds:YES];
        [_changeAvaterBtn addTarget:self action:@selector(clickChangeAvaterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeAvaterBtn;
}

// 修改头像， 进入相册选择后上传服务器
- (void)clickChangeAvaterBtn:(UIButton *)sender{
    // 弹出系统相册
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [alertController addAction:destructiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)leftBarBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqual:@"public.image"]) {
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        _cropAvaterView = [[CropAvaterViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:originImage];
        _cropAvaterView.delegate = self;
        [self.navigationController pushViewController:_cropAvaterView animated:YES];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CropAvaterDelegate
- (void)cropAvater:(nonnull CropAvaterViewController *)cropViewController didCropToImage:(nonnull UIImage *)image{
    // 上传图床
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //将所选的图片上传至云
     __weak typeof(self) weakself = self;
    [[JJImageUploadManager shareInstance] uploadImageToQN:image uploadResult:^(BOOL isSuccess, NSString *file) {
        if(isSuccess){
            // 回调 并保存头像
            [weakself.delegate EditAvaterSuccessCallBack:file localImg:image viewControl:weakself];
        }else{
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismiss];
            return;
        }
    }];
}


//[SVProgressHUD show];
//[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//NSString *nickName = self.nickNameField.text;
//__weak typeof(self) weakself = self;
//[HttpRequestUtil JJ_UpdateUserNickName:UPDATE_NICKNAME_REQUEST token:[JJTokenManager shareInstance].getUserToken name:nickName userid:[JJTokenManager shareInstance].getUserID callback:^(NSDictionary *data, NSError *error) {
//    [SVProgressHUD dismiss];
//    if(error){
//        NSLog(@"%@", error);
//        [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
//        [SVProgressHUD dismissWithDelay:2.0f];
//        return ;
//    }
//    if([[data objectForKey:@"result"] isEqualToString:@"1"]){
//        [weakself.delegate EditNameSuccessCallBack:nickName viewController:weakself];
//    }else{
//        [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
//        [SVProgressHUD dismissWithDelay:2.0f];
//    }
//}];

@end
