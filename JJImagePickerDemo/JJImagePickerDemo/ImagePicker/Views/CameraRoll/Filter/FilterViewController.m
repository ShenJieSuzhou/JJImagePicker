//
//  FilterViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/24.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "FilterViewController.h"
#import "JJFilterManager.h"

@interface FilterViewController ()

//滤镜数组
@property (nonatomic, strong) NSArray *filtersArray;

@end

#define JJ_FILTERTOOL_HEIGHT 160

@implementation FilterViewController
@synthesize image = _image;
@synthesize filtersArray = _filtersArray;
@synthesize filterView = _filterView;
@synthesize layerV = _layerV;
@synthesize preViewImage = _preViewImage;
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    //获取滤镜数据
    _filtersArray = [JJFilterManager getInstance].getFiltersArray;
    [self.filterView setBaseFilterImage:_image];
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

#pragma mark lazyLoading
- (EditingSubToolView *)filterView{
    if(!_filterView){
        _filterView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_FILTERTOOL_HEIGHT, self.view.bounds.size.width, JJ_FILTERTOOL_HEIGHT) ToolType:PhotoEditToolFilter size:CGSizeMake(80.0f, 120.0f)];
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
    viewFrame.size.width -= padding;
    viewFrame.size.height -= padding;
    
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.preViewImage.image.size;
    
    if (self.preViewImage.image.size.width > viewFrame.size.width ||
        self.preViewImage.image.size.height > viewFrame.size.height)
    {
        CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
        imageFrame.size.width *= scale;
        imageFrame.size.height *= scale;
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


#pragma mark - PhotoSubToolEditingDelegate
- (void)PhotoEditSubEditToolDismiss{
    _preViewImage = nil;
    _layerV = nil;
    _filterView = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)PhotoEditSubEditToolConfirm{
    if([_delegate respondsToSelector:@selector(filterViewController:didAddFilterToImage:)]){
        [_delegate filterViewController:self didAddFilterToImage:_preViewImage.image];
    }
}

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV filterName:(NSString *)filter{
    UIImage *result = [[JJFilterManager getInstance] renderImage:filter image:_image];
    [_preViewImage setImage:result];
}

@end
