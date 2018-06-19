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
        self.velocityForPageDown = 0.4;
        self.allowMultipleItemScroll = YES;
        
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

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGFloat itemSpacing = self.itemSize.width + self.minimumLineSpacing;
    
    if(self.allowMultipleItemScroll || fabs(velocity.x) <= fabs(self.multipleItemScrollVelocityLimit)){
        BOOL scrollingToRight = proposedContentOffset.x < self.collectionView.contentOffset.x;
        proposedContentOffset = CGPointMake(self.collectionView.contentOffset.x + (itemSpacing / 2) * (scrollingToRight ? -1:1), self.collectionView.contentOffset.y);
    }else{
        proposedContentOffset = self.collectionView.contentOffset;
    }
    
    proposedContentOffset.x = round(proposedContentOffset.x / itemSpacing) * itemSpacing;
    
    return proposedContentOffset;
}

@end
