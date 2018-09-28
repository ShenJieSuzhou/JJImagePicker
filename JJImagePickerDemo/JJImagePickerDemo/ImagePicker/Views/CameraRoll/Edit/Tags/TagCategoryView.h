//
//  TagCategoryView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    TAG_TEXT,
    TAG_BRANDS,
    TAG_LOCATION
} TAGCLASSIFICTION;

@interface TagCategoryView : UIView

@property (strong, nonatomic) UICollectionView *tagCollectionView;

- (void)setTagType:(TAGCLASSIFICTION)type;


@end
