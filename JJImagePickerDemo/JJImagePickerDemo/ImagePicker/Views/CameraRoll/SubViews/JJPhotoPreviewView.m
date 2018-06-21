//
//  JJPhotoPreviewView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPhotoPreviewView.h"
#import "JJPreviewViewCollectionCell.h"
#import "GlobalDefine.h"

@implementation JJPhotoPreviewView
@synthesize imagesAssetArray = _imagesAssetArray;
@synthesize selectedImageAssetArray = _selectedImageAssetArray;
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
//    self.imagesAssetArray = [[NSMutableArray alloc] init];
//    self.selectedImageAssetArray = [[NSMutableArray alloc] init];
    [self addSubview:self.photoPreviewImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.photoPreviewImage setFrame:self.bounds];
}

- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode{
    

    self.imagesAssetArray = imageAssetArray;
    self.selectedImageAssetArray = selectedImageAssetArray;
    self.currentIndex = currentImageIndex;
    
    [self.photoPreviewImage reloadData];
    
    [self.photoPreviewImage scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

//- (void)initImagePickerPreviewWithSelectedImages:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
//                               currentImageIndex:(NSInteger)currentImageIndex{
//
//    self.imagesAssetArray = selectedImageAssetArray;
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
    return [_imagesAssetArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJPhoto *imageAsset = [self.imagesAssetArray objectAtIndex:indexPath.row];

    //初始化cell
    NSString *identifier = nil;
    if(imageAsset.assetType == JJAssetTypeImage){
        identifier = JJ_PREVIEWCELL_IDENTIFIER_DEFAULT;
    }else if(imageAsset.assetType == JJAssetTypeVideo){
        identifier = JJ_PREVIEWCELL_IDENTIFIER_VIDEO;
    }
    
    JJPreviewViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.identifier = imageAsset.identifier;
    
    [imageAsset requestPreviewImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
    if([cell.identifier isEqualToString:imageAsset.identifier]){
        [cell.previewImage setImage:result];
    }else{
        [cell.previewImage setImage:nil];
    }
        
    } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        
    }];
    
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
            [_mDelegate imagePreviewView:self didScrollToIndex:self.currentIndex];
        }
    }
    
    self.previousScrollIndex = index;
    
}

@end
