//
//  WorkCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WorkCell.h"
#import <Masonry/Masonry.h>
#import "JJCacheUtil.h"

@implementation WorkCell
@synthesize workImageV = _workImageV;
@synthesize likeBtn = _likeBtn;

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.workImageV = [[UIImageView alloc] init];
    self.workImageV.userInteractionEnabled = YES;
    self.workImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.workImageV.clipsToBounds = YES;
    [self.workImageV setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.workImageV];

    
    _multImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mutileImages"]];
    _multImg.contentMode = UIViewContentModeScaleAspectFill;
    _multImg.clipsToBounds = YES;
    [_multImg setBackgroundColor:[UIColor clearColor]];
    [_workImageV addSubview:_multImg];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.workImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 5.0f, self.frame.size.height - 5.0f));
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5));
    }];
    
    [_multImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.bottom.equalTo(self.workImageV).offset(-5.0f);
        make.right.equalTo(self.workImageV).offset(-5.0f);
    }];
}


/**
 下载缓存自己发布的作品

 @param workUrl 地址
 */
- (void)updateCell:(nullable NSString *)workUrl isMult:(BOOL)isMuti{
    if(!isMuti){
        [_multImg setHidden:YES];
    }
    __weak typeof(self) weakself = self;
    [JJCacheUtil diskImageExistsWithUrl:workUrl completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.workImageV setImage:image];
        });
    }];
    
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    __weak typeof(self) weakself = self;
//    NSURL *nsUrl = [NSURL URLWithString:workUrl];
//
//    [manager diskImageExistsForURL:nsUrl completion:^(BOOL isInCache) {
//        if(isInCache){
//            NSString *key = [manager cacheKeyForURL:nsUrl];
//            UIImage *image = [[manager imageCache] imageFromDiskCacheForKey:key];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakself.workImageV setImage:image];
//            });
//        }else{
//            [manager loadImageWithURL:[NSURL URLWithString:workUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//                NSString *key = [manager cacheKeyForURL:nsUrl];
//                [manager saveImageToCache:image forURL:[NSURL URLWithString:key]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakself.workImageV setImage:image];
//                });
//            }];
//        }
//    }];
}

@end
