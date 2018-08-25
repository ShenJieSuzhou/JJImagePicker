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

#define JJ_FILTERTOOL_HEIGHT 100

@implementation FilterViewController
@synthesize image = _image;
@synthesize filtersArray = _filtersArray;
@synthesize filterView = _filterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setFilters];
    [self.filterView setSubToolArray:[NSMutableArray arrayWithArray:_filtersArray]];
    [self.view addSubview:self.filterView];
}

- (void)setFilters{
    
    _filtersArray = @[
                 @{@"name":@"Original",                 @"title":@"原图",        @"version":@(0.0)},
                 @{@"name":@"CISRGBToneCurveToLinear",  @"title":@"暮光",     @"version":@(7.0)},
                 @{@"name":@"CIVignetteEffect",         @"title":@"LOMO",   @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectInstant",     @"title":@"流年",    @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectProcess",     @"title":@"雪青",    @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectTransfer",    @"title":@"优格",   @"version":@(7.0)},
                 @{@"name":@"CISepiaTone",              @"title":@"晚秋",      @"version":@(5.0)},
                 @{@"name":@"CIPhotoEffectChrome",      @"title":@"淡雅",     @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectFade",        @"title":@"拿铁",       @"version":@(7.0)},
                 @{@"name":@"CILinearToSRGBToneCurve",  @"title":@"丽日",      @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectTonal",       @"title":@"灰度",      @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectNoir",        @"title":@"暗调",       @"version":@(7.0)},
                 @{@"name":@"CIPhotoEffectMono",        @"title":@"黑白",       @"version":@(7.0)},
                 @{@"name":@"CIColorInvert",            @"title":@"负片",     @"version":@(6.0)},
                 ];
}

#pragma mark lazyLoading
- (EditingSubToolView *)filterView{
    if(!_filterView){
        _filterView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_FILTERTOOL_HEIGHT, self.view.bounds.size.width, JJ_FILTERTOOL_HEIGHT)];
        _filterView.delegate = self;
    }
    return _filterView;
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
