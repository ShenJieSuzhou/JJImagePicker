//
//  SnapshotPreviewView.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/7/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnapshotPreviewView : UIView

@property (nonatomic, strong) UIImageView *snapshotView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *useBtn;

@property (nonatomic, strong) UIImage *snapShot;

- (void)setImage:(UIImage *)image;

@end
