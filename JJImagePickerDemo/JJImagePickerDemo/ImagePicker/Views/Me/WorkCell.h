//
//  WorkCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>

@interface WorkCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *workImageV;

@property (strong, nonatomic) UIButton *likeBtn;

@property (strong, nonatomic) UIImageView *multImg;

- (void)updateCell:(NSString *)workUrl isMult:(BOOL)isMuti;

@end

