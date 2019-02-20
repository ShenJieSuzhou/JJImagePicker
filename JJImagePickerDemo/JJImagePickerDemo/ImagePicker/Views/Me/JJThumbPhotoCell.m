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
    //    [self.likeBtn setTitle:likeNum forState:UIControlStateNormal];
    __weak typeof(self) weakself = self;
    [[SDImageCache sharedImageCache] diskImageExistsWithKey:workUrl completion:^(BOOL isInCache) {
        if(isInCache){
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:workUrl];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.photoImage setImage:image];
            });
        }else{
            [weakself.photoImage sd_setImageWithURL:[NSURL URLWithString:workUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(!error){
                    [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL.absoluteString completion:^{
                        NSLog(@"图片缓存成功");
                    }];
                }else{
                    NSLog(@"图片异步加载出错 %@", error);
                }
            }];
        }
    }];
    [_photoImage sd_setImageWithURL:[NSURL URLWithString:workUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakself.photoImage setImage:image];
    }];
}

@end
