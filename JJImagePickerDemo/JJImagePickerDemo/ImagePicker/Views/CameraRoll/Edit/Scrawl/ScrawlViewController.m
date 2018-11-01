//
//  ScrawlViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ScrawlViewController.h"
#import "PKMosaicDrawingboard.h"
#import "UIImage+Mosaic.h"

#define BUTTOM_VIEW_HEIGHT 120.0f
#define MOSAIC_PADDING 20.0f

@interface ScrawlViewController ()
//油画
@property (nonatomic, strong) PKMosaicDrawingboard *mosaicDrawingboard;
@end

@implementation ScrawlViewController
@synthesize image = _image;
@synthesize layerV = _layerV;
@synthesize preViewImage = _preViewImage;
@synthesize scrawlAdjustView = _scrawlAdjustView;
@synthesize withdrawalBtn = _withdrawalBtn;
@synthesize mosaicDrawingboard = _mosaicDrawingboard;
@synthesize sToolArrays = _sToolArrays;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //添加油画马赛克视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mosaicDrawingboard];
    // 默认开始编辑
    [self.mosaicDrawingboard beginPaint];
    [self.mosaicDrawingboard setMosaicBrushImage:[UIImage imageNamed:@"mosaic_asset_12"]];
    //底部视图
    [self.scrawlAdjustView setSubToolArray:[NSMutableArray arrayWithArray:self.sToolArrays]];
    [self.view addSubview:self.scrawlAdjustView];
}

#pragma mark - lazyLoad
- (PKMosaicDrawingboard *)mosaicDrawingboard {
    if (!_mosaicDrawingboard) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _mosaicDrawingboard = [[PKMosaicDrawingboard alloc] initWithFrame:CGRectMake(0, MOSAIC_PADDING, width , height -  BUTTOM_VIEW_HEIGHT - MOSAIC_PADDING)];
    }
    return _mosaicDrawingboard;
}

- (EditingSubToolView *)scrawlAdjustView{
    if(!_scrawlAdjustView){
        _scrawlAdjustView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - BUTTOM_VIEW_HEIGHT, self.view.bounds.size.width, BUTTOM_VIEW_HEIGHT) ToolType:PhotoEditToolScrawl size:CGSizeMake(60.0f, 80.0f)];
        _scrawlAdjustView.delegate = self;
    }
    return _scrawlAdjustView;
}

#pragma mark - image process business
- (void)setEditImage:(UIImage *)image{
    if(!image){
        return;
    }
    _image = image;
    self.mosaicDrawingboard.image = self.image;
}

- (void)setScrawlToolArrays:(NSArray *)tools{
    if(!tools){
        return;
    }
    _sToolArrays = tools;
}

#pragma mark - PhotoSubToolEditingDelegate
- (void)PhotoEditSubEditToolDismiss{
    [self.mosaicDrawingboard cancelPaint];
    self.mosaicDrawingboard = nil;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)PhotoEditSubEditToolConfirm{
     UIImage *image = [self.mosaicDrawingboard compeletePaint];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV actionType:(PhotoEditScrawlType)scrawlType{
    
    if(scrawlType == PhotoEditScrawl_Pen_1X){
        [self.mosaicDrawingboard setMosaicBrushImage:[UIImage imageNamed:@"mosaic_asset_12_0.5"]];
    }else if(scrawlType == PhotoEditScrawl_Pen_2X){
        [self.mosaicDrawingboard setMosaicBrushImage:[UIImage imageNamed:@"mosaic_asset_12_0.75"]];
    }else if(scrawlType == PhotoEditScrawl_Pen_3X){
        [self.mosaicDrawingboard setMosaicBrushImage:[UIImage imageNamed:@"mosaic_asset_12"]];
    }else if(scrawlType == PhotoEditScrawl_Pen_4X){
        [self.mosaicDrawingboard setMosaicBrushImage:[UIImage imageNamed:@"mosaic_asset_12_1.25"]];
    }else if(scrawlType == PhotoEditScrawl_Pre){
        [self.mosaicDrawingboard last];
    }else if(scrawlType == PhotoEditScrawl_Next){
        [self.mosaicDrawingboard next];
    }
}

//- (void)dealloc {
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"lastAble"];
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"nextAble"];
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"touching"];
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"painting"];
//}

@end
