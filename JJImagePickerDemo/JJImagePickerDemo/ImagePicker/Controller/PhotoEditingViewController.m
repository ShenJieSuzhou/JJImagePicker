//
//  PhotoEditingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoEditingViewController.h"
#import "JJEditTool.h"
#import "JJLoadConfig.h"

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
@synthesize croppedFrame = _croppedFrame;
@synthesize angle = _angle;
@synthesize layerV = _layerV;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
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
    if(!self.editData){
        self.editData = [[JJLoadConfig getInstance] getCustomContent];
    }

    self.editToolView = [[EditingToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT, self.view.bounds.size.width, JJ_EDITTOOL_HEIGHT)];
    self.editToolView.delegate = self;
    self.editToolView.toolArray = [self parseDataToObject:self.editData];
    [self.view addSubview:self.editToolView];
    
    self.layerV = [[UIView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT - self.customNaviBar.frame.size.height)];
    [self.layerV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.layerV];
    
    //预览图
    [self.layerV addSubview:self.preViewImage];
    [self.view bringSubviewToFront:self.editToolView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
}

#pragma mark - Image Layout -
- (void)layoutImageView
{
    if (self.preViewImage.image == nil)
        return;
    
    CGFloat padding = 20.0f;
    
    CGRect viewFrame = self.layerV.frame;
    viewFrame.size.width -= (padding * 2.0f);
    viewFrame.size.height -= (padding * 2.0f);
    
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.preViewImage.image.size;
    
    if (self.preViewImage.image.size.width > viewFrame.size.width ||
        self.preViewImage.image.size.height > viewFrame.size.height)
    {
        CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
        imageFrame.size.width *= (scale - 0.05);
        imageFrame.size.height *= (scale - 0.05);
        imageFrame.origin.x = (CGRectGetWidth(self.layerV.frame) - imageFrame.size.width) * 0.5f;
        imageFrame.origin.y = (CGRectGetHeight(self.layerV.frame) - imageFrame.size.height) * 0.5f;
        self.preViewImage.frame = imageFrame;
    }
    else {
        imageFrame.origin.x = (CGRectGetWidth(self.layerV.frame) - imageFrame.size.width) * 0.5f;
        imageFrame.origin.y = (CGRectGetHeight(self.layerV.frame) - imageFrame.size.height) * 0.5f;
        self.preViewImage.frame = imageFrame;
        self.preViewImage.center = (CGPoint){CGRectGetMidX(viewFrame), CGRectGetMidY(viewFrame)};
    }
}

#pragma mark - image process business
- (void)setEditImage:(UIImage *)image{
    if(!image){
        return;
    }
    
    [self.preViewImage setImage:image];
}

- (UIImageView *)preViewImage{
    if(!_preViewImage){
        _preViewImage = [[UIImageView alloc] init];
        _preViewImage.userInteractionEnabled = YES;
        _preViewImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _preViewImage;
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

- (NSMutableArray *)parseDataToObject:(NSDictionary *)fieldDic{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if(![fieldDic objectForKey:@"field"]){
        NSLog(@" parseDataToObject error");
        return nil;
    }
    
    NSArray *tArray = [fieldDic objectForKey:@"field"];

    for (int i = 0; i < [tArray count]; i++) {
        NSDictionary *dic = [tArray objectAtIndex:i];
        NSString *title = [dic objectForKey:@"title"];
        NSString *name = [dic objectForKey:@"name"];
        NSString *imagePath = [dic objectForKey:@"imagePath"];
        NSMutableArray *subTools = [dic objectForKey:@"subTools"];
        
        JJEditToolType toolType;
        if([name isEqualToString:@"crop"]){
            toolType = JJEditToolCrop;
        }else if([name isEqualToString:@"adjust"]){
            toolType = JJEditToolAdjust;
        }else if([name isEqualToString:@"filter"]){
            toolType = JJEditToolFilter;
        }else if([name isEqualToString:@"sticker"]){
            toolType = JJEditToolSticker;
        }else if([name isEqualToString:@"playWords"]){
            toolType = JJEditToolWords;
        }else if([name isEqualToString:@"Brush"]){
            toolType = JJEditToolBrush;
        }else if([name isEqualToString:@"tag"]){
            toolType = JJEditToolTag;
        }else if([name isEqualToString:@"scrawl"]){
            toolType = JJEditToolscrawl;
        }else if([name isEqualToString:@"bigHeader"]){
            toolType = JJEditToolscrawl;
        }
    
        JJEditTool *model = [[JJEditTool alloc] initWithName:name title:title path:imagePath type:toolType array:subTools];
        [tempArray addObject:model];
    }
    
    return tempArray;
}

/*
 "name": "crop",
 "imagePath": "editor_crop",
 "subTools":
 */

#pragma mark - PhotoEditingDelegate
- (void)PhotoEditingFinished:(UIImage *)image{
    
}

- (void)PhotoEditShowSubEditTool:(UICollectionView *)collectionV Index:(NSInteger)index array:(NSArray *)array{
    //switch 语句来判断跳转哪一个界面
    JJEditTool *toolModel = [self.editToolView.toolArray objectAtIndex:index];
    switch (toolModel.jjToolType) {
        case JJEditToolCrop:{
            JJCropViewController *jjCropView = [[JJCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:self.preViewImage.image];
            jjCropView.delegate = self;
            //加载裁剪
            [jjCropView setOptionsAray:[NSMutableArray arrayWithArray:array]];
            [self presentViewController:jjCropView animated:YES completion:^{
                
            }];
            
        }
            break;
        case JJEditToolAdjust:{
            AdjustViewController *adjustView = [AdjustViewController new];
            [adjustView setEditImage:self.preViewImage.image];
            [adjustView setAdToolArrays:array];
            [self presentViewController:adjustView animated:YES completion:^{
                
            }];
        }
            break;
        case JJEditToolFilter:{
            FilterViewController *jjFilterView = [FilterViewController new];
            jjFilterView.delegate = self;
            [jjFilterView setEditImage:[UIImage imageNamed:@"filter4"]];
            [self presentViewController:jjFilterView animated:YES completion:^{
                
            }];
        }
            break;
        case JJEditToolSticker:
            break;
        case JJEditToolWords:
            break;
        case JJEditToolBrush:
            break;
        case JJEditToolTag:
            break;
        case JJEditToolscrawl:
            break;
        default:
            break;
    }
}

- (void)PhotoEditSubEditToolDismiss{

}

- (void)PhotoEditSubEditToolConfirm{

}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(JJCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    
    self.preViewImage.image = image;
    [self layoutImageView];
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)filterViewController:(nonnull FilterViewController *)filterViewController didAddFilterToImage:(nonnull UIImage *)image{
    self.preViewImage.image = image;
    [self layoutImageView];
    
    [filterViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end