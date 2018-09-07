//
//  EditingToolCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditingToolCell : UICollectionViewCell
//icon asset
@property (strong, nonatomic) UIImage *editImage;

@property (strong, nonatomic) UIImage *editImageSel;
//title
@property (strong, nonatomic) NSString *editTitle;
//button
//@property (strong, nonatomic) UIButton *editBtn;
@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) UIImageView *iconV;

- (void)updateCellContent:(UIImage *)image title:(NSString *)title;

@end
