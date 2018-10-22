//
//  WordsBrushViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrushPaneView.h"
#import "TextEditView.h"
#import "CustomNaviBarView.h"
@interface WordsBrushViewController : UIViewController

@property (strong, nonatomic) BrushPaneView *brushPaneView;
@property (strong, nonatomic) TextEditView *textEditView;
@property (strong, nonatomic) CustomNaviBarView *cusNavbar;

@end

