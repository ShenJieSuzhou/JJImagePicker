//
//  JJCollectionViewCell.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/11.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectButton: UIButton


@end

@interface JJCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, copy) NSString *assetIdentifier;

@property (nonatomic, strong) UIImageView *livePhotoView;

@property (nonatomic, strong) UIImageView *videoView;

@property (nonatomic, copy) NSString *timeMark;

@end
