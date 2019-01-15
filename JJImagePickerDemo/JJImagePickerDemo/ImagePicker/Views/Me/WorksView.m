//
//  WorksView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WorkCell.h"
#import "WorksView.h"
#import "GlobalDefine.h"
#import <Masonry/Masonry.h>

#define WORKS_CELL_IDENTIFIER @"WORKS_CELL_IDENTIFIER"
#define WORKS_HEADER_CELL_IDENTIFIER @"WORKS_HEADER_CELL_IDENTIFIER"
#define WORKS_FOOTER_CELL_IDENTIFIER @"WORKS_FOOTER_CELL_IDENTIFIER"
#define PUBLISH_BTN_HEIGHT 60.0f
#define PUBLISH_BTN_WIDTH 100.0f


@implementation WorksCollectionReusableView
@synthesize titleLabel = _titleLabel;

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
    [_titleLabel setText:@"作品"];
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


@implementation WorksView
@synthesize publishBtn = _publishBtn;
@synthesize worksCollection = _worksCollection;
@synthesize tips = _tips;
@synthesize worksArray = _worksArray;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
//    _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_publishBtn setTitle:@"去发布" forState:UIControlStateNormal];
//    [_publishBtn.titleLabel setTextColor:[UIColor whiteColor]];
//    [_publishBtn setBackgroundColor:[UIColor redColor]];
//    [self addSubview:_publishBtn];
//
//    //没有作品时 显示
//    _tips = [[UILabel alloc] init];
//    [self addSubview:_tips];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = self.frame.size.width/3;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.collectionView.pagingEnabled = YES;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _worksCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [_worksCollection setBackgroundColor:[UIColor whiteColor]];
    //设置数据源代理
    _worksCollection.dataSource = self;
    _worksCollection.delegate = self;
    _worksCollection.scrollsToTop = NO;
    _worksCollection.showsVerticalScrollIndicator = NO;
    _worksCollection.showsHorizontalScrollIndicator = NO;
    _worksCollection.alwaysBounceHorizontal = NO;
    [_worksCollection registerClass:[WorkCell class] forCellWithReuseIdentifier:WORKS_CELL_IDENTIFIER];
    [_worksCollection registerClass:[WorksCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WORKS_HEADER_CELL_IDENTIFIER];
    [_worksCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WORKS_FOOTER_CELL_IDENTIFIER];
    
    [self addSubview:_worksCollection];
}

- (void)layoutSubviews{
    [super layoutSubviews];

}

- (void)updateWorksArray:(NSMutableArray *)works{
    self.worksArray = works;
    [self.worksCollection reloadData];
}


#pragma mark - UICollectionViewDelegate
/*
 * @brief 设置 HeadCollectionViewCell frame 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, 45); // 设置headerView的宽高
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.frame.size.width, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if([self.worksArray count] == 0 || !self.worksArray){
//        [_tips setText:JJ_NO_PHOTOS];
//        [_tips setTextColor:[UIColor grayColor]];
//        return 0;
//    }
//
//    return [self.worksArray count];
    
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WORKS_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell updateCell:@"https://pic1.zhimg.com/80/v2-ad32d1a90216857cb0b03658d748d368_hd.png" like:@"111"];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        WorksCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WORKS_HEADER_CELL_IDENTIFIER forIndexPath:indexPath];
        
        return header;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:WORKS_FOOTER_CELL_IDENTIFIER forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor whiteColor];
        UILabel *endText = [[UILabel alloc] init];
        [endText setText:@"我是有底线的 -_-||"];
        [endText setFont:[UIFont systemFontOfSize:16.0f]];
        [endText setTextColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1]];
        [endText setTextAlignment:NSTextAlignmentCenter];
        [footerView addSubview:endText];
        
        [endText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300.0f, 100.0f));
            make.center.mas_equalTo(footerView);
        }];
        
        return footerView;
    }
    
    return nil;
}

@end
