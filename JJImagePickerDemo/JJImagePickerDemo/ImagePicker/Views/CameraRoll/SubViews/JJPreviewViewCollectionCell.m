//
//  JJPreviewViewCollectionCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPreviewViewCollectionCell.h"

@implementation JJPreviewViewCollectionCell
@synthesize videoBtn = _videoBtn;
@synthesize previewImage = _previewImage;
@synthesize isVideoType = _isVideoType;
@synthesize isLivePhotoType = _isLivePhotoType;
@synthesize identifier = _identifier;

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
    [self setBackgroundColor:[UIColor clearColor]];
    _previewImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _previewImage.contentMode = UIViewContentModeScaleAspectFit;
    _videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_videoBtn setBackgroundColor:[UIColor clearColor]];
    [_videoBtn setBackgroundImage:[UIImage imageNamed:@"QMUI_previewImage_checkbox_checked"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.previewImage];
    [self.contentView addSubview:self.videoBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_previewImage setFrame:self.bounds];
    [_videoBtn setFrame:CGRectMake(50, 50, 50, 50)];
    
    if(_isVideoType){
        [_videoBtn setHidden:NO];
    }else{
        [_videoBtn setHidden:YES];
    }
}

@end
