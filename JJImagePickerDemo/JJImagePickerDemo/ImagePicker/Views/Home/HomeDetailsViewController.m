//
//  HomeDetailsViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/26.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <YYText/YYLabel.h>
#import <YYText/NSAttributedString+YYText.h>
#import "UIScrollView+UITouch.h"
#import "JJThumbPhotoCell.h"
#import "JJTokenManager.h"

@interface HomeDetailsViewController ()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UICollectionView *workView;
@property (strong, nonatomic) UIScrollView *worksInfoView;
@property (strong, nonatomic) YYLabel *worksDesc;
@property (strong, nonatomic) UILabel *timeLine;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) HomeCubeModel *photoWork;
@property (strong, nonatomic) UIButton *likeBtn;
@property (strong, nonatomic) UILabel *likeNum;
@property (strong, nonatomic) NSMutableArray *photosArray;
@property (assign) NSInteger albumRows;
@property (assign) NSInteger albumColums;
@property (assign) BOOL isEven;

// 大图模式
@property (strong, nonatomic) CustomNewsBanner *completeWorkView;
@end

@implementation HomeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPhotoUrl];
    [self setupUI];
}

- (void)initPhotoUrl{
    _photosArray = [[NSMutableArray alloc] initWithArray:_photoWork.path];
    //计算几行几列
    NSInteger photoCount = [_photosArray count];
    
    switch (photoCount) {
        case 1:
            _albumRows = 1;
            _albumColums = 1;
            _isEven = NO;
            break;
        case 2:
            _albumRows = 1;
            _albumColums = 2;
            _isEven = YES;
            break;
        case 3:
            _albumRows = 1;
            _albumColums = 2;
            _isEven = NO;
            break;
        case 4:
            _albumRows = 2;
            _albumColums = 2;
            _isEven = YES;
            break;
        case 5:
            _albumRows = 2;
            _albumColums = 2;
            _isEven = NO;
            break;
        case 6:
            _albumRows = 2;
            _albumColums = 3;
            _isEven = YES;
            break;
        case 7:
            _albumRows = 2;
            _albumColums = 3;
            _isEven = NO;
            break;
        case 8:
            _albumRows = 2;
            _albumColums = 4;
            _isEven = YES;
            break;
        case 9:
            _albumRows = 2;
            _albumColums = 4;
            _isEven = NO;
            break;
        default:
            break;
    }
}

