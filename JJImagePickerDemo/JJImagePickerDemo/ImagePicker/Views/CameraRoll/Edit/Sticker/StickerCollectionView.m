//
//  StickerCollectionView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/25.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "StickerCollectionView.h"
#import "StickerCell.h"

#define STICKER_CELL_IDENTIFIER @"STICKER_CELL_IDENTIFIER"

@implementation StickerCollectionView
@synthesize stickerArray = _stickerArray;
@synthesize stickerCollection = _stickerCollection;

- (instancetype)initWithFrame:(CGRect)frame{
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
    [self addSubview:self.stickerCollection];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

//懒加载
- (UICollectionView *)stickerCollection{
    if(!_stickerCollection){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.frame.size.width / 5, self.frame.size.width / 5);
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _stickerCollection = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        //设置数据源代理
        _stickerCollection.dataSource = self;
        _stickerCollection.delegate = self;
        _stickerCollection.scrollsToTop = NO;
        _stickerCollection.showsVerticalScrollIndicator = NO;
        _stickerCollection.showsHorizontalScrollIndicator = NO;
        _stickerCollection.alwaysBounceHorizontal = NO;
        [_stickerCollection setBackgroundColor:[UIColor whiteColor]];
        [_stickerCollection registerClass:[StickerCell class] forCellWithReuseIdentifier:STICKER_CELL_IDENTIFIER];
    }
    
    return _stickerCollection;
}

- (NSMutableArray *)stickerArray{
    if(!_stickerArray){
        _stickerArray = [[NSMutableArray alloc] init];
    }
    return _stickerArray;
}

- (void)setStickers:(NSMutableArray *)array{
    self.stickerArray = array;
}

- (void)refreshTheSticker{
    [self.stickerCollection reloadData];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.stickerArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = STICKER_CELL_IDENTIFIER;
    StickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSString *stickerName = [self.stickerArray objectAtIndex:indexPath.row];
    [cell updateStickerImage:stickerName];
    
    return cell;
}

@end
