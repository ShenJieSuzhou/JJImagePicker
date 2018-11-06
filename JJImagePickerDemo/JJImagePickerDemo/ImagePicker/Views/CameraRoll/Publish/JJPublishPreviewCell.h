//
//  JJPublishPreviewCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
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

@property (assign) BOOL isAddCell;

- (void)updatePublishImgCell:(BOOL)flag img:(UIImage *)image;

@end
