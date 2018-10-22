//
//  WordsBrushViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WordsBrushViewController.h"

@interface WordsBrushViewController ()

@end

@implementation WordsBrushViewController
@synthesize brushPaneView = _brushPaneView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.5f]];
    
    [self.view addSubview:self.brushPaneView];
}


#pragma mark -lazyload
- (BrushPaneView *)brushPaneView{
    if(!_brushPaneView){
        _brushPaneView = [[BrushPaneView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _brushPaneView;
}

@end
