//
//  EditingToolView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "EditingToolView.h"
#import "EditingToolCell.h"

#define JJ_PHOTO_EDITING_CELL @"PHOTO_EDITING_CELL"
#define JJ_PHOTO_EDITING_SUBTOOL_CELL @"JJ_PHOTO_EDITING_SUBTOOL_CELL"
#define SPACEING_HORIZONTAL 20.0f
#define SPACE_VERTICAL 10.0f
#define EDIT_BTN_WIDTH 40.0f
#define EDIT_BTN_HEIGHT 40.0f

@implementation EditingToolView

@synthesize toolArray = _toolArray;
@synthesize toolCollectionView = _toolCollectionView;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame{
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
    [self addSubview:self.toolCollectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

//懒加载
-(UICollectionView *)toolCollectionView{
    if (!_toolCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(60, 60);
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //自动网格布局
        _toolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        //设置数据源代理
        _toolCollectionView.dataSource = self;
        _toolCollectionView.delegate = self;
        _toolCollectionView.scrollsToTop = NO;
        _toolCollectionView.showsVerticalScrollIndicator = NO;
        _toolCollectionView.showsHorizontalScrollIndicator = NO;
        _toolCollectionView.alwaysBounceHorizontal = NO;
        [_toolCollectionView setBackgroundColor:[UIColor whiteColor]];
        [_toolCollectionView registerClass:[EditingToolCell class] forCellWithReuseIdentifier:JJ_PHOTO_EDITING_CELL];
    }
    
    return _toolCollectionView;
}


#pragma mark - collectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_toolArray count];;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == _toolCollectionView){
        //回调选择的是哪个子工具
        NSDictionary *tool = [self.toolArray objectAtIndex:indexPath.row];
        
        if(![tool objectForKey:@"subTools"]){
            return;
        }
        
        NSArray *subTools = [tool objectForKey:@"subTools"];
        [_delegate PhotoEditShowSubEditTool:collectionView Index:indexPath.row array:subTools];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PHOTO_EDITING_CELL;
    EditingToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSDictionary *tool = [self.toolArray objectAtIndex:indexPath.row];
    NSString *asset = [tool objectForKey:@"imagePath"];
    NSString *title = [tool objectForKey:@"name"];
    
    UIImage *test =  [UIImage imageNamed:asset];
    
    cell.editTitle = title;
    cell.editImage = test;
    
    return cell;
}

@end

@implementation EditingSubToolView
@synthesize subToolArray = _subToolArray;
@synthesize subToolCollectionView = _subToolCollectionView;
@synthesize cancel = _cancel;
@synthesize confirm = _confirm;
@synthesize titleLabel = _titleLabel;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame{
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
    [self setBackgroundColor:[UIColor whiteColor]];
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirm addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self addSubview:self.subToolCollectionView];
    CGFloat height = self.subToolCollectionView.frame.size.height;
    UIImage *close = [UIImage imageNamed:@"tabbar_close"];
    UIImage *finish = [UIImage imageNamed:@"tabbar_finish"];
    
    [self.cancel setBackgroundImage:close forState:UIControlStateNormal];
    [self.cancel setFrame:CGRectMake(SPACEING_HORIZONTAL, height, close.size.width, close.size.height)];
    
    [self.confirm setBackgroundImage:finish forState:UIControlStateNormal];
    [self.confirm setFrame:CGRectMake(self.bounds.size.width - finish.size.width - SPACEING_HORIZONTAL, height, finish.size.width, finish.size.width)];
    
    [self addSubview:self.cancel];
    [self addSubview:self.confirm];
}

//懒加载
- (UICollectionView *)subToolCollectionView{
    if(!_subToolCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(70, 70);
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //自动网格布局
        _subToolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30) collectionViewLayout:layout];
        //设置数据源代理
        _subToolCollectionView.dataSource = self;
        _subToolCollectionView.delegate = self;
        _subToolCollectionView.scrollsToTop = NO;
        _subToolCollectionView.showsVerticalScrollIndicator = NO;
        _subToolCollectionView.showsHorizontalScrollIndicator = NO;
        _subToolCollectionView.alwaysBounceHorizontal = NO;
        [_subToolCollectionView setBackgroundColor:[UIColor whiteColor]];
        [_subToolCollectionView registerClass:[EditingToolCell class] forCellWithReuseIdentifier:JJ_PHOTO_EDITING_SUBTOOL_CELL];
    }
    
    return _subToolCollectionView;
}

- (void)setSubToolArray:(NSMutableArray *)subToolArray{
    if(!subToolArray){
        return;
    }
    _subToolArray = nil;
    _subToolArray = subToolArray;
    [_subToolCollectionView reloadData];
}

- (void)clickCancelBtn:(UIButton *)sender{
    //取消
    if([_delegate respondsToSelector:@selector(PhotoEditSubEditToolDismiss)]){
        [_delegate PhotoEditSubEditToolDismiss];
    }
}

- (void)clickConfirmBtn:(UIButton *)sender{
    //保存图片
    if([_delegate respondsToSelector:@selector(PhotoEditSubEditToolConfirm)]){
        [_delegate PhotoEditSubEditToolConfirm];
    }
}

#pragma mark - collectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_subToolArray count];;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //对图片做相对应的处理操作
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PHOTO_EDITING_SUBTOOL_CELL;
    EditingToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *tool = [self.subToolArray objectAtIndex:indexPath.row];
    NSString *asset = [tool objectForKey:@"imagePath"];
    NSString *title = [tool objectForKey:@"name"];
    
    cell.editImage = nil;
    cell.editTitle =nil;
    
    cell.editImage = [UIImage imageNamed:asset];
    cell.editTitle = title;
    return cell;
}


@end


