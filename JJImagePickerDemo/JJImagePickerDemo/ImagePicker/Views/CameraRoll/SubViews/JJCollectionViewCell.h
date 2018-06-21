//
//  JJCollectionViewCell.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/11.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JJCollectionViewCellDelegate<NSObject>


@end


@interface SelectButton: UIButton


@end

@interface JJCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SelectButton *checkBox;

@property (nonatomic, strong) UIImage *unselectedImage;

@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, copy) NSString *assetIdentifier;

@property (nonatomic, strong) UIImageView *livePhotoView;

@property (nonatomic, strong) UIImageView *videoView;

@property (nonatomic, strong) UILabel *videoDuration;

@property (nonatomic, assign) BOOL checked;


@end
