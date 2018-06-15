//
//  JJPreviewViewCollectionLayout.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPreviewViewCollectionLayout.h"

@implementation JJPreviewViewCollectionLayout

- (instancetype)init{
    if(self = [super init]){
        self.collectionView.pagingEnabled = YES;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    CGFloat itemW = self.collectionView.frame.size.width;
    CGFloat itemH = self.collectionView.frame.size.height;
    
    self.itemSize = CGSizeMake(itemW, itemH);
}

@end
