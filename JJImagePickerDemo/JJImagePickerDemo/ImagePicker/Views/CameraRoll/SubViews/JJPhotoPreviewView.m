//
//  JJPhotoPreviewView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPhotoPreviewView.h"
#import "JJPreviewViewCollectionCell.h"
#import "JJPreviewViewCollectionLayout.h"

#define JJ_PREVIEWCELL_IDENTIFIER_DEFAULT @"jj_previewcell_identifer"
#define JJ_PREVIEWCELL_IDENTIFIER_LIVEPHOTO @"jj_previewcell_identifer_live"
#define JJ_PREVIEWCELL_IDENTIFIER_VIDEO @"jj_previewcell_identifer_video"

@implementation JJPhotoPreviewView
@synthesize imagesAssetArray = _imagesAssetArray;
@synthesize selectedImageAssetArray = _selectedImageAssetArray;
@synthesize photoPreviewImage = _photoPreviewImage;

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
    self.imagesAssetArray = [[NSMutableArray alloc] init];
    self.selectedImageAssetArray = [[NSMutableArray alloc] init];
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
    [self.photoPreviewImage reloadData];
}

//懒加载
- (UICollectionView *)photoPreviewImage{
    if(!_photoPreviewImage){
        JJPreviewViewCollectionLayout *layout = [[JJPreviewViewCollectionLayout alloc] init];
        _photoPreviewImage = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _photoPreviewImage.delegate = self;
        _photoPreviewImage.dataSource = self;
        [_photoPreviewImage setBackgroundColor:[UIColor clearColor]];
        [_photoPreviewImage registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_DEFAULT];
        [_photoPreviewImage registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_VIDEO];
        [_photoPreviewImage registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_LIVEPHOTO];
    }
    
    return _photoPreviewImage;
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


@end
