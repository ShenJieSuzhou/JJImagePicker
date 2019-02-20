//
//  JJThumbPhotoCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/2/20.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJThumbPhotoCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *photoImage;

- (void)updateCell:(NSString *)workUrl;

@end

