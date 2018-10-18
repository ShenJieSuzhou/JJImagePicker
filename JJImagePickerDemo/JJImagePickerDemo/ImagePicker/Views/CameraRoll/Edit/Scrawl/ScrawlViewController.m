//
//  ScrawlViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ScrawlViewController.h"
#define BUTTOM_VIEW_HEIGHT 100.0f

@interface ScrawlViewController ()

@end

@implementation ScrawlViewController
@synthesize image = _image;
@synthesize layerV = _layerV;
@synthesize preViewImage = _preViewImage;
@synthesize scrawlAdjustView = _scrawlAdjustView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    //底部调整视图
    [self.view addSubview:self.scrawlAdjustView];
    //预览层
    self.layerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - BUTTOM_VIEW_HEIGHT)];
    [self.layerV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.layerV];
    [self.layerV addSubview:self.preViewImage];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
}

#pragma mark - lazyLoad
- (ScrawlAdjustView *)scrawlAdjustView{
    if(!_scrawlAdjustView){
        _scrawlAdjustView = [[ScrawlAdjustView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - BUTTOM_VIEW_HEIGHT, self.view.bounds.size.width, BUTTOM_VIEW_HEIGHT)];
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

@end