- (void)setupUI{
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    CGFloat w = self.view.frame.size.width;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((w - 200)/2, 25.0f, 200.0f, 40.0f)];
    [title setText:@"作品详情"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];
    [self.jjTabBarView setHidden:YES];
    
    //滚动视图
    self.worksInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height + 10.0f, self.view.frame.size.height, self.view.frame.size.height - self.customNaviBar.frame.size.height - 10.0f)];
    self.worksInfoView.showsHorizontalScrollIndicator = NO;
    self.worksInfoView.alwaysBounceVertical = YES;
    [self.worksInfoView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.worksInfoView];
    
    //icon
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.iconView setBackgroundColor:[UIColor clearColor]];
    [self.iconView.layer setCornerRadius:self.iconView.frame.size.width/2];
    [self.iconView.layer setMasksToBounds:YES];
    NSString *avatar = [JJTokenManager shareInstance].getUserAvatar;
    [self.iconView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatar]]]];
    [self.worksInfoView addSubview:self.iconView];
    
    //名字
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.nameLabel setText:[JJTokenManager shareInstance].getUserName];
    [self.worksInfoView addSubview:self.nameLabel];
    
    //关注
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.shareBtn setBackgroundColor:[UIColor clearColor]];
    [self.shareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.shareBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.shareBtn.layer setBorderWidth:1.0f];
    [self.shareBtn.layer setBorderColor:[UIColor redColor].CGColor];
    [self.shareBtn.layer setCornerRadius:8.0f];
    [self.shareBtn.layer setMasksToBounds:YES];
    [self.shareBtn addTarget:self action:@selector(clickConcernBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.worksInfoView addSubview:self.shareBtn];
    [self.shareBtn setHidden:YES];
    
    //图片
    [self.worksInfoView addSubview:self.workView];
    
    NSString *work = [self.photoWork.work stringByRemovingPercentEncoding];
    //描述
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:work];
    
    text.yy_font = [UIFont systemFontOfSize:15.0f];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 2;
    
    CGFloat screenWidth = self.view.frame.size.width;
    CGSize size = CGSizeMake(screenWidth - 30, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    self.worksDesc = [YYLabel new];
    self.worksDesc.textLayout = layout;
    self.worksDesc.attributedText = text;
    [self.worksDesc setFrame:layout.textBoundingRect];
    [self.worksInfoView addSubview:self.worksDesc];
    
    //时间
    self.timeLine = [[UILabel alloc] init];
    [self.timeLine setTextAlignment:NSTextAlignmentLeft];
    [self.timeLine setTextColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1]];
    [self.timeLine setFont:[UIFont systemFontOfSize:12.0f]];
    [self.timeLine setText:self.photoWork.postTime];
    [self.worksInfoView addSubview:self.timeLine];
    
    //点赞
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setBackgroundColor:[UIColor clearColor]];
    [self.likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"like_sel"] forState:UIControlStateSelected];
    [self.likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.worksInfoView addSubview:self.likeBtn];
    
    //点赞数
    self.likeNum = [[UILabel alloc] init];
    [self.likeNum setTextAlignment:NSTextAlignmentCenter];
    [self.likeNum setTextColor:[UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1]];
    [self.likeNum setFont:[UIFont systemFontOfSize:12.0f]];
    [self.likeNum setText:self.photoWork.likeNum];
    [self.worksInfoView addSubview:self.likeNum];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        make.left.top.mas_equalTo(self.worksInfoView).offset(10.0f);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150.0f, 30.0f));
        make.left.equalTo(self.iconView.mas_right).offset(10.0f);
        make.centerY.mas_equalTo(self.iconView);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45.0f, 25.0f));
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.worksInfoView).offset(self.view.frame.size.width - 60.0f);
    }];
    
    [self.workView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat workViewHeight = 0.0f;
        if(self.isEven){
            workViewHeight = (screenWidth - 10.0f) / self.albumColums * self.albumRows;
        }else{
            CGFloat firstCellHeight = (screenWidth - 10.0f)*9/16;
            workViewHeight = (screenWidth - 10.0f) / self.albumColums * self.albumRows + firstCellHeight;
        }
        
        make.size.mas_equalTo(CGSizeMake(screenWidth - 10.0f, workViewHeight));
        make.left.equalTo(self.worksInfoView).offset(5.0f);
        make.right.equalTo(self.worksInfoView).offset(-5.0f);
        make.top.equalTo(self.iconView.mas_bottom).offset(10.0f);
    }];
    
    [self.worksDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(layout.textBoundingSize.width, layout.textBoundingSize.height));
        make.left.equalTo(self.worksInfoView).offset(15.0f);
        make.top.equalTo(self.workView.mas_bottom).offset(10.0f);
    }];
    
    
    [self.timeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150.0f, 20.0f));
        make.left.equalTo(self.worksInfoView).offset(15.0f);
        make.top.equalTo(self.worksDesc.mas_bottom).offset(20.0f);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25.0f, 23.0f));
        make.centerY.mas_equalTo(self.timeLine);
        make.right.mas_equalTo(self.workView).offset(-50.0f);
        make.bottom.equalTo(self.worksInfoView).offset(-50.0f);
    }];
    
    [self.likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 20.0f));
        make.right.equalTo(self.workView);
        make.centerY.equalTo(self.likeBtn);
    }];
}

- (void)clickConcernBtn:(UIButton *)sender{
    NSLog(@"111111");
}

- (void)clickLikeBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        
    }
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setWorksInfo:(HomeCubeModel *)detailInfo{
    if(!detailInfo){
        return;
    }
    
    self.photoWork = detailInfo;
}

-(UICollectionView *)workView{
    if (!_workView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _workView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        //设置数据源代理
        _workView.dataSource = self;
        _workView.delegate = self;
        
        _workView.showsVerticalScrollIndicator = NO;
        _workView.alwaysBounceHorizontal = NO;
        [_workView setBackgroundColor:[UIColor clearColor]];
        [_workView registerClass:[JJThumbPhotoCell class] forCellWithReuseIdentifier:@"JJThumbPhotoCell"];
    }
    
    return _workView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photoWork.path count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJThumbPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JJThumbPhotoCell" forIndexPath:indexPath];
    
    NSString *photoUrl = [self.photoWork.path objectAtIndex:indexPath.row];
    [cell updateCell:photoUrl];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //跳转预览图
    
    _completeWorkView = [[CustomNewsBanner alloc] initWithFrame:self.view.frame];
    _completeWorkView.delegate = self;
    [_completeWorkView setProductsArray:[[NSMutableArray alloc] initWithArray:_photoWork.path]];
    
    [self.view addSubview:_completeWorkView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = 0.0f;
    CGFloat cellHeight = 0.0f;
    
    if(_isEven){
        CGFloat width = collectionView.frame.size.width;
        cellWidth = width/_albumColums;
        cellHeight = cellWidth;
    }else{
        if(indexPath.row == 0){
            cellWidth = collectionView.frame.size.width;
            cellHeight = cellWidth*9/16;
        }else{
            CGFloat width = collectionView.frame.size.width;
            cellWidth = width/_albumColums;
            cellHeight = cellWidth;
        }
    }
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (void)newsbanner:(CustomNewsBanner *)newsbanner didSelectItemAtIndex:(NSInteger)index{
    [newsbanner removeFromSuperview];
}

@end
