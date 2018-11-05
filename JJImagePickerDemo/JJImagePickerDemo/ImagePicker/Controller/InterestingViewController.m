//
//  InterestingViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "InterestingViewController.h"
#import "JJPublishPreviewCell.h"
#import "JJPhoto.h"

@interface InterestingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray *selectedImages;
//UICollectionView
@property (strong, nonatomic) UICollectionView *previewCollection;

@end

@implementation InterestingViewController
@synthesize selectedImages = _selectedImages;
@synthesize previewCollection = _previewCollection;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.customNaviBar setBackgroundColor:[UIColor lightGrayColor]];
    
    //取消
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(OnCancelCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarLeftBtn:cancel];
    
    //发表
    UIButton *publish = [UIButton buttonWithType:UIButtonTypeSystem];
    [publish setTitle:@"发表" forState:UIControlStateNormal];
    [publish addTarget:self action:@selector(OnPublishCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self setNaviBarRightBtn:publish];
    
    //不显示
    [self.jjTabBarView setHidden:YES];
    
    [self.view addSubview:self.previewCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//懒加载
-(UICollectionView *)previewCollection{
    if (!_previewCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //自动网格布局
        _previewCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        //设置数据源代理
        _previewCollection.dataSource = self;
        _previewCollection.delegate = self;
        
        _previewCollection.showsVerticalScrollIndicator = NO;
        _previewCollection.alwaysBounceHorizontal = NO;
        [_previewCollection setBackgroundColor:[UIColor whiteColor]];
        [_previewCollection registerClass:[JJPublishPreviewCell class] forCellWithReuseIdentifier:@"JJPublishPreviewCell"];
    }
    
    return _previewCollection;
}

- (void)setSelectedImages:(NSArray *)selectedImages{
    if(!selectedImages){
        return;
    }
    _selectedImages = selectedImages;
}

- (void)OnCancelCLick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//发表
- (void)OnPublishCLick:(UIButton *)sender{
    //http 请求发送到服务器
    NSLog(@"send .... ");
    
}

#pragma mark - collectionViewDelegate

//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分组里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.selectedImages count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //调整图片
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获得一个照片对象
    JJPhoto *imageAsset = [self.selectedImages objectAtIndex:indexPath.row];
    
    //初始化cell
    NSString *identifier = nil;
    if(imageAsset.assetType == JJAssetTypeVideo){
        identifier = @"JJPublishPreviewCell1";
    }else{
        identifier = @"JJPublishPreviewCell";
    }
    JJPublishPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //异步请求资源对应的缩略图
    [imageAsset requestThumbnailImageWithSize:[self referenceImageSize] completion:^(UIImage *result, NSDictionary *info) {
        [cell.contentImageView setImage:result];
    }];
    
    [cell setNeedsLayout];
    return cell;
}

//获取缩略图尺寸
- (CGSize)referenceImageSize{
    CGFloat collectionWidth = CGRectGetWidth(self.previewCollection.bounds);
    CGFloat collectionSpace = self.previewCollection.contentInset.left + self.previewCollection.contentInset.right;
    CGFloat referenceWidth = 0.0f;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
    }else{
        //如果是iPhone设备，默认显示的照片为4列
        referenceWidth = (collectionWidth - 4 * collectionSpace) / 4;
    }
    
    return CGSizeMake(referenceWidth, referenceWidth);
}

@end
