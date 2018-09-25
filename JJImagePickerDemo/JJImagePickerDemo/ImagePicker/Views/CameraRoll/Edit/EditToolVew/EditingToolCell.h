//
//  EditingToolCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    COMMON_CELL,
    FILTER_CELL,
    STICKER_CELL
} JJ_EDITCELL_TYPE;

@interface EditingToolCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) UIImageView *iconV;

- (void)updateCellContent:(UIImage *)image title:(NSString *)title type:(JJ_EDITCELL_TYPE)type;

@end
