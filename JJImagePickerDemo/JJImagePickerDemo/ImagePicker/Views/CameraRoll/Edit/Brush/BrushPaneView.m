//
//  BrushPaneView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "BrushPaneView.h"
#define COLOR_BTN_TAG 2018

@implementation BrushPaneView
@synthesize colorCollectionView = _colorCollectionView;
@synthesize colorArray = _colorArray;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    
    return self;
}

- (void)commoniInitlization{
    for (int i = 0; i < [_colorArray count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTag:(i + COLOR_BTN_TAG)];
        [btn addTarget:self action:@selector(clickColorBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < [_colorArray count]; i++) {
        UIButton *btn = [self viewWithTag:(i+COLOR_BTN_TAG)];
        CGFloat btnWidth = 40.0f;
        CGFloat btnHeight = 40.0f;
        [btn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, btnHeight)];
        [btn.layer setCornerRadius:btnWidth/2];
    }
}

- (void)clickColorBtn:(UIButton *)sender{
    if(!sender.selected){
        
    }else{
        
    }
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
