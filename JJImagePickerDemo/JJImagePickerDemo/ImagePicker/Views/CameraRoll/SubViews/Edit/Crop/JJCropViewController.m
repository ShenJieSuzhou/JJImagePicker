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

@end

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
        self.hidesNavigationBar = true;
        
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
    
    [self.editSubToolView setSubToolArray:_optionsAray];
    [self.view addSubview:self.editSubToolView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

#pragma mark - PhotoSubToolEditingDelegate
- (void)PhotoEditSubEditToolDismiss{
    
    
}

- (void)PhotoEditSubEditToolConfirm{
    
    
}

@end
