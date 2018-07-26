//
//  PhotoEditingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoEditingViewController.h"

#define JJ_PHOTO_EDITING_CELL @"PHOTO_EDITING_CELL"

@implementation EditingToolCell
@synthesize previewImage = _previewImage;

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
    [self.contentView addSubview:self.previewImage];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_previewImage setFrame:self.bounds];
}

@end

@implementation EditingToolView
@synthesize toolArray = _toolArray;
@synthesize subToolArray = _subToolArray;
@synthesize toolCollectionView = _toolCollectionView;
@synthesize subToolCollectionView = _subToolCollectionView;

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
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //自动网格布局
        _toolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        //设置数据源代理
        _toolCollectionView.dataSource = self;
        _toolCollectionView.delegate = self;
        _toolCollectionView.showsVerticalScrollIndicator = NO;
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

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PHOTO_EDITING_CELL;
    EditingToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSString *asset = [self.toolArray objectAtIndex:indexPath.row];
    [cell.previewImage setImage:[UIImage imageNamed:asset]];
    
    return cell;
}
@end


@interface PhotoEditingViewController ()

@end

@implementation PhotoEditingViewController
@synthesize delegate = _delegate;
@synthesize preViewImage = _preViewImage;
@synthesize preImage = _preImage;
@synthesize editToolView = _editToolView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    //背景色去除
    [self.customNaviBar setBackgroundColor:[UIColor whiteColor]];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"uls_tb_intro_return_n"] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:backBtn withFrame:CGRectMake(20.0f, 22.0f, 14.0f, 23.0f)];
    
    //完成
    UIButton *finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishedBtn setBackgroundImage:[UIImage imageNamed:@"chooseInterest_cheaked"] forState:UIControlStateSelected];
    [finishedBtn setBackgroundColor:[UIColor clearColor]];
    [finishedBtn addTarget:self action:@selector(finishedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setRightBtn:finishedBtn withFrame:CGRectMake(self.view.bounds.size.width - 45.0f, 22.0f, 25.0f, 25.0f)];
    
    //底部工具栏
    self.editToolView = [[EditingToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 100, self.view.bounds.size.width, 100)];
    [self.view addSubview:self.editToolView];
    
    //预览图
    self.preViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.editToolView.frame.size.height)];
    self.preViewImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.preViewImage];

    [self.view bringSubviewToFront:self.editToolView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - image process business
- (void)setEditImage:(UIImage *)image{
    if(!image){
        return;
    }
    
    [self.preViewImage setImage:image];
}

//返回
- (void)backBtnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//finished 完成
- (void)finishedBtnClick:(UIButton *)sender{
    
}


@end
