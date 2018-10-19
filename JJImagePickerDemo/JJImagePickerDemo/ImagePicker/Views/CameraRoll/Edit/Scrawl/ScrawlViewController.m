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

#define BUTTOM_VIEW_HEIGHT 100.0f

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
    
    [self setupViews];
    [self setupEvents];
    [self bindData];
    
    // 默认开始编辑
    [self.mosaicDrawingboard beginPaint];
    [self.mosaicDrawingboard setMosaicBrushImage:[UIImage imageNamed:@"mosaic_asset_12_1.25"]];
    //底部调整视图
    [self.scrawlAdjustView setSubToolArray:[NSMutableArray arrayWithArray:self.sToolArrays]];
    [self.view addSubview:self.scrawlAdjustView];
}

/*
 * @brief 撤销操作
 */
- (void)clickWithdrawalBtn:(UIButton *)sender{
    NSLog(@"撤销");
}

- (void)setupViews {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mosaicDrawingboard];
}

- (void)setupEvents {
//    UIImage *(^resizeImageBlock)(NSInteger) = ^UIImage *(NSInteger index){
//        NSString *name = @"";
//        // 图片1倍大小是50x50
//        // 从小到大0.5, 0.75, 1.0, 1.25倍. 注意图片像素不要出现.5
//        switch (index) {
//            case 0:
//                name = @"mosaic_asset_12_0.5";
//                break;
//            case 1:
//                name = @"mosaic_asset_12_0.75";
//                break;
//            case 2:
//                name = @"mosaic_asset_12";
//                break;
//            case 3:
//                name = @"mosaic_asset_12_1.25";
//                break;
//            default:
//                break;
//        }
//        UIImage *image =  [UIImage imageNamed:name];
//        NSCAssert(image, @"没有该图片资源");
//        return image;
//    };
//    __weak typeof(self) wself = self;
    // titleBar
//    [self.titleBar setLeftActionBlock:^(UIButton *button){
//        [wself.mosaicDrawingboard cancelPaint];
//        [wself popback];
//    }];
//
//    [self.titleBar setRihtActionBlock:^(UIButton *button){
//        UIImage *image = [wself.mosaicDrawingboard compeletePaint];
//        if (wself.resultImageBlock) wself.resultImageBlock(image);
//        [wself popback];
//    }];
    
//    [self.bottomToolBar setBrushBlock:^(NSInteger index){
//        switch (index) {
//            case 0: {
//                [wself.mosaicDrawingboard setMosaicBrushImage:resizeImageBlock(0)];
//            }
//                break;
//            case 1: {
//                [wself.mosaicDrawingboard setMosaicBrushImage:resizeImageBlock(1)];
//            }
//                break;
//            case 2: {
//                [wself.mosaicDrawingboard setMosaicBrushImage:resizeImageBlock(2)];
//            }
//                break;
//            case 3: {
//                [wself.mosaicDrawingboard setMosaicBrushImage:resizeImageBlock(3)];
//            }
//                break;
//
//            default:
//                break;
//        }
//    }];
    
//    [self.bottomToolBar setLastOrNextClickBlock:^(BOOL isLast){
//        if (isLast) {
//            [wself.mosaicDrawingboard last];
//        } else {
//            [wself.mosaicDrawingboard next];
//        }
//    }];
}

- (void)bindData {
    self.mosaicDrawingboard.image = self.image;
    
//    [self.mosaicDrawingboard addObserver:self forKeyPath:@"lastAble" options:NSKeyValueObservingOptionInitial context:NULL];
//    [self.mosaicDrawingboard addObserver:self forKeyPath:@"nextAble" options:NSKeyValueObservingOptionInitial context:NULL];
//    [self.mosaicDrawingboard addObserver:self forKeyPath:@"touching" options:NSKeyValueObservingOptionInitial context:NULL];
//    [self.mosaicDrawingboard addObserver:self forKeyPath:@"painting" options:NSKeyValueObservingOptionInitial context:NULL];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"lastAble"]) {
//        self.bottomToolBar.lastButton.enabled = self.mosaicDrawingboard.lastAble;
//    } else if ([keyPath isEqualToString:@"nextAble"]){
//        self.bottomToolBar.nextButton.enabled = self.mosaicDrawingboard.nextAble;
//    } else if ([keyPath isEqualToString:@"touching"]){
//        self.bottomToolBar.brushEnable = !self.mosaicDrawingboard.touching;
//    } else if ([keyPath isEqualToString:@"painting"]){
//        self.titleBar.rightButton.hidden = !self.mosaicDrawingboard.painting;
//    }
//}

#pragma mark - lazyLoad
- (PKMosaicDrawingboard *)mosaicDrawingboard {
    if (!_mosaicDrawingboard) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _mosaicDrawingboard = [[PKMosaicDrawingboard alloc] initWithFrame:CGRectMake(0, 64, width, height - 64 - BUTTOM_VIEW_HEIGHT)];
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
    _image = image;
}

- (void)setScrawlToolArrays:(NSArray *)tools{
    if(!tools){
        return;
    }
    _sToolArrays = tools;
}

//- (void)dealloc {
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"lastAble"];
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"nextAble"];
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"touching"];
//    [self.mosaicDrawingboard removeObserver:self forKeyPath:@"painting"];
//}

@end
