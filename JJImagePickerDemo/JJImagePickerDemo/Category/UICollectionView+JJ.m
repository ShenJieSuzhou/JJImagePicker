//
//  UICollectionView+JJ.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/14.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "UICollectionView+JJ.h"

@implementation UICollectionView(JJ)

- (UICollectionViewCell *)parentCellView:(UIView *)view{
    if(!view.superview){
        return nil;
    }
    
    if([view.superview isKindOfClass:[UICollectionViewCell class]]){
        return (UICollectionViewCell *)view.superview;
    }
    
    return [self parentCellView:view.superview];
}

- (NSIndexPath *)jj_indexPathForItemAtView:(id)sender{
    if(sender && [sender isKindOfClass:[UIView class]]){
        UIView *view = (UIView *)sender;
        UICollectionViewCell *parentCell = [self parentCellView:view];
        if(parentCell){
            return [self indexPathForCell:parentCell];
        }
    }
    return nil;
}

@end
