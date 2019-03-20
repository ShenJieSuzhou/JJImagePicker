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
- (void)updateCell:(NSString *)workUrl isMult:(BOOL)isMuti{
    if(!isMuti){
        [_multImg setHidden:YES];
    }
    
//    [self.likeBtn setTitle:likeNum forState:UIControlStateNormal];
    __weak typeof(self) weakself = self;
    [[SDImageCache sharedImageCache] diskImageExistsWithKey:workUrl completion:^(BOOL isInCache) {
        if(isInCache){
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:workUrl];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.workImageV setImage:image];
            });
        }else{
            [weakself.workImageV sd_setImageWithURL:[NSURL URLWithString:workUrl] placeholderImage:[UIImage imageNamed:@"workDefault"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
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
    
    [self.workImageV sd_setImageWithURL:[NSURL URLWithString:workUrl] placeholderImage:[UIImage imageNamed:@"workDefault"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakself.workImageV setImage:image];
    }];
}

@end
