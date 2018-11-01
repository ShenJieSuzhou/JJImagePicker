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
@synthesize adjustHashMap = _adjustHashMap;
@synthesize jjAdjustType = _jjAdjustType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    _adjustHashMap = [[NSMutableDictionary alloc] init];
    
    [self.adjustView setSubToolArray:[NSMutableArray arrayWithArray:_adToolArrays]];
    [self.view addSubview:self.adjustView];
    
    self.layerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - JJ_ADJUSTTOOL_HEIGHT)];
    [self.layerV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.layerV];
    
    //预览图
    [self.layerV addSubview:self.preViewImage];
    [self.view bringSubviewToFront:self.adjustView];

    //test add slider
    [self.view addSubview:self.jjSlider];
    [self.jjSlider setHidden:YES];
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

- (CustomSlider *)jjSlider{
    if(!_jjSlider){
        _jjSlider = [[CustomSlider alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_ADJUSTTOOL_HEIGHT - 60, self.view.bounds.size.width, 60) Title:@"美白" color:[UIColor redColor]];
        _jjSlider.delegate = self;
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
    viewFrame.size.width -= padding;
    viewFrame.size.height -= padding;
    
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

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV adjustType:(PhotoEditAdjustTYPE)adjustType{
    [self.jjSlider setHidden:NO];
    if(adjustType == JJSmoothSkinAdjust){
        //美白默认参数 5
        _jjAdjustType = JJSmoothSkinAdjust;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithBeauty:_image inputAmount:5];
        [_preViewImage setImage:result];
    }else if(adjustType == JJExposureAdjust){
        _jjAdjustType = JJExposureAdjust;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithExposure:_image inputAmount:0.5];
        [_preViewImage setImage:result];
    }else if(adjustType == JJTemperatureAdjsut){
        _jjAdjustType = JJTemperatureAdjsut;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithTemperature:_image inputAmount:0.0];
        [_preViewImage setImage:result];
    }else if(adjustType == JJContrastAdjust){
        _jjAdjustType = JJContrastAdjust;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithContrast:_image inputAmount:1.0];
        [_preViewImage setImage:result];
    }else if(adjustType == JJSaturationAdjsut){
        _jjAdjustType = JJSaturationAdjsut;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithSaturation:_image inputAmount:0.0f];
        [_preViewImage setImage:result];
    }else if(adjustType == JJShapeAdjust){
        _jjAdjustType = JJShapeAdjust;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithSharpen:_image inputAmount:0.4f];
        [_preViewImage setImage:result];
    }else if(adjustType == JJDarkangleAdjust){
        _jjAdjustType = JJDarkangleAdjust;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithDarkangle:_image inputAmount:0.0f];
        [_preViewImage setImage:result];
    }
}

#pragma mark - CustomSliderDelegate
- (void)customSliderValueChangeCallBacK:(float)value{
    if(_jjAdjustType == JJSmoothSkinAdjust){
        CGFloat ff = value / 10.0f;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithBeauty:_image inputAmount:ff];
        [_preViewImage setImage:result];
    }else if(_jjAdjustType == JJExposureAdjust){
        CGFloat ff = value / 100.0f;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithExposure:_image inputAmount:ff];
        [_preViewImage setImage:result];
    }else if(_jjAdjustType == JJTemperatureAdjsut){
        CGFloat ff = (value - 50.0f)/100;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithTemperature:_image inputAmount:ff];
        [_preViewImage setImage:result];
    }else if(_jjAdjustType == JJContrastAdjust){
        CGFloat ff = (value - 50.0f);
        if(ff < 0){
            ff = (ff + 100) / 200 + 0.5;
        }else{
            ff = (ff + 50)/100 + 1;
        }
        UIImage *result = [[JJFilterManager getInstance] renderImageWithContrast:_image inputAmount:ff];
        [_preViewImage setImage:result];
    }else if(_jjAdjustType == JJSaturationAdjsut){
        CGFloat ff = value/100 + 1;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithSaturation:_image inputAmount:ff];
        [_preViewImage setImage:result];
    }else if(_jjAdjustType == JJShapeAdjust){
        CGFloat ff = value/10;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithSharpen:_image inputAmount:ff];
        [_preViewImage setImage:result];
    }else if(_jjAdjustType == JJDarkangleAdjust){
        CGFloat ff = value/10;
        UIImage *result = [[JJFilterManager getInstance] renderImageWithDarkangle:_image inputAmount:ff];
        [_preViewImage setImage:result];
    }
}

@end
