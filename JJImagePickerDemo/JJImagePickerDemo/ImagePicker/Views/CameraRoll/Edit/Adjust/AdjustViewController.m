//
//  AdjustViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "AdjustViewController.h"
#import "JJFilterManager.h"

#define JJ_ADJUSTTOOL_HEIGHT 120

@implementation AdjustViewController

@synthesize image = _image;
@synthesize layerV = _layerV;
@synthesize preViewImage = _preViewImage;
@synthesize adjustView = _adjustView;
@synthesize adToolArrays = _adToolArrays;
@synthesize jjSlider = _jjSlider;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    [self.adjustView setSubToolArray:[NSMutableArray arrayWithArray:_adToolArrays]];
    [self.view addSubview:self.adjustView];
    
    self.layerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - JJ_ADJUSTTOOL_HEIGHT)];
    [self.layerV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.layerV];
    
    //预览图
    [self.layerV addSubview:self.preViewImage];
    [self.view bringSubviewToFront:self.adjustView];
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

#pragma mark lazyLoading
- (EditingSubToolView *)adjustView{
    if(!_adjustView){
        _adjustView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_ADJUSTTOOL_HEIGHT, self.view.bounds.size.width, JJ_ADJUSTTOOL_HEIGHT) ToolType:PhotoEditToolAdjust size:CGSizeMake(80.0f, 100.0f)];
        _adjustView.delegate = self;
    }
    return _adjustView;
}

- (UISlider *)jjSlider{
    if(!_jjSlider){
        _jjSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    }
    
    return _jjSlider;
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

- (void)setAdjustToolArrays:(NSArray *)tools{
    if(!tools){
        return;
    }
    _adToolArrays = tools;
}

#pragma mark - PhotoSubToolEditingDelegate

- (void)PhotoEditSubEditToolDismiss{
    _preViewImage = nil;
    _layerV = nil;
    _adjustView = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)PhotoEditSubEditToolConfirm{
    
}

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV adjustName:(NSString *)name inputAmount:(CGFloat *)amount{
    UIImage *result = [[JJFilterManager getInstance] renderImage:@"" image:_image inputAmount:0];
    [_preViewImage setImage:result];
}

@end
