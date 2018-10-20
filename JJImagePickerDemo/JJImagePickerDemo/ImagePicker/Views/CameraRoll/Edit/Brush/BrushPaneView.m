//
//  BrushPaneView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "BrushPaneView.h"

@implementation BrushPaneView
@synthesize colorCollectionView = _colorCollectionView;
@synthesize colorArray = _colorArray;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    
    return self;
}

- (void)commoniInitlization{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

#pragma mark -lazyLoad
- (UICollectionView *)colorCollectionView{
    if(!_colorCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 50);
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //自动网格布局
        _colorCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10.0f, self.frame.size.width, self.frame.size.height - 30) collectionViewLayout:layout];
        //设置数据源代理
        _colorCollectionView.dataSource = self;
        _colorCollectionView.delegate = self;
        _colorCollectionView.scrollsToTop = NO;
        _colorCollectionView.showsVerticalScrollIndicator = NO;
        _colorCollectionView.showsHorizontalScrollIndicator = NO;
        _colorCollectionView.alwaysBounceHorizontal = NO;
        [_colorCollectionView setBackgroundColor:[UIColor whiteColor]];
        [_colorCollectionView registerClass:[EditingToolCell class] forCellWithReuseIdentifier:JJ_PHOTO_EDITING_SUBTOOL_CELL];
    }
}

@end
