//
//  JJDetailsInfoHeaderView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/8/22.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNewsBanner.h"
#import "HomeCubeModel.h"
#import "reportView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import <YYText/YYLabel.h>
#import <YYText/NSAttributedString+YYText.h>
#import "UIScrollView+UITouch.h"
#import "JJThumbPhotoCell.h"
#import "JJTokenManager.h"
#import "OthersMainPageViewController.h"
#import "HttpRequestUrlDefine.h"
#import "HttpRequestUtil.h"
#import "JJLikeButton.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "GlobalDefine.h"
#import "MeViewController.h"
#import <LEEAlert/LEEAlert.h>
#import "SelectedListView.h"
#import "SelectedListModel.h"
#import "JJCommentDetailController.h"
#import "UIView+JJFrame.h"

@protocol JJDetailsInfoViewDelegate <NSObject>

- (void)goToUserZone;

- (void)pullToBlackList;
//
//- (void)focusHerCandy:(UIButton *)sender;
//
////- (void)clickMore;
//
//- (void)goback;

@end

@interface JJDetailsInfoHeaderView : UITableViewHeaderFooterView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CustomNewsBannerDelegate, reportViewDelegate, TipoffDelegate>

@property (strong, nonatomic) UIButton *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UICollectionView *workView;
@property (strong, nonatomic) YYLabel *worksDesc;
@property (strong, nonatomic) UILabel *timeLine;
@property (strong, nonatomic) UIButton *focusBtn;
@property (strong, nonatomic) UIButton *moreBtn;
@property (strong, nonatomic) JJLikeButton *likeBtn;
@property (strong, nonatomic) UILabel *likeNum;
@property (strong, nonatomic) NSMutableArray *photosArray;
@property (assign) NSInteger albumRows;
@property (assign) NSInteger albumColums;
@property (assign) BOOL isEven;
@property (strong, nonatomic) NSIndexPath *selectedIndex;
@property (assign) int currentLikes;
// 容器
@property (strong, nonatomic) HomeCubeModel *photoWork;

@property (nonatomic, weak) id<JJDetailsInfoViewDelegate> delegate;

// 大图模式
@property (strong, nonatomic) CustomNewsBanner *completeWorkView;

@property (assign) CGFloat height;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

- (void)setWorksInfo:(HomeCubeModel *)detailInfo index:(NSIndexPath *)indexPath;


@end

