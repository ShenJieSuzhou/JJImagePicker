//
//  JJPublishViewFlowLayout.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/6.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPublishViewFlowLayout.h"

@implementation JJPublishViewFlowLayout

- (instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    //设置item尺寸
    CGFloat itemWH = self.collectionView.frame.size.width/3;
    self.itemSize = CGSizeMake(itemWH, itemWH);
    self.collectionView.pagingEnabled = YES;
//    self.minimumLineSpacing = 5.0f;
    self.minimumInteritemSpacing = 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0f;
}

@end