//
//  HomePhotosCollectionView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomePhotosCollectionView.h"
#import <Masonry/Masonry.h>
#import "HomePublsihCell.h"
#import "Works.h"


#define PHOTOS_CELL_IDENTIFIER @"PHOTOS_CELL_IDENTIFIER"
#define PHOTOS_HEADER_CELL_IDENTIFIER @"PHOTOS_HEADER_CELL_IDENTIFIER"
#define PHOTOS_FOOTER_CELL_IDENTIFIER @"PHOTOS_FOOTER_CELL_IDENTIFIER"


@implementation HomePhotosCollectionReusableView

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_titleLabel setText:@"发现"];
    [_titleLabel setTextColor:[UIColor blackColor]];
    [_titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [self addSubview:_titleLabel];

}

- (void)layoutSubviews{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200.0f, 30.0f));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
    }];
}

@end


@implementation HomePhotosCollectionView
@synthesize photosCollection = _photosCollection;
@synthesize photosArray = _photosArray;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = self.frame.size.width/2;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth/0.6);
    layout.collectionView.pagingEnabled = YES;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _photosCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [_photosCollection setBackgroundColor:[UIColor whiteColor]];
    //设置数据源代理
    _photosCollection.dataSource = self;
    _photosCollection.delegate = self;
    _photosCollection.scrollsToTop = NO;
    _photosCollection.showsVerticalScrollIndicator = NO;
    _photosCollection.showsHorizontalScrollIndicator = NO;
    _photosCollection.alwaysBounceHorizontal = NO;
    [_photosCollection registerClass:[HomePublsihCell class] forCellWithReuseIdentifier:PHOTOS_CELL_IDENTIFIER];
    [_photosCollection registerClass:[HomePhotosCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PHOTOS_HEADER_CELL_IDENTIFIER];
    [_photosCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:PHOTOS_FOOTER_CELL_IDENTIFIER];
    [self addSubview:_photosCollection];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)updateWorksArray:(NSMutableArray *)works{
   
    [_photosCollection reloadData];
}


#pragma mark - UICollectionViewDelegate
/*
 * @brief 设置 HeadCollectionViewCell frame 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.frame.size.width, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Works *work = [_photosArray objectAtIndex:indexPath.row];
    if(work){
//        if([_delegate respondsToSelector:@selector(goToWorksDetailViewCallback:)]){
//            [_delegate goToWorksDetailViewCallback:work];
//        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(!_photosArray){
        return 0;
    }
    return [_photosArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomePublsihCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTOS_CELL_IDENTIFIER forIndexPath:indexPath];
    
    Works *myWorks = [_photosArray objectAtIndex:indexPath.row];
//    [cell updateCell:[myWorks.path objectAtIndex:0] isMult:isMult];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        HomePhotosCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PHOTOS_HEADER_CELL_IDENTIFIER forIndexPath:indexPath];
        
        return header;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:PHOTOS_FOOTER_CELL_IDENTIFIER forIndexPath:indexPath];
//        if(footerView == nil)
//        {
//            footerView = [[UICollectionReusableView alloc] init];
//        }
//        footerView.backgroundColor = [UIColor whiteColor];
//
//        if([_photosArray count] != 0 && self.worksArray){
//            UILabel *endText = [[UILabel alloc] init];
//            [endText setText:@"我是有底线的 -_-||"];
//            [endText setFont:[UIFont systemFontOfSize:16.0f]];
//            [endText setTextColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1]];
//            [endText setTextAlignment:NSTextAlignmentCenter];
//            [footerView addSubview:endText];
//
//            [endText mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_equalTo(CGSizeMake(300.0f, 100.0f));
//                make.center.mas_equalTo(footerView);
//            }];
//        }
        
        return nil;
    }
    
    return nil;
}



@end
