//
//  JJPreviewViewCollectionCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJPreviewViewCollectionCell : UICollectionViewCell
//预览图
@property (strong, nonatomic) UIImageView *previewImage;
//是否是视频
@property (assign) BOOL isVideoType;
//是否是livephoto
@property (assign) BOOL isLivePhotoType;
//视频mark
@property (strong, nonatomic) UIButton *videoBtn;
//cell 标识
@property (nonatomic, copy) NSString *identifier;


@end
