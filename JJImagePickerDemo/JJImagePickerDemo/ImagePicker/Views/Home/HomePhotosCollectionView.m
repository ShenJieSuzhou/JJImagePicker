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



#define PHOTOS_CELL_IDENTIFIER @"PHOTOS_CELL_IDENTIFIER"
#define PHOTOS_HEADER_CELL_IDENTIFIER @"PHOTOS_HEADER_CELL_IDENTIFIER"
#define PHOTOS_FOOTER_CELL_IDENTIFIER @"PHOTOS_FOOTER_CELL_IDENTIFIER"

static CGFloat kMagin = 10.f;

@implementation HomePhotosCollectionReusableView

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
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
        [self setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1]];
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (self.frame.size.width - 3 * kMagin) / 2;
    layout.itemSize = CGSizeMake(itemWidth ,itemWidth / 0.6);
    layout.collectionView.pagingEnabled = YES;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);
    _photosCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [_photosCollection setBackgroundColor:[UIColor clearColor]];
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
    
    //下拉刷新
    __weak typeof(self) weakSelf = self;
    _photosCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

//        for (int i = 0; i<10; i++) {
//            [weakSelf.colors insertObject:MJRandomColor atIndex:0];
//        }
//
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.collectionView reloadData];
//
//            // 结束刷新
//            [weakSelf.collectionView.mj_header endRefreshing];
//        });
        [weakSelf.photosCollection.mj_header endRefreshing];
    }];
    [_photosCollection.mj_header beginRefreshing];
    
    // 上拉刷新
    _photosCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        for (int i = 0; i<5; i++) {
//            [weakSelf.colors addObject:MJRandomColor];
//        }
//
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.collectionView reloadData];
//
//            // 结束刷新
//            [weakSelf.collectionView.mj_footer endRefreshing];
//        });
        [weakSelf.photosCollection.mj_footer endRefreshing];
    }];
    // 默认先隐藏footer
//    _photosCollection.mj_footer.hidden = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)updatephotosArray:(NSMutableArray *)photos{
    self.photosArray = photos;
    [_photosCollection reloadData];
}


#pragma mark - UICollectionViewDelegate
/*
 * @brief 设置 HeadCollectionViewCell frame 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.frame.size.width, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCubeModel *work = [_photosArray objectAtIndex:indexPath.row];
    if(work){
        if([_delegate respondsToSelector:@selector(goToDetailViewCallback:)]){
            [_delegate goToDetailViewCallback:work];
        }
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
    HomePublsihCell *cell = (HomePublsihCell *)[collectionView dequeueReusableCellWithReuseIdentifier:PHOTOS_CELL_IDENTIFIER forIndexPath:indexPath];
    
    HomeCubeModel *myWorks = [_photosArray objectAtIndex:indexPath.row];
    [cell updateCell:myWorks];
    [cell setNeedsLayout];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
//        HomePhotosCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PHOTOS_HEADER_CELL_IDENTIFIER forIndexPath:indexPath];
//
//        return header;
//    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
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
//
//        return nil;
//    }
    
    return nil;
}



@end
