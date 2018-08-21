//
//  JJCropViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJCropViewController.h"
#define JJ_EDITTOOL_HEIGHT 100

@interface JJCropViewController ()
@property (nonatomic, strong, readwrite) TOCropView *cropView;
/* Flag to perform initial setup on the first run */
@property (nonatomic, assign) BOOL firstTime;
@end

static const CGFloat kTOCropViewControllerToolbarHeight = 100.0f;

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
//懒加载
- (EditingSubToolView *)editSubToolView{
    if(!_editSubToolView){
        _editSubToolView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT, self.view.bounds.size.width, JJ_EDITTOOL_HEIGHT)];
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
        _cropView.delegate = self;
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

- (void)setResetAspectRatioEnabled:(BOOL)resetAspectRatioEnabled
{
    self.cropView.resetAspectRatioEnabled = resetAspectRatioEnabled;
    if (!self.aspectRatioPickerButtonHidden) {
        self.aspectRatioPickerButtonHidden = (resetAspectRatioEnabled == NO && self.aspectRatioLockEnabled);
    }
}

- (void)setCustomAspectRatio:(CGSize)customAspectRatio
{
    _customAspectRatio = customAspectRatio;
    [self setAspectRatioPreset:TOCropViewControllerAspectRatioPresetCustom animated:NO];
}

- (BOOL)resetAspectRatioEnabled
{
    return self.cropView.resetAspectRatioEnabled;
}

- (void)setAngle:(NSInteger)angle
{
    self.cropView.angle = angle;
}

- (NSInteger)angle
{
    return self.cropView.angle;
}

- (void)setImageCropFrame:(CGRect)imageCropFrame
{
    self.cropView.imageCropFrame = imageCropFrame;
}

- (CGRect)imageCropFrame
{
    return self.cropView.imageCropFrame;
}

- (BOOL)verticalLayout
{
    return CGRectGetWidth(self.view.bounds) < CGRectGetHeight(self.view.bounds);
}

//- (BOOL)overrideStatusBar
//{
//    // If we're pushed from a navigation controller, we'll defer
//    // to its handling of the status bar
//    if (self.navigationController) {
//        return NO;
//    }
//
//    // If the view controller presenting us already hid it, we don't need to
//    // do anything ourselves
//    if (self.presentingViewController.prefersStatusBarHidden) {
//        return NO;
//    }
//
//    // We'll handle the status bar
//    return YES;
//}

