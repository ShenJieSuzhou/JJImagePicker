//
//  JJDetailsInfoView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/8/22.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJDetailsInfoHeaderView.h"

@implementation JJDetailsInfoHeaderView
@synthesize delegate = _delegate;
@synthesize height = _height;
@synthesize photoWork = _photoWork;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"JJDetailsInfoHeaderView";
    JJDetailsInfoHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if(header == nil){
        header = [[self alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        // 创建控件
        [self setupUI];
    }
    
    return self;
}

- (void)setWorkFrame:(JJWorksFrame *)workFrame{
    _workFrame = workFrame;
    
    _photoWork = _workFrame.workModel;
    // 头像
    [self.iconView setFrame:workFrame.avatarFrame];
    NSString *avatar = _photoWork.iconUrl;
    [self loadIconAvater:avatar];
    
    // 昵称
    [self.nameLabel setFrame:workFrame.nicknameFrame];
    [self.nameLabel setText:_photoWork.name];
    
    // 关注
    [self.focusBtn setFrame:workFrame.focusFrame];
    
    // 更多
    [self.moreBtn setFrame:workFrame.moreFrame];
    
    // 作品
    [self.workView setFrame:workFrame.worksFrame];
    
    // 描述
    [self.worksDesc setFrame:workFrame.textFrame];
    NSString *work = [self.photoWork.work stringByRemovingPercentEncoding];
    //描述
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:work];
    
    text.yy_font = [UIFont systemFontOfSize:15.0f];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 2;
    
    CGFloat screenWidth = self.frame.size.width;
    CGSize size = CGSizeMake(screenWidth - 30, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    self.worksDesc.textLayout = layout;
    self.worksDesc.attributedText = text;
    [self.worksDesc setFrame:layout.textBoundingRect];
    
    // 时间
    [self.timeLine setFrame:workFrame.createTimeFrame];
    [self.timeLine setText:self.photoWork.postTime];
    
    // 点赞
    [self.likeBtn setFrame:workFrame.likeFrame];
    if(self.photoWork.hasLiked){
        [self.likeBtn select];
    }else{
        [self.likeBtn deselect];
    }
    
    // 点赞数
    [self.likeNum setFrame:workFrame.likeNumFrame];
    self.currentLikes = self.photoWork.likeNum;
    [self.likeNum setText:[NSString stringWithFormat:@"%d", self.currentLikes]];
    
    if([_photoWork.userid isEqualToString:[JJTokenManager shareInstance].getUserID]){
        [self.moreBtn setHidden:YES];
    }
    
    // 是否是自己
    if(self.photoWork.isYourWork){
        [_focusBtn setHidden:YES];
    }else{
        [_focusBtn setHidden:NO];
    }
    
    // 是否关注
    if(self.photoWork.hasFocused){
        self.focusBtn.selected = YES;
    }else{
        self.focusBtn.selected = NO;
    }
}

- (void)setupUI{
    //Container
    self.contentView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    //icon
    self.iconView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconView setBackgroundColor:[UIColor clearColor]];
    [self.iconView.layer setCornerRadius:20.0f];
    [self.iconView.layer setMasksToBounds:YES];
    [self.contentView addSubview:self.iconView];
    [self.iconView addTarget:self action:@selector(goToUserZone:) forControlEvents:UIControlEventTouchUpInside];
    
    //名字
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.contentView addSubview:self.nameLabel];
    
    //关注
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.focusBtn setBackgroundImage:[UIImage imageNamed:@"focusbk"] forState:UIControlStateNormal];
    [self.focusBtn setBackgroundImage:[UIImage imageNamed:@"unfocusbk"] forState:UIControlStateSelected];
    [self.focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.focusBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.focusBtn.layer setCornerRadius:8.0f];
    [self.focusBtn.layer setMasksToBounds:YES];
    [self.focusBtn addTarget:self action:@selector(clickFocusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.focusBtn];
    
    // 更多
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreBtn];
    
    //图片
    [self.contentView addSubview:self.workView];
    
    self.worksDesc = [YYLabel new];
    [self.contentView addSubview:self.worksDesc];
    
    //时间
    self.timeLine = [[UILabel alloc] init];
    [self.timeLine setTextAlignment:NSTextAlignmentLeft];
    [self.timeLine setTextColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1]];
    [self.timeLine setFont:[UIFont systemFontOfSize:12.0f]];
    [self.contentView addSubview:self.timeLine];
    
    //点赞
    self.likeBtn = [JJLikeButton coolButtonWithImage:[UIImage imageNamed:@"heart"] ImageFrame:CGRectMake(0, 0, 20, 20)];
    //图片选中状态颜色
    self.likeBtn.imageColorOn = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    //圆圈颜色
    self.likeBtn.circleColor = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    //线条颜色
    self.likeBtn.lineColor = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    [self.likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.likeBtn];
    
    //点赞数
    self.likeNum = [[UILabel alloc] init];
    [self.likeNum setTextAlignment:NSTextAlignmentCenter];
    [self.likeNum setTextColor:[UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1]];
    [self.likeNum setFont:[UIFont systemFontOfSize:13.0f]];
    [self.contentView addSubview:self.likeNum];
}


