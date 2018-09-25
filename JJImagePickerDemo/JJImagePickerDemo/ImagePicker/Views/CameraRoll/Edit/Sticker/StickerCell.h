//
//  StickerCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/21.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickerCell : UICollectionViewCell

@property (strong, nonatomic) NSString *stickerName;

@property (strong, nonatomic) UIImageView *imgView;

- (void)updateStickerImage:(NSString *)name;

@end