- (BOOL)statusBarHidden
{
    // Defer behavioir to the hosting navigation controller
//    if (self.navigationController) {
//        return self.navigationController.prefersStatusBarHidden;
//    }
//
//    //If our presenting controller has already hidden the status bar,
//    //hide the status bar by default
//    if (self.presentingViewController.prefersStatusBarHidden) {
//        return YES;
//    }

    // Our default behaviour is to always hide the status bar
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

- (void)setMinimumAspectRatio:(CGFloat)minimumAspectRatio
{
    self.cropView.minimumAspectRatio = minimumAspectRatio;
}

- (CGFloat)minimumAspectRatio
{
    return self.cropView.minimumAspectRatio;
}

- (void)setAspectRatioLockEnabled:(BOOL)aspectRatioLockEnabled
{
    self.cropView.aspectRatioLockEnabled = aspectRatioLockEnabled;
    if (!self.aspectRatioPickerButtonHidden) {
        self.aspectRatioPickerButtonHidden = (aspectRatioLockEnabled && self.resetAspectRatioEnabled == NO);
    }
}

- (void)setAspectRatioLockDimensionSwapEnabled:(BOOL)aspectRatioLockDimensionSwapEnabled
{
    self.cropView.aspectRatioLockDimensionSwapEnabled = aspectRatioLockDimensionSwapEnabled;
}

- (BOOL)aspectRatioLockEnabled
{
    return self.cropView.aspectRatioLockEnabled;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    self.toolbarSnapshotView = [self.toolbar snapshotViewAfterScreenUpdates:NO];
//    self.toolbarSnapshotView.frame = self.toolbar.frame;
//
//    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
//        self.toolbarSnapshotView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    }
//    else {
//        self.toolbarSnapshotView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
//    }
//    [self.view addSubview:self.toolbarSnapshotView];
//
//    // Set up the toolbar frame to be just off t
//    CGRect frame = [self frameForToolbarWithVerticalLayout:UIInterfaceOrientationIsPortrait(toInterfaceOrientation)];
//    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
//        frame.origin.x = -frame.size.width;
//    }
//    else {
//        frame.origin.y = self.view.bounds.size.height;
//    }
//    self.toolbar.frame = frame;
//
//    [self.toolbar layoutIfNeeded];
//    self.toolbar.alpha = 0.0f;
    
    [self.cropView prepareforRotation];
    self.cropView.frame = [self frameForCropViewWithVerticalLayout:!UIInterfaceOrientationIsPortrait(toInterfaceOrientation)];
    self.cropView.simpleRenderMode = YES;
    self.cropView.internalLayoutDisabled = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //Remove all animations in the toolbar
//    self.toolbar.frame = [self frameForToolbarWithVerticalLayout:!UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
//    [self.toolbar.layer removeAllAnimations];
//    for (CALayer *sublayer in self.toolbar.layer.sublayers) {
//        [sublayer removeAllAnimations];
//    }
    
    // On iOS 11, since these layout calls are done multiple times, if we don't aggregate from the
    // current state, the animation breaks.
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:
     ^{
         self.cropView.frame = [self frameForCropViewWithVerticalLayout:!UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
//         self.toolbar.frame = [self frameForToolbarWithVerticalLayout:UIInterfaceOrientationIsPortrait(toInterfaceOrientation)];
         [self.cropView performRelayoutForRotation];
     } completion:nil];
    
//    self.toolbarSnapshotView.alpha = 0.0f;
//    self.toolbar.alpha = 1.0f;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//    [self.toolbarSnapshotView removeFromSuperview];
//    self.toolbarSnapshotView = nil;
    
    [self.cropView setSimpleRenderMode:NO animated:YES];
    self.cropView.internalLayoutDisabled = NO;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // If the size doesn't change (e.g, we did a 180 degree device rotation), don't bother doing a relayout
    if (CGSizeEqualToSize(size, self.view.bounds.size)) { return; }
    
    UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
    CGSize currentSize = self.view.bounds.size;
    if (currentSize.width < size.width) {
        orientation = UIInterfaceOrientationLandscapeLeft;
    }
    
    [self willRotateToInterfaceOrientation:orientation duration:coordinator.transitionDuration];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self willAnimateRotationToInterfaceOrientation:orientation duration:coordinator.transitionDuration];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self didRotateFromInterfaceOrientation:orientation];
    }];
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
    
    // If the aspect ratio lock is not enabled, allow a swap
    // If the aspect ratio lock is on, allow a aspect ratio swap
    // only if the allowDimensionSwap option is specified.
    BOOL aspectRatioCanSwapDimensions = !self.aspectRatioLockEnabled ||
    (self.aspectRatioLockEnabled && self.aspectRatioLockDimensionSwapEnabled);
    
    //If the image is a portrait shape, flip the aspect ratio to match
//    if (self.cropView.cropBoxAspectRatioIsPortrait &&
//        aspectRatioCanSwapDimensions)
//    {
//        CGFloat width = aspectRatio.width;
//        aspectRatio.width = aspectRatio.height;
//        aspectRatio.height = width;
//    }
    
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

#pragma mark - Reset -
- (void)resetCropViewLayout
{
    BOOL animated = (self.cropView.angle == 0);
    
    if (self.resetAspectRatioEnabled) {
        self.aspectRatioLockEnabled = NO;
    }
    
    [self.cropView resetLayoutToDefaultAnimated:animated];
}

#pragma mark - PhotoSubToolEditingDelegate
- (void)PhotoEditSubEditToolDismiss{
    [self.cropView removeFromSuperview];
    self.cropView = nil;
    
    [self.editSubToolView removeFromSuperview];
    self.editSubToolView = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

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

#pragma mark - TOCropViewDelegate
- (void)cropViewDidBecomeResettable:(nonnull TOCropView *)cropView{
    
}

- (void)cropViewDidBecomeNonResettable:(nonnull TOCropView *)cropView{
    
}

@end