- (void)goToUserZone:(UIGestureRecognizer *)sender{
    [self.delegate goToUserZone];    
}

- (void)clickFocusBtn:(UIButton *)sender{
    NSLog(@"%s", __func__);
    sender.selected = !sender.selected;
    
    [_photoWork setHasFocused:sender.selected];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoFocus:) object:sender];
    [self performSelector:@selector(toDoFocus:) withObject:sender afterDelay:0.2f];
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
    
    [_photoWork setLikeNum:self.currentLikes];
    [_photoWork setHasLiked:sender.selected];
    
    [_likeNum setText:[NSString stringWithFormat:@"%ld", (long)self.currentLikes]];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoLike:) object:sender];
    [self performSelector:@selector(toDoLike:) withObject:sender afterDelay:0.2f];
}


//- (void)setWorksInfo:(HomeCubeModel *)detailInfo index:(NSIndexPath *)indexPath{
//    if(!detailInfo){
//        return;
//    }
//    
//    self.photoWork = detailInfo;
//    self.selectedIndex = indexPath;
//    [self.workView reloadData];
//    
//}

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
    
    _completeWorkView = [[CustomNewsBanner alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _completeWorkView.delegate = self;
    [_completeWorkView setProductsArray:[[NSMutableArray alloc] initWithArray:_photoWork.path]];
    
    [self addSubview:_completeWorkView];
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

// 更多
- (void)clickMoreBtn:(UIButton *)sender{
    // 自定义试图
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 65)];
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

// 关注
- (void)toDoFocus:(UIButton *)sender{
    if (sender.selected) {
        // 已关注
        [HttpRequestUtil JJ_BeginFocus:START_FOCUS_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID focusObj:self.photoWork.userid callback:^(NSDictionary *data, NSError *error) {
            if(error){
                return ;
            }
        }];
    } else {
        // 未关注
        [HttpRequestUtil JJ_CancelFocus:CANCEL_FOCUS_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID focusObj:self.photoWork.userid callback:^(NSDictionary *data, NSError *error) {
            if(error){
                return ;
            }
        }];
    }
}

// 点赞
- (void)toDoLike:(UIButton *)sender{
    if(sender.selected){
        [HttpRequestUtil JJ_INCREMENT_LIKECOUNT:POST_LIKE_REQUEST token:[JJTokenManager shareInstance].getUserToken photoId:self.photoWork.photoId userid:[JJTokenManager shareInstance].getUserID callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
            // token 过期
        }];
    }else{
        [HttpRequestUtil JJ_DECREMENT_LIKECOUNT:POST_UNLIKE_REQUEST token:[JJTokenManager shareInstance].getUserToken photoId:self.photoWork.photoId userid:[JJTokenManager shareInstance].getUserID callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
            // token 过期
        }];
    }
}

- (void)tipOffSelectedCallBack:(SelectedListModel *)model{
    __weak typeof(self) weakSelf = self;
    [HttpRequestUtil JJ_TipOff:TIPOFF_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID defendant:weakSelf.photoWork.userid photoid:weakSelf.photoWork.photoId reason:model.title callback:^(NSDictionary *data, NSError *error) {
        // 切到主线程上，解决不显示提示
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
        [HttpRequestUtil JJ_PullBlack:PULL_BLACK_REQUEST token:[JJTokenManager shareInstance].getUserToken userid:[JJTokenManager shareInstance].getUserID defendant:weakSelf.photoWork.userid callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
            
            if([[data objectForKey:@"result"] isEqualToString:@"1"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:JJ_PULL_BLACKLIST_SUCCESS object:nil];
                [SVProgressHUD showSuccessWithStatus:JJ_ADDBLACKLIST_SUCCESS];
                [SVProgressHUD dismissWithDelay:1.0f];
                [weakSelf.delegate pullToBlackList];
            }else{
                [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
                [SVProgressHUD dismissWithDelay:1.0f];
            }
        }];
    })
    .LeeShow();
}

#pragma -mark 加载头像
- (void)loadIconAvater:(NSString *)avatar{
    if(avatar.length == 0){
        [self.iconView setBackgroundImage:[UIImage imageNamed:@"userPlaceHold"] forState:UIControlStateNormal];
        return;
    }
    __weak typeof(self) weakself = self;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager diskImageExistsForURL:[NSURL URLWithString:avatar] completion:^(BOOL isInCache) {
        if(isInCache){
            NSString *key = [manager cacheKeyForURL:[NSURL URLWithString:avatar]];
            UIImage *image = [[manager imageCache] imageFromDiskCacheForKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.iconView setBackgroundImage:image forState:UIControlStateNormal];
            });
        }else{
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:avatar] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                NSString *key = [manager cacheKeyForURL:[NSURL URLWithString:avatar]];
                [manager saveImageToCache:image forURL:[NSURL URLWithString:key]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.iconView setBackgroundImage:image forState:UIControlStateNormal];
                });
            }];
        }
    }];
}

@end
