//
//  JJTagCategoryView.h
//  testTag
//
//  Created by shenjie on 2018/9/30.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagEditView.h"
#import "JJResizeFlowLayout.h"
#import "JJCollectionReusableView.h"
#import "JJTagsCollectionViewCell.h"
#import "UIScrollView+UITouch.h"
#import "CustomNaviBarView.h"

@class JJTagCategoryView;
@protocol JJTagCategoryDelegate <NSObject>
- (void)JJTagCategory:(JJTagCategoryView *)jjTagCategoryView historyTag:(SubTagModel *)tag;
- (void)JJTagCategory:(JJTagCategoryView *)jjTagCategoryView didChooseTag:(SubTagModel *)tag;
- (void)JJTagCategoryDidCancel:(JJTagCategoryView *)jjTagCategoryView;
@end

@interface JJTagCategoryView : UIView<TagEditViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,JJResizeFlowLayoutDelegate>

@property (nonatomic, strong) CustomNaviBarView *navBarView;
@property (nonatomic, strong) TagEditView *tagEditView;
@property (nonatomic, strong) UICollectionView *tagsCollectionView;
@property (nonatomic, strong) NSMutableArray *hotTags;
@property (nonatomic, strong) NSMutableArray *historyTags;
@property (nonatomic, weak) id<JJTagCategoryDelegate> delegate;

- (void)setHotTags:(NSMutableArray *)hotTags withHistory:(NSMutableArray *)history;


@end
