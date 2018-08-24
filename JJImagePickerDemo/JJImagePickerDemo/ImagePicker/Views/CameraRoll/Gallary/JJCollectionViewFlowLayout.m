//
//  JJCollectionViewFlowLayout.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/13.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJCollectionViewFlowLayout.h"

@implementation JJCollectionViewFlowLayout

- (instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    //设置item尺寸
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        self.itemSize =
//        CGFloat itemWH = self.collectionView.frame.size.width/4;
//        self.itemSize = CGSizeMake(itemWH, itemWH);
    }else{
        CGFloat itemWH = self.collectionView.frame.size.width/4;
        self.itemSize = CGSizeMake(itemWH, itemWH);
        self.collectionView.pagingEnabled = YES;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    
}

@end
