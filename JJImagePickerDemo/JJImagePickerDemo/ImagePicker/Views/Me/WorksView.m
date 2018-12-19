//
//  WorksView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "WorkCell.h"
#import "WorksView.h"
#define WORKS_CELL_IDENTIFIER @"WORKS_CELL_IDENTIFIER"
#define PUBLISH_BTN_HEIGHT 60.0f
#define PUBLISH_BTN_WIDTH 100.0f

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
    _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_publishBtn setTitle:@"去发布" forState:UIControlStateNormal];
    [_publishBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_publishBtn setBackgroundColor:[UIColor redColor]];
    [self addSubview:_publishBtn];
    
    _tips = [[UILabel alloc] init];
    [_tips setText:@"你还没有内容，快去发布吧！"];
    [_tips setTextColor:[UIColor grayColor]];
    [self addSubview:_tips];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.frame.size.width / 3, self.frame.size.width / 3 + 60.0f);
    layout.collectionView.pagingEnabled = YES;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _worksCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 50.0f) collectionViewLayout:layout];
    [_worksCollection setBackgroundColor:[UIColor clearColor]];
    //设置数据源代理
    _worksCollection.dataSource = self;
    _worksCollection.delegate = self;
    _worksCollection.scrollsToTop = NO;
    _worksCollection.showsVerticalScrollIndicator = NO;
    _worksCollection.showsHorizontalScrollIndicator = NO;
    _worksCollection.alwaysBounceHorizontal = NO;
    [_worksCollection registerClass:[WorkCell class] forCellWithReuseIdentifier:WORKS_CELL_IDENTIFIER];
    [self addSubview:_worksCollection];
}

- (void)layoutSubviews{
    CGFloat h = self.frame.size.height;
    [_publishBtn setFrame:CGRectMake((self.frame.size.width - PUBLISH_BTN_WIDTH)/2, 20.0f, PUBLISH_BTN_WIDTH, PUBLISH_BTN_HEIGHT)];
    [_tips setFrame:CGRectMake(0, (h - PUBLISH_BTN_HEIGHT - 60.0f)/2, self.frame.size.width, 60.0f)];
    [_worksCollection setFrame:CGRectMake(0, PUBLISH_BTN_HEIGHT, self.frame.size.width, h - PUBLISH_BTN_HEIGHT)];
}

- (void)updateWorksArray:(NSMutableArray *)works{
    self.worksArray = works;
    [self.worksCollection reloadData];
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WorkCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WORKS_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell updateCell:@"https://pic1.zhimg.com/80/v2-ad32d1a90216857cb0b03658d748d368_hd.png" like:@"111"];
    
    return cell;
}

@end
