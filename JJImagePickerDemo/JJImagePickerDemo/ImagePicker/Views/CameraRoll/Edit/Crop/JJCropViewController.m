//
//  JJCropViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJCropViewController.h"
#define JJ_EDITTOOL_HEIGHT 110.0f

@interface JJCropViewController ()
@property (nonatomic, strong, readwrite) TOCropView *cropView;
@property (nonatomic, assign) BOOL firstTime;
@end

static const CGFloat kTOCropViewControllerToolbarHeight = 110.0f;

@implementation JJCropViewController
@synthesize editSubToolView = _editSubToolView;

- (instancetype)initWithCroppingStyle:(TOCropViewCroppingStyle)style image:(UIImage *)image{
    self = [super init];
    
    if (self) {
        // Init parameters
        _image = image;
        _croppingStyle = style;
        
        // Set up base view controller behaviour
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        // Controller object that handles the transition animation when presenting / dismissing this app
        _transitionController = [[TOCropViewControllerTransitioning alloc] init];
        
        // Default initial behaviour
        _aspectRatioPreset = TOCropViewControllerAspectRatioPresetOriginal;
        _toolbarPosition = TOCropViewControllerToolbarPositionBottom;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.transitioningDelegate = self;
    self.view.backgroundColor = self.cropView.backgroundColor;
    
    // Layout the views initially
    self.cropView.frame = [self frameForCropViewWithVerticalLayout:self.verticalLayout];
    
    [self.editSubToolView setSubToolArray:_optionsAray];
    [self.view addSubview:self.editSubToolView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    // If we're animating onto the screen, set a flag
    // so we can manually control the status bar fade out timing
    if (animated) {
        self.inTransition = YES;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    // Hide the background content when transitioning for performance
    [self.cropView setBackgroundImageViewHidden:YES animated:NO];
    
    // If an initial aspect ratio was set before presentation, set it now once the rest of
    // the setup will have been done
    if (self.aspectRatioPreset != TOCropViewControllerAspectRatioPresetOriginal) {
        [self setAspectRatioPreset:self.aspectRatioPreset animated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // Disable the transition flag for the status bar
    self.inTransition = NO;
    
    // Re-enable translucency now that the animation has completed
    self.cropView.simpleRenderMode = NO;
    
    // Make the grid overlay view fade in
    if (self.cropView.gridOverlayHidden) {
        [self.cropView setGridOverlayHidden:NO animated:animated];
    }
    
    [self.cropView setBackgroundImageViewHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark lazyLoading
- (EditingSubToolView *)editSubToolView{
    if(!_editSubToolView){
        _editSubToolView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT, self.view.bounds.size.width, JJ_EDITTOOL_HEIGHT) ToolType:PhotoEditToolCrop size:CGSizeMake(70, 80)];
        _editSubToolView.delegate = self;
    }
    return _editSubToolView;
}

- (void)setOptionsAray:(NSMutableArray *)optionsAray{
    _optionsAray = optionsAray;
}

- (TOCropView *)cropView {
    // Lazily create the crop view in case we try and access it before presentation, but
    // don't add it until our parent view controller view has loaded at the right time
    if (!_cropView) {
        _cropView = [[TOCropView alloc] initWithCroppingStyle:self.croppingStyle image:self.image];
//        _cropView.delegate = self;
        _cropView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_cropView];
    }
    return _cropView;
}

#pragma mark - UI Setting
- (CGRect)frameForCropViewWithVerticalLayout:(BOOL)verticalLayout
{
    //On an iPad, if being presented in a modal view controller by a UINavigationController,
    //at the time we need it, the size of our view will be incorrect.
    //If this is the case, derive our view size from our parent view controller instead
    UIView *view = nil;
    if (self.parentViewController == nil) {
        view = self.view;
    }
    else {
        view = self.parentViewController.view;
    }
    
    UIEdgeInsets insets = self.statusBarSafeInsets;
    
    CGRect bounds = view.bounds;
    CGRect frame = CGRectZero;
    
    // Horizontal layout (eg landscape)
    if (!verticalLayout) {
        frame.origin.x = kTOCropViewControllerToolbarHeight + insets.left;
        frame.size.width = CGRectGetWidth(bounds) - frame.origin.x;
        frame.size.height = CGRectGetHeight(bounds);
    }
    else { // Vertical layout
        frame.size.height = CGRectGetHeight(bounds);
        frame.size.width = CGRectGetWidth(bounds);
        
        // Set Y and adjust for height
        if (self.toolbarPosition == TOCropViewControllerToolbarPositionBottom) {
            frame.size.height -= (insets.bottom + kTOCropViewControllerToolbarHeight);
        } else if (self.toolbarPosition == TOCropViewControllerToolbarPositionTop) {
            frame.origin.y = kTOCropViewControllerToolbarHeight + insets.top;
            frame.size.height -= frame.origin.y;
        }
    }
    
    return frame;
}

- (void)adjustCropViewInsets
{
    UIEdgeInsets insets = self.statusBarSafeInsets;
    if (self.verticalLayout) {
        self.cropView.cropRegionInsets = UIEdgeInsetsMake(insets.top, 0.0f, 0.0, 0.0f);
    }
    else {
        self.cropView.cropRegionInsets = UIEdgeInsetsMake(0.0f, 0.0f, insets.bottom, 0.0f);
    }
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    [self adjustCropViewInsets];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.cropView.frame = [self frameForCropViewWithVerticalLayout:self.verticalLayout];
    [self adjustCropViewInsets];
    [self.cropView moveCroppedContentToCenterAnimated:NO];
    
    if (self.firstTime == NO) {
        [self.cropView performInitialSetup];
        self.firstTime = YES;
    }
}

- (void)setCustomAspectRatio:(CGSize)customAspectRatio
{
    _customAspectRatio = customAspectRatio;
    [self setAspectRatioPreset:TOCropViewControllerAspectRatioPresetCustom animated:NO];
}

- (void)setAngle:(NSInteger)angle
{
    self.cropView.angle = angle;
}

- (BOOL)verticalLayout
{
    return CGRectGetWidth(self.view.bounds) < CGRectGetHeight(self.view.bounds);
}

- (BOOL)statusBarHidden
{
    return NO;
}

- (CGFloat)statusBarHeight
{
    if (self.statusBarHidden) {
        return 0.0f;
    }
    
    CGFloat statusBarHeight = 0.0f;
    if (@available(iOS 11.0, *)) {
        statusBarHeight = self.view.safeAreaInsets.top;
    }
    else {
        statusBarHeight = self.topLayoutGuide.length;
    }
    
    return statusBarHeight;
}

- (UIEdgeInsets)statusBarSafeInsets
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = self.view.safeAreaInsets;
        
        // Since iPhone X insets are always 44, check if this is merely
        // accounting for a non-X status bar and cancel it
        if (insets.top <= 20.0f + FLT_EPSILON) {
            insets.top = self.statusBarHeight;
        }
    }
    else {
        insets.top = self.statusBarHeight;
    }
    
    return insets;
}

- (BOOL)aspectRatioLockEnabled
{
    return self.cropView.aspectRatioLockEnabled;
}

#pragma mark - setAspectRatio
- (void)setAspectRatioPreset:(TOCropViewControllerAspectRatioPreset)aspectRatioPreset animated:(BOOL)animated
{
    CGSize aspectRatio = CGSizeZero;
    
    _aspectRatioPreset = aspectRatioPreset;
    
    switch (aspectRatioPreset) {
        case TOCropViewControllerAspectRatioPresetOriginal:
            aspectRatio = CGSizeZero;
            break;
        case TOCropViewControllerAspectRatioPresetSquare:
            aspectRatio = CGSizeMake(1.0f, 1.0f);
            break;
        case TOCropViewControllerAspectRatioPreset3x2:
            aspectRatio = CGSizeMake(3.0f, 2.0f);
            break;
        case TOCropViewControllerAspectRatioPreset5x3:
            aspectRatio = CGSizeMake(5.0f, 3.0f);
            break;
        case TOCropViewControllerAspectRatioPreset4x3:
            aspectRatio = CGSizeMake(4.0f, 3.0f);
            break;
        case TOCropViewControllerAspectRatioPreset3x4:
            aspectRatio = CGSizeMake(3.0f, 4.0f);
            break;
        case TOCropViewControllerAspectRatioPreset5x4:
            aspectRatio = CGSizeMake(5.0f, 4.0f);
            break;
        case TOCropViewControllerAspectRatioPreset7x5:
            aspectRatio = CGSizeMake(7.0f, 5.0f);
            break;
        case TOCropViewControllerAspectRatioPreset16x9:
            aspectRatio = CGSizeMake(16.0f, 9.0f);
            break;
        case TOCropViewControllerAspectRatioPreset9x16:
            aspectRatio = CGSizeMake(9.0f, 16.0f);
            break;
        case TOCropViewControllerAspectRatioPresetCustom:
            aspectRatio = self.customAspectRatio;
            break;
    }
    
    [self.cropView setAspectRatio:aspectRatio animated:animated];
}

#pragma mark - Rotation
- (void)rotateCropViewClockwise
{
    [self.cropView rotateImageNinetyDegreesAnimated:YES clockwise:YES];
}

- (void)rotateCropViewCounterclockwise
{
    [self.cropView rotateImageNinetyDegreesAnimated:YES clockwise:NO];
}

#pragma mark - PhotoSubToolEditingDelegate
//取消裁剪
- (void)PhotoEditSubEditToolDismiss{
    [self.cropView removeFromSuperview];
    self.cropView = nil;
    
    [self.editSubToolView removeFromSuperview];
    self.editSubToolView = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

//裁剪结果提交
- (void)PhotoEditSubEditToolConfirm{
    CGRect cropFrame = self.cropView.imageCropFrame;
    NSInteger angle = self.cropView.angle;
    
    UIImage *cropImage = nil;
    cropImage = [self.image croppedImageWithFrame:cropFrame angle:angle circularClip:NO];
    
    if ([self.delegate respondsToSelector:@selector(cropViewController:didCropToImage:withRect:angle:)]) {
        [self.delegate cropViewController:self didCropToImage:cropImage withRect:cropFrame angle:angle];
    }
}

- (void)PhotoEditSubEditTool:(UICollectionView *)collectionV Tools:(PhotoEditSubTools)tool{
    if (tool == JJAspectRatioPresetSquare) {
        [self setAspectRatioPreset:TOCropViewControllerAspectRatioPresetSquare animated:YES];
    }else if(tool == JJAspectRatioPreset3x4){
        [self setAspectRatioPreset:TOCropViewControllerAspectRatioPreset3x4 animated:YES];
    }else if (tool == JJAspectRatioPreset4x3){
        [self setAspectRatioPreset:TOCropViewControllerAspectRatioPreset4x3 animated:YES];
    }else if(tool == JJAspectRatioPreset9x16){
        [self setAspectRatioPreset:TOCropViewControllerAspectRatioPreset9x16 animated:YES];
    }else if(tool == JJAspectRatioPreset16x9){
        [self setAspectRatioPreset:TOCropViewControllerAspectRatioPreset16x9 animated:YES];
    }else if(tool == JJRotateViewClockwise){
        [self rotateCropViewClockwise];
    }
}

@end
