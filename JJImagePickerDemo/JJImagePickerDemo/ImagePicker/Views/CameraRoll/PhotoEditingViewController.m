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
#define SPACEING_HORIZONTAL 20.0f
#define SPACE_VERTICAL 10.0f
#define EDIT_BTN_WIDTH 40.0f
#define EDIT_BTN_HEIGHT 40.0f

@implementation EditingToolCell
@synthesize editImage = _editImage;
@synthesize editTitle = _editTitle;
@synthesize editImageSel = _editImageSel;
@synthesize title = _title;
@synthesize iconV = _iconV;

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
    self.iconV = [[UIImageView alloc] init];
    self.editImage = [[UIImage alloc] init];
    
    [self.contentView addSubview:self.iconV];
    
    self.title = [[UILabel alloc] init];
    [self.title setFont:[UIFont systemFontOfSize:10.0f]];
    [self.title setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.title];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGSize size = self.bounds.size;
    CGFloat fDeltaWidth = (size.width - _editImage.size.width)/2;
    CGFloat fDeltaHeight = (size.height - _editImage.size.height)/2;
    
    [self.iconV setFrame:CGRectMake(fDeltaWidth, fDeltaHeight, _editImage.size.width, _editImage.size.height)];
    [self.iconV setImage:self.editImage];
    [self.title setFrame:CGRectMake(fDeltaWidth, fDeltaHeight + _editImage.size.height, _editImage.size.width, 10)];
    [self.title setText:self.editTitle];
}

@end

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
    self.editToolView.delegate = self;
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

//懒加载
- (EditingSubToolView *)editSubToolView{
    if(!_editSubToolView){
        _editSubToolView = [[EditingSubToolView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - JJ_EDITTOOL_HEIGHT, self.view.bounds.size.width, JJ_EDITTOOL_HEIGHT)];
        _editSubToolView.delegate = self;
    }
    return _editSubToolView;
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

#pragma mark - PhotoEditingDelegate
- (void)PhotoEditingFinished:(UIImage *)image{
    
}

- (void)PhotoEditShowSubEditTool:(UICollectionView *)collectionV Index:(NSInteger)index array:(NSArray *)array{
    [self.editToolView setHidden:YES];
    [self.editSubToolView setSubToolArray:[NSMutableArray arrayWithArray:array]];
    [self.view addSubview:self.editSubToolView];
}

- (void)PhotoEditSubEditToolDismiss{
    [self.editSubToolView removeFromSuperview];
    self.editSubToolView = nil;
    [self.editToolView setHidden:NO];
}

- (void)PhotoEditSubEditToolConfirm{
    
}
@end
