//
//  PhotoEditingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoEditingViewController.h"


#define JJ_DEFAULT_IMAGE_PADDING 50
#define JJ_EDITTOOL_HEIGHT 100

@interface PhotoEditingViewController ()

@end

@implementation PhotoEditingViewController
@synthesize delegate = _delegate;
@synthesize preViewImage = _preViewImage;
@synthesize preImage = _preImage;
@synthesize editToolView = _editToolView;
@synthesize editData = _editData;
@synthesize jjCropView = _jjCropView;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    //背景色去除
    [self.customNaviBar setBackgroundColor:[UIColor whiteColor]];
    [self.jjTabBarView setHidden:YES];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"uls_tb_intro_return_n"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:backBtn withFrame:CGRectMake(20.0f, 22.0f, 14.0f, 23.0f)];
    
    //完成
    UIButton *finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishedBtn setBackgroundImage:[UIImage imageNamed:@"chooseInterest_cheaked"] forState:UIControlStateSelected];
    [finishedBtn setBackgroundColor:[UIColor clearColor]];
    [finishedBtn addTarget:self action:@selector(finishedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:finishedBtn withFrame:CGRectMake(self.view.bounds.size.width - 45.0f, 22.0f, 25.0f, 25.0f)];
    
    //底部工具栏
    self.editData = [self loadEditToolConfigFile];
    if(![self.editData objectForKey:@"field"]){
        NSLog(@"配置文件加载失败");
        return;
    }

    self.editToolView = [[EditingToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT, self.view.bounds.size.width, JJ_EDITTOOL_HEIGHT)];
    self.editToolView.delegate = self;
    self.editToolView.toolArray = [self.editData objectForKey:@"field"];
    [self.view addSubview:self.editToolView];
    
    //预览图
    self.preViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.editToolView.frame.size.height)];
    [self.preViewImage setBackgroundColor:[UIColor clearColor]];
    self.preViewImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.preViewImage];
    [self.view bringSubviewToFront:self.editToolView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



#pragma mark - init edit tool
- (NSDictionary *)loadEditToolConfigFile{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark - image process business
- (void)setEditImage:(UIImage *)image{
    if(!image){
        return;
    }
    
    [self.preViewImage setImage:image];
}

//返回
- (void)backBtnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//finished 完成
- (void)finishedBtnClick:(UIButton *)sender{
    //跳转到发布页面
    
}

#pragma mark - PhotoEditingDelegate
- (void)PhotoEditingFinished:(UIImage *)image{
    
}

- (void)PhotoEditShowSubEditTool:(UICollectionView *)collectionV Index:(NSInteger)index array:(NSArray *)array{
    //switch 语句来判断跳转哪一个界面
    
    //加载裁剪
    [self.editToolView setHidden:YES];
    JJCropViewController *jjCropView = [[JJCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:self.preViewImage.image];
    
    [jjCropView setOptionsAray:[NSMutableArray arrayWithArray:array]];
    [self presentViewController:jjCropView animated:YES completion:^{
        
    }];
}

- (void)PhotoEditSubEditToolDismiss{
//    [self.editSubToolView removeFromSuperview];
//    self.editSubToolView = nil;
    [self.editToolView setHidden:NO];
}

- (void)PhotoEditSubEditToolConfirm{
    
}

@end
