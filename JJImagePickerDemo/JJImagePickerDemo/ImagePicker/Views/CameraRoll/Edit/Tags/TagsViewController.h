//
//  TagsViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagCategoryView.h"

@interface TagsViewController : UIViewController

@property (strong, nonatomic) UIView *classifyView;
@property (strong, nonatomic) TagCategoryView *tagsCategoryView;
@property (strong, nonatomic) UIButton *textTagBtn;
@property (strong, nonatomic) UIButton *brandsTagBtn;
@property (strong, nonatomic) UIButton *locationTagBtn;
@property (assign) TAGCLASSIFICTION tagClassification;

@end
