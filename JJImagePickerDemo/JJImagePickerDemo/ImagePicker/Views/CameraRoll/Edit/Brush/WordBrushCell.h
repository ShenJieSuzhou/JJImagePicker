//
//  WordBrushCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordBrushCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *colorImg;

- (void)updateCellContent:(UIColor *)color;


@end

