//
//  JJPublishPreviewCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJPhoto.h"

@class JJPublishPreviewCell;
@protocol JJPublishCellDelegate <NSObject>
- (void)JJPublishCallBack:(JJPublishPreviewCell *)cell;
@end


@interface JJPublishPreviewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *editLabel;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<JJPublishCellDelegate> delegate;

@property (nonatomic, strong) JJPhoto *obj;

@property (assign) BOOL isAddCell;

@property (assign) BOOL isAdjust;

@property (nonatomic, strong) UIImage *imageData;

- (void)updatePublishImgCell:(BOOL)flag asset:(NSObject *)imageObj;

- (void)isDefaultImage:(BOOL)flag;

@end
