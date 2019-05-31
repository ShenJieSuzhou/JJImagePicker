//
//  OriginalWorksViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/15.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "OriginalWorksViewController.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <YYText/YYLabel.h>
#import <YYText/NSAttributedString+YYText.h>
#import "UIScrollView+UITouch.h"
#import "JJThumbPhotoCell.h"
#import "JJTokenManager.h"
#import "GlobalDefine.h"
#import "JJLikeButton.h"
#import "HttpRequestUtil.h"
#import "HttpRequestUrlDefine.h"
#import <LEEAlert/LEEAlert.h>
#import "SelectedListView.h"
#import "SelectedListModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface OriginalWorksViewController ()<TipoffDelegate>
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UICollectionView *workView;
@property (strong, nonatomic) UIScrollView *worksInfoView;
@property (strong, nonatomic) YYLabel *worksDesc;
@property (strong, nonatomic) UILabel *timeLine;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) UIButton *moreBtn;
@property (strong, nonatomic) Works *photoWork;
@property (strong, nonatomic) JJLikeButton *likeBtn;
@property (strong, nonatomic) UILabel *likeNum;
@property (strong, nonatomic) NSMutableArray *photosArray;
@property (assign) NSInteger albumRows;
@property (assign) NSInteger albumColums;
@property (assign) BOOL isEven;
@property (assign) int currentLikes;

// 大图模式
@property (strong, nonatomic) CustomNewsBanner *completeWorkView;
@end

@implementation OriginalWorksViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

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

    [self.navigationItem setTitle:@"作品详情"];
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    //滚动视图
    self.worksInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, JJ_NAV_ST_H, self.view.frame.size.height, self.view.frame.size.height - JJ_NAV_ST_H)];
    self.worksInfoView.showsHorizontalScrollIndicator = NO;
    self.worksInfoView.alwaysBounceVertical = YES;
    [self.worksInfoView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.worksInfoView];
    
    //icon
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.iconView setBackgroundColor:[UIColor clearColor]];
    [self.iconView.layer setCornerRadius:self.iconView.frame.size.width / 2];
    [self.iconView.layer setMasksToBounds:YES];
    NSString *avatar = self.photoWork.avatar;
    if(avatar.length == 0){
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"userPlaceHold"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }else{
        [self loadIconAvater:avatar];
    }
    
    [self.worksInfoView addSubview:self.iconView];
    
    //名字
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.nameLabel setText:self.photoWork.nickName];
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
    
    // 更多
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.worksInfoView addSubview:self.moreBtn];
    if([self.photoWork.userid isEqualToString:[JJTokenManager shareInstance].getUserID]){
        [self.moreBtn setHidden:YES];
    }
    
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
    self.likeBtn = [JJLikeButton coolButtonWithImage:[UIImage imageNamed:@"heart"] ImageFrame:CGRectMake(0, 0, 20, 20)];
    //图片选中状态颜色
    self.likeBtn.imageColorOn = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    //圆圈颜色
    self.likeBtn.circleColor = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    //线条颜色
    self.likeBtn.lineColor = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    [self.likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.worksInfoView addSubview:self.likeBtn];
    
    if(self.photoWork.hasLiked){
        [self.likeBtn select];
    }else{
        [self.likeBtn deselect];
    }
    
    //点赞数
    self.currentLikes = self.photoWork.likeNum.intValue;
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
        make.left.mas_equalTo(self.worksInfoView).offset(self.view.frame.size.width - 110.0f);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30.0f, 30.0f));
        make.right.mas_equalTo(self.worksInfoView.mas_right).offset(-10.0f);
        make.centerY.mas_equalTo(self.iconView);
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

- (void)clickMoreBtn:(UIButton *)sender{
    // 自定义试图
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    reportView *reportV = [reportView getInstance];
    reportV.delegate = self;

    [customView addSubview:reportV];

    [LEEAlert actionsheet].config
    .LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = customView;
        custom.isAutoWidth = YES;
    })
    .LeeAddAction(^(LEEAction *action) {
        action.type = LEEActionTypeDefault;
        action.title = @"取消";
        action.titleColor = [UIColor grayColor];
    })
    .LeeShow();
}

- (void)clickConcernBtn:(UIButton *)sender{
    NSLog(@"111111");
}

- (void)clickLikeBtn:(JJLikeButton *)sender{
    if (sender.selected) {
        //未选中状态
        [sender deselect];
        self.currentLikes = self.currentLikes - 1;
    } else {
        //选中状态
        [sender select];
        self.currentLikes = self.currentLikes + 1;
    }
    
    [_photoWork setLikeNum:[NSString stringWithFormat:@"%d", self.currentLikes]];
    [_photoWork setHasLiked:sender.selected];
    
    [_likeNum setText:[NSString stringWithFormat:@"%ld", (long)self.currentLikes]];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoLike:) object:sender];
    [self performSelector:@selector(toDoLike:) withObject:sender afterDelay:0.2f];
}

