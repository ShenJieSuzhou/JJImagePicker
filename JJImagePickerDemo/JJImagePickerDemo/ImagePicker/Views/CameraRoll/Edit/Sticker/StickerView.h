//
//  StickerView.h
//  JJImagePickerDemo
//  贴纸功能
//  Created by shenjie on 2018/9/21.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickerView : UIView<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *stickerCollection;


@end
