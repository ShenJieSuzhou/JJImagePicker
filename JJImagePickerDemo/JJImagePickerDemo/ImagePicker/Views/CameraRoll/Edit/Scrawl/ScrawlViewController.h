//
//  ScrawlViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrawlAdjustView.h"

@interface ScrawlViewController : UIViewController

//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;
//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//底部工具
@property (nonatomic, strong) ScrawlAdjustView *scrawlAdjustView;
//撤销
@property (nonatomic, strong) UIButton *withdrawalBtn;

- (void)setEditImage:(UIImage *)image;

@end

