//
//  PhotoEditingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "PhotoEditingViewController.h"

#define JJ_PHOTO_EDITING_CELL @"PHOTO_EDITING_CELL"
#define JJ_PHOTO_EDITING_SUBTOOL_CELL @"JJ_PHOTO_EDITING_SUBTOOL_CELL"
#define JJ_EDITTOOL_HEIGHT 100

@implementation EditingToolCell
@synthesize editImage = _editImage;
@synthesize editTitle = _editTitle;
@synthesize editBtn = _editBtn;
@synthesize editImageSel = _editImageSel;

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
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.editBtn setImage:_editImage forState:UIControlStateNormal];
    [self.editBtn setImage:_editImageSel forState:UIControlStateSelected];
    [self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editBtn.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    
    
    CGFloat fDeltaWidth = (self.bounds.size.width - _editImage.size.width)/2.0f;
    CGFloat fDeltaHeight = (self.bounds.size.height - _editImage.size.height)/2.0f;
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    
    [self.editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, fDeltaWidth, 0.0f, 0.0f)];
    [self.editBtn setTitleEdgeInsets:UIEdgeInsetsMake(_editImage.size.height + fDeltaHeight * 3, -(self.bounds.size.width - self.editBtn.titleLabel.frame.size.width)/2, 0, 0)];
    
    
    [self.contentView addSubview:self.editBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.editBtn setFrame:self.bounds];
}

@end

@implementation EditingToolView
@synthesize toolArray = _toolArray;
@synthesize toolCollectionView = _toolCollectionView;

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
    
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PHOTO_EDITING_CELL;
    EditingToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *tool = [self.toolArray objectAtIndex:indexPath.row];
    NSString *asset = [tool objectForKey:@"imagePath"];
    NSString *title = [tool objectForKey:@"name"];
    [cell.editBtn setImage:[UIImage imageNamed:asset] forState:UIControlStateNormal];
    [cell.editBtn setTitle:title forState:UIControlStateNormal];
    
    return cell;
}
@end

@implementation EditingSubToolView
@synthesize subToolArray = _subToolArray;
@synthesize subToolCollectionView = _subToolCollectionView;
@synthesize cancel = _cancel;
@synthesize confirm = _confirm;
@synthesize titleLabel = _titleLabel;

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
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setFrame:CGRectMake(20.0f, 60.0f, 40.0f, 40.0f)];
    [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:self.cancel];
    
    self.confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirm setFrame:CGRectMake(self.bounds.size.width - 60.0f, 60.0f, 40.0f, 40.0f)];
    [self.confirm setTitle:@"确认" forState:UIControlStateNormal];
    [self addSubview:self.confirm];
    
    [self.cancel setHidden:YES];
    [self.confirm setHidden:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

//懒加载
- (UICollectionView *)subToolCollectionView{
    if(!_subToolCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(60, 60);
        layout.collectionView.pagingEnabled = YES;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //自动网格布局
        _subToolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40) collectionViewLayout:layout];
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

#pragma mark - collectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_subToolArray count];;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化cell
    NSString *identifier = JJ_PHOTO_EDITING_SUBTOOL_CELL;
    EditingToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *tool = [self.subToolArray objectAtIndex:indexPath.row];
    NSString *asset = [tool objectForKey:@"imagePath"];
    NSString *title = [tool objectForKey:@"name"];
    [cell.editBtn setImage:[UIImage imageNamed:asset] forState:UIControlStateNormal];
    [cell.editBtn setTitle:title forState:UIControlStateNormal];
    
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
@synthesize editData = _editData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    //背景色去除
    [self.customNaviBar setBackgroundColor:[UIColor whiteColor]];
    [self.jjTabBarView setHidden:YES];
    
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
    self.editData = [self loadEditToolConfigFile];
    if(![self.editData objectForKey:@"field"]){
        NSLog(@"配置文件加载失败");
        return;
    }

    self.editToolView = [[EditingToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT, self.view.bounds.size.width, JJ_EDITTOOL_HEIGHT)];
    self.editToolView.toolArray = [self.editData objectForKey:@"field"];
    [self.view addSubview:self.editToolView];
    
    //预览图
    self.preViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.editToolView.frame.size.height)];
    self.preViewImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.preViewImage];

    [self.view bringSubviewToFront:self.editToolView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - init edit tool
- (NSDictionary *)loadEditToolConfigFile{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
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
    //跳转到发布页面
    
}


@end
