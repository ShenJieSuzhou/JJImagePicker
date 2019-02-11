//
//  ScrawlViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrawlAdjustView.h"
#import "EditingToolView.h"

@protocol ScrawlDelegate <NSObject>

-(void)ScrawlDidFinished:(UIImage *)scrawlImage;

@end

@interface ScrawlViewController : UIViewController<PhotoSubToolEditingDelegate>

//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;
//预览图底层layer
@property (nonatomic, strong) UIView *layerV;
//预览图UI
@property (nonatomic, strong) UIImageView *preViewImage;
//底部工具
@property (nonatomic, strong) EditingSubToolView *scrawlAdjustView;
//工具
@property (nonatomic, copy) NSArray *sToolArrays;
//撤销
@property (nonatomic, strong) UIButton *withdrawalBtn;

@property (nonatomic, weak) id<ScrawlDelegate> delegate;

- (void)setEditImage:(UIImage *)image;

- (void)setScrawlToolArrays:(NSArray *)tools;

@end

