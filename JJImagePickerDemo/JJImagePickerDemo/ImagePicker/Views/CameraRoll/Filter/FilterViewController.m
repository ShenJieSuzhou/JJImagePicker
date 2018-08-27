//
//  FilterViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

//滤镜数组
@property (nonatomic, strong) NSArray *filtersArray;

@end

#define JJ_FILTERTOOL_HEIGHT 150

@implementation FilterViewController
@synthesize image = _image;
@synthesize filtersArray = _filtersArray;
@synthesize filterView = _filterView;
@synthesize layerV = _layerV;
@synthesize preViewImage = _preViewImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    
    [self setFilters];
    [self.filterView setSubToolArray:[NSMutableArray arrayWithArray:_filtersArray]];
    [self.view addSubview:self.filterView];
    
    self.layerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - JJ_FILTERTOOL_HEIGHT)];
    [self.layerV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.layerV];
    
    //预览图
    [self.layerV addSubview:self.preViewImage];
    [self.view bringSubviewToFront:self.filterView];
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

- (void)setFilters{
    _filtersArray = @[
                 @{@"name":@"Original",                 @"title":@"原图", @"imageName":@"filterDemo",    @"version":@(0.0)},
                 @{@"name":@"CISRGBToneCurveToLinear",  @"title":@"暮光", @"imageName":@"filterDemo",    @"version":@(7.0)},
                 @{@"name":@"CIVignetteEffect",         @"title":@"LOMO",@"imageName":@"filterDemo",   @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectInstant",     @"title":@"流年", @"imageName":@"filterDemo",   @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectProcess",     @"title":@"雪青", @"imageName":@"filterDemo",   @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectTransfer",    @"title":@"优格", @"imageName":@"filterDemo",  @"version":@(7.0)},
                 @{@"name":@"CISepiaTone",              @"title":@"晚秋", @"imageName":@"filterDemo",     @"version":@(5.0)},
                 @{@"name":@"CIPhotoEffectChrome",      @"title":@"淡雅", @"imageName":@"filterDemo",    @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectFade",        @"title":@"拿铁", @"imageName":@"filterDemo",      @"version":@(7.0)},
                 @{@"name":@"CILinearToSRGBToneCurve",  @"title":@"丽日", @"imageName":@"filterDemo",     @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectTonal",       @"title":@"灰度", @"imageName":@"filterDemo",     @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectNoir",        @"title":@"暗调", @"imageName":@"filterDemo",      @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectMono",        @"title":@"黑白", @"imageName":@"filterDemo",      @"version":@(7.0)},
                 @{@"name":@"CIColorInvert",            @"title":@"负片", @"imageName":@"filterDemo",    @"version":@(6.0)},
                 ];
}

#pragma mark lazyLoading
- (EditingSubToolView *)filterView{
    if(!_filterView){
        _filterView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_FILTERTOOL_HEIGHT, self.view.bounds.size.width, JJ_FILTERTOOL_HEIGHT) ToolType:PhotoEditToolFilter size:CGSizeMake(100.0f, 120.0f)];
        _filterView.delegate = self;
    }
    return _filterView;
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


#pragma mark - PhotoSubToolEditingDelegate
//取消裁剪
- (void)PhotoEditSubEditToolDismiss{

}

//裁剪结果提交
- (void)PhotoEditSubEditToolConfirm{

}

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV Tools:(PhotoEditSubTools)tool{

}


@end
