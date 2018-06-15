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
@synthesize photoPreviewView = _photoPreviewView;

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
    [self addSubview:self.photoPreviewView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.photoPreviewView setFrame:self.bounds];
}

//懒加载
- (UICollectionView *)photoPreviewView{
    if(!_photoPreviewView){
        JJPreviewViewCollectionLayout *layout = [[JJPreviewViewCollectionLayout alloc] init];
        _photoPreviewView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _photoPreviewView.delegate = self;
        _photoPreviewView.dataSource = self;
        [_photoPreviewView setBackgroundColor:[UIColor clearColor]];
        [_photoPreviewView registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_DEFAULT];
        [_photoPreviewView registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_VIDEO];
        [_photoPreviewView registerClass:[JJPreviewViewCollectionCell class] forCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_LIVEPHOTO];
    }
    
    return _photoPreviewView;
}

- (void)initImagePickerPreviewViewWithImagesAssetArray:(NSMutableArray<JJPhoto *> *)imageAssetArray
                               selectedImageAssetArray:(NSMutableArray<JJPhoto *> *)selectedImageAssetArray
                                     currentImageIndex:(NSInteger)currentImageIndex
                                       singleCheckMode:(BOOL)singleCheckMode{
    
    self.imagesAssetArray = imageAssetArray;
    self.selectedImageAssetArray = selectedImageAssetArray;
    
}

#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_imagesAssetArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JJPreviewViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JJ_PREVIEWCELL_IDENTIFIER_DEFAULT forIndexPath:indexPath];
    if(cell){
        cell = [[JJPreviewViewCollectionCell alloc] init];
    }
    
    return cell;
}


@end
