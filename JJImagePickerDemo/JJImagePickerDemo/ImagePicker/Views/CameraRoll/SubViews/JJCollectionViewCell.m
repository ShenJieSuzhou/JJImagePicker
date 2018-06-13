//
//  JJCollectionViewCell.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/11.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJCollectionViewCell.h"

@implementation SelectButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    SelectButton *btn = [super buttonWithType:buttonType];
//    [btn setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>]
    return btn;
}

@end



@implementation JJCollectionViewCell
@synthesize contentImageView = _contentImageView;
@synthesize assetIdentifier = _assetIdentifier;
@synthesize livePhotoView = _livePhotoView;
@synthesize videoView = _videoView;
@synthesize timeMark = _timeMark;


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
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentImageView.frame = self.contentView.bounds;
}

@end
