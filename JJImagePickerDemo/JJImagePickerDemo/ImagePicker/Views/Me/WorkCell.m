//
//  WorkCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WorkCell.h"
#import <Masonry/Masonry.h>

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
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.workImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w - 10.0f, h - 10.0f)];
    self.workImageV.userInteractionEnabled = YES;
    self.workImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.workImageV setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.workImageV];
    
//    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.likeBtn setBackgroundColor:[UIColor clearColor]];
//    [self addSubview:self.likeBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];

}


/**
 下载缓存自己发布的作品

 @param workUrl <#workUrl description#>
 @param likeNum <#likeNum description#>
 */
- (void)updateCell:(NSString *)workUrl like:(NSString *)likeNum{
    [self.likeBtn setTitle:likeNum forState:UIControlStateNormal];
    __weak typeof(self) weakself = self;
    [[SDImageCache sharedImageCache] diskImageExistsWithKey:workUrl completion:^(BOOL isInCache) {
        if(isInCache){
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:workUrl];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.workImageV setImage:image];
            });
        }else{
            [weakself.workImageV sd_setImageWithURL:[NSURL URLWithString:workUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
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
    [self.workImageV sd_setImageWithURL:[NSURL URLWithString:workUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakself.workImageV setImage:image];
    }];
}

@end