// 点赞
- (void)toDoLike:(UIButton *)sender{
    if(sender.selected){
        [HttpRequestUtil JJ_INCREMENT_LIKECOUNT:POST_LIKE_REQUEST token:[JJTokenManager shareInstance].getUserToken photoId:self.photoWork.photoid userid:self.photoWork.userid callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
            // token 过期
        }];
    }else{
        [HttpRequestUtil JJ_DECREMENT_LIKECOUNT:POST_UNLIKE_REQUEST token:[JJTokenManager shareInstance].getUserToken photoId:self.photoWork.photoid userid:self.photoWork.userid callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
            // token 过期
        }];
    }
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setWorksInfo:(Works *)workModel{
    if(!workModel){
        return;
    }
    
    self.photoWork = workModel;
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

#pragma -mark 加载头像
- (void)loadIconAvater:(NSString *)avatar{
    __weak typeof(self) weakself = self;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager diskImageExistsForURL:[NSURL URLWithString:avatar] completion:^(BOOL isInCache) {
        if(isInCache){
            NSString *key = [manager cacheKeyForURL:[NSURL URLWithString:avatar]];
            UIImage *image = [[manager imageCache] imageFromDiskCacheForKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.iconView setImage:image];
            });
        }else{
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:avatar] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                NSString *key = [manager cacheKeyForURL:[NSURL URLWithString:avatar]];
                [manager saveImageToCache:image forURL:[NSURL URLWithString:key]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.iconView setImage:image];
                });
            }];
        }
    }];
}

- (void)tipOffSelectedCallBack:(SelectedListModel *)model{
    SelectedListModel *selectedModel = model;
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_TipOff:TIPOFF_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:self.photoWork.userid defendant:weakSelf.photoWork.userid photoid:weakSelf.photoWork.photoid reason:selectedModel.title callback:^(NSDictionary *data, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
            
            if([[data objectForKey:@"result"] isEqualToString:@"1"]){
                [SVProgressHUD showSuccessWithStatus:JJ_TIPOFF_SUCCESS];
                [SVProgressHUD dismissWithDelay:1.0f];
            }else{
                [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
                [SVProgressHUD dismissWithDelay:1.0f];
            }
        });
    }];
}


#pragma -mark reportViewDelegate
- (void)clickTipOffCallBack{
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 0) style:UITableViewStylePlain];
    view.mDelegate = self;

    view.isSingle = YES;

    view.array = @[[[SelectedListModel alloc] initWithSid:0 Title:@"垃圾广告"] ,
                   [[SelectedListModel alloc] initWithSid:1 Title:@"淫秽色情"] ,
                   [[SelectedListModel alloc] initWithSid:2 Title:@"低俗辱骂"] ,
                   [[SelectedListModel alloc] initWithSid:3 Title:@"涉政涉密"] ,
                   [[SelectedListModel alloc] initWithSid:4 Title:@"欺诈谣言"] ];

    [LEEAlert actionsheet].config
    .LeeTitle(@"举报内容问题")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = view;
        custom.isAutoWidth = YES;
    })
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeAddAction(^(LEEAction *action) {
        action.title = @"取消";
        action.titleColor = [UIColor blackColor];
        action.backgroundColor = [UIColor whiteColor];
    })
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeHeaderColor([UIColor colorWithRed:243/255.0f green:243/255.0f blue:243/255.0f alpha:1.0f])
    .LeeActionSheetBottomMargin(0.0f) // 设置底部距离屏幕的边距为0
    .LeeCornerRadius(0.0f) // 设置圆角曲率为0
    .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
        // 这是最大宽度为屏幕宽度 (横屏和竖屏)
        return CGRectGetWidth([[UIScreen mainScreen] bounds]);
    })
    .LeeShow();
}

- (void)clickPullBlackCallBack{
    __weak typeof(self) weakSelf = self;
    [LEEAlert alert].config
    .LeeContent(JJ_ADDTO_BLACKLIST)
    .LeeCancelAction(@"取消", ^{
        // 取消点击事件Block
    })
    .LeeAction(@"确认", ^{
        // 确认点击事件Block
        [HttpRequestUtil JJ_PullBlack:PULL_BLACK_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:self.photoWork.userid defendant:weakSelf.photoWork.userid callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
            
            if([[data objectForKey:@"result"] isEqualToString:@"1"]){
                [SVProgressHUD showSuccessWithStatus:JJ_ADDBLACKLIST_SUCCESS];
                [SVProgressHUD dismissWithDelay:1.0f];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
                [SVProgressHUD dismissWithDelay:1.0f];
            }
        }];
    })
    .LeeShow();
}

@end
