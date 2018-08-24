//
//  JJPhotoPreviewView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPhotoPreviewView.h"


@implementation JJPhotoPreviewView
@synthesize photoPreviewImage = _photoPreviewImage;
@synthesize currentIndex = _currentIndex;
@synthesize previousScrollIndex = _previousScrollIndex;
@synthesize mDelegate =_mDelegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    [self addSubview:self.photoPreviewImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.photoPreviewImage setFrame:self.bounds];
}

//- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
//                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
//                                     currentImageIndex:(NSInteger)currentImageIndex
//                                       singleCheckMode:(BOOL)singleCheckMode{
//    
//
//    self.imagesAssetArray = imageAssetArray;
//    self.selectedImageAssetArray = selectedImageAssetArray;
//    self.currentIndex = currentImageIndex;
//    
//    [self.photoPreviewImage reloadData];
//    
//    [self.photoPreviewImage scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//}

//懒加载
- (UICollectionView *)photoPreviewImage{
    if(!_photoPreviewImage){
        _photoPreviewImage = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _photoPreviewImage.delegate = self;
        _photoPreviewImage.dataSource = self;
        [_photoPreviewImage setBackgroundColor:[UIColor clearColor]];
        [_photoPreviewImage registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_DEFAULT];
        [_photoPreviewImage registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_VIDEO];
        [_photoPreviewImage registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_LIVEPHOTO];
    }
    
    return _photoPreviewImage;
}

- (JJPreviewViewCollectionLayout *)layout{
    if(!_layout){
        _layout = [[JJPreviewViewCollectionLayout alloc] init];
    }
    
    return _layout;
}

#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([self.mDelegate respondsToSelector:@selector(numberOfImagesInImagePreviewView:)]){
        return [self.mDelegate numberOfImagesInImagePreviewView:self];
    }

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PREVIEWCELL_IDENTIFIER_DEFAULT;
    if([self.mDelegate respondsToSelector:@selector(imagePreviewView:assetTypeAtIndex:)]){
        JJAssetSubType type = [self.mDelegate imagePreviewView:self assetTypeAtIndex:indexPath.row];
        if(type == JJAssetSubTypeImage){
            identifier = JJ_PREVIEWCELL_IDENTIFIER_DEFAULT;
        }else if(type == JJAssetSubTypeVideo){
            identifier = JJ_PREVIEWCELL_IDENTIFIER_VIDEO;
        }else if(type == JJAssetSubTypeLivePhoto){
            identifier = JJ_PREVIEWCELL_IDENTIFIER_LIVEPHOTO;
        }
    }
    
    JJPreviewViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    cell.previewImage = nil;
    cell.videoPlayerItem = nil;
    cell.mDelegate = self;
    
    if([self.mDelegate respondsToSelector:@selector(imagePreviewView:renderCell:atIndex:)]){
        [self.mDelegate imagePreviewView:self renderCell:cell atIndex:indexPath.row];
    }
    
    return cell;
}

#pragma -mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return collectionView.bounds.size;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView != self.photoPreviewImage){
        return;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView != self.photoPreviewImage){
        return;
    }
    
    CGFloat pageWidth = [self collectionView:self.photoPreviewImage layout:self.layout sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].width;
    CGFloat pageHorizontalMargin = self.layout.minimumLineSpacing;
    CGFloat contentOffsetX = self.photoPreviewImage.contentOffset.x;
    CGFloat index = contentOffsetX / (pageWidth + pageHorizontalMargin);
    
    BOOL isFirstScroll = self.previousScrollIndex == 0;
    BOOL turnPageToRight = index >= self.previousScrollIndex;
    BOOL turnPageToleft = index <= self.previousScrollIndex;
    
    if(!isFirstScroll && (turnPageToRight || turnPageToleft)){
        index = round(index);
        if(index >= 0 && index < [self.photoPreviewImage numberOfItemsInSection:0]){
            self.currentIndex = index;
            //回调
            [self.mDelegate imagePreviewView:self didScrollToIndex:self.currentIndex];
        }
    }
    
    self.previousScrollIndex = index;
}

#pragma mark -videoPlayerButtonDelegate

- (void)videoPlayerButtonClick:(UIButton *)button didModifyUI:(BOOL)didhide{
    
    [self.mDelegate imagePreviewView:self didHideNaviBarAndToolBar:didhide];
}

@end
