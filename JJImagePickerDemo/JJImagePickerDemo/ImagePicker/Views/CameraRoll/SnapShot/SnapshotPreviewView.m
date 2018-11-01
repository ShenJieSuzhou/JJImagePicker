//
//  SnapshotPreviewView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/7/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "SnapshotPreviewView.h"

@implementation SnapshotPreviewView
@synthesize snapshotView = _snapshotView;
@synthesize cancelBtn = _cancelBtn;
@synthesize editBtn = _editBtn;
@synthesize useBtn = _useBtn;
@synthesize snapShot = _snapShot;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    _snapshotView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _snapshotView.contentMode = UIViewContentModeScaleAspectFill;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setBackgroundColor:[UIColor clearColor]];
    [_cancelBtn setImage:[UIImage imageNamed:@"retakeButton"] forState:UIControlStateNormal];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setBackgroundColor:[UIColor clearColor]];
    [_editBtn setImage:[UIImage imageNamed:@"beauty"] forState:UIControlStateNormal];
    
    _useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_useBtn setBackgroundColor:[UIColor clearColor]];
    [_useBtn setImage:[UIImage imageNamed:@"confirmButton"] forState:UIControlStateNormal];
    
    [self addSubview:_snapshotView];
    [self addSubview:_cancelBtn];
    [self addSubview:_editBtn];
    [self addSubview:_useBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.snapshotView setFrame:self.frame];

    [self.cancelBtn setFrame:CGRectMake(80, self.frame.size.height - 100, 60, 60)];
    [self.editBtn setFrame:CGRectMake((self.frame.size.width - 60)/2, self.frame.size.height - 100, 60, 60)];
    [self.useBtn setFrame:CGRectMake(self.frame.size.width - 80 - 60, self.frame.size.height - 100, 60, 60)];
}

- (void)setImage:(UIImage *)image{
    _snapShot = image;
    [_snapshotView setImage:_snapShot];
}

@end
