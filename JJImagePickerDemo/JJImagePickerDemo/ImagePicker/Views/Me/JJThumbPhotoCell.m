//
//  JJThumbPhotoCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/2/20.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "JJThumbPhotoCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
@implementation JJThumbPhotoCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    _photoImage = [[UIImageView alloc] init];
    _photoImage.userInteractionEnabled = YES;
    _photoImage.contentMode = UIViewContentModeScaleAspectFill;
    _photoImage.clipsToBounds = YES;
    [_photoImage setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_photoImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 5.0f, self.frame.size.height - 5.0f));
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5));
    }];
}

- (void)updateCell:(NSString *)workUrl{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    __weak typeof(self) weakself = self;
    NSURL *nsUrl = [NSURL URLWithString:workUrl];
    
    [manager diskImageExistsForURL:nsUrl completion:^(BOOL isInCache) {
        if(isInCache){
            NSString *key = [manager cacheKeyForURL:nsUrl];
            UIImage *image = [[manager imageCache] imageFromDiskCacheForKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.photoImage setImage:image];
            });
        }else{
            [manager loadImageWithURL:[NSURL URLWithString:workUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                NSString *key = [manager cacheKeyForURL:nsUrl];
                [manager saveImageToCache:image forURL:[NSURL URLWithString:key]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.photoImage setImage:image];
                });
            }];
        }
    }];
}

@end
