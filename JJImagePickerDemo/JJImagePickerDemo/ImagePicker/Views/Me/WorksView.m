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
@synthesize sepearateL = _sepearateL;

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
    
    _sepearateL = [[UIImageView alloc] init];
    [_sepearateL setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1]];
    [self addSubview:_sepearateL];
}

- (void)layoutSubviews{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200.0f, 30.0f));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20.0f);
    }];
    
    [_sepearateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 10, 1));
        make.left.equalTo(self).offset(10.0f);
        make.bottom.equalTo(self).offset(-1.0f);
    }];
}

@end


@implementation WorksView
@synthesize publishBtn = _publishBtn;
@synthesize worksCollection = _worksCollection;
@synthesize tips = _tips;
@synthesize worksArray = _worksArray;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
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
    
    _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_publishBtn setTitle:@"去发布" forState:UIControlStateNormal];
    [_publishBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_publishBtn setBackgroundColor:[UIColor redColor]];
    [_publishBtn addTarget:self action:@selector(clickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_worksCollection addSubview:_publishBtn];
    
    //没有作品时 显示
    _tips = [[UILabel alloc] init];
    [_tips setTextAlignment:NSTextAlignmentCenter];
    [_tips setText:JJ_NO_PHOTOS];
    [_tips setTextColor:[UIColor grayColor]];
    [_worksCollection addSubview:_tips];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120.0f, 40.0f));
        make.center.mas_equalTo(self);
    }];
    
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width, 30.0f));
        make.centerY.mas_equalTo(self).offset(-50.0f);
    }];
    
    [self.publishBtn setHidden:YES];
    [self.tips setHidden:YES];
}

- (void)updateWorksArray:(NSMutableArray *)works{
    self.worksArray = works;
    if([self.worksArray count] == 0 || !self.worksArray){
        [self.publishBtn setHidden:NO];
        [self.tips setHidden:NO];
        return ;
    }
    
    [self.publishBtn setHidden:YES];
    [self.tips setHidden:YES];
    [self.worksCollection reloadData];
}

/**
 发布作品
 */
- (void)clickPublishBtn:(UIButton *)sender{
    if([_delegate respondsToSelector:@selector(publishWorksCallback)]){
        [_delegate publishWorksCallback];
    }
}


#pragma mark - UICollectionViewDelegate
/*
 * @brief 设置 HeadCollectionViewCell frame 大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, 45);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.frame.size.width, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Works *work = [self.worksArray objectAtIndex:indexPath.row];
    if(work){
        if([_delegate respondsToSelector:@selector(goToWorksDetailViewCallback:)]){
            [_delegate goToWorksDetailViewCallback:work];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(!self.worksArray){
        return 0;
    }
    return [self.worksArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WORKS_CELL_IDENTIFIER forIndexPath:indexPath];
    
    Works *work = [self.worksArray objectAtIndex:indexPath.row];
    
    [cell updateCell:work.path];
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
        
        if([self.worksArray count] != 0 && self.worksArray){
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
        }
        
        return footerView;
    }
    
    return nil;
}

@end
