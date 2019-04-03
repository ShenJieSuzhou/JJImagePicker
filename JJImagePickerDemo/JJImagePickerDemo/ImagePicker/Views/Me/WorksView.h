//
//  WorksView.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "Works.h"

@protocol WorksViewDelegate <NSObject>

- (void)goToWorksDetailViewCallback:(Works *)work;

- (void)worksUpPullFreshDataCallback;

@optional
- (void)publishWorksCallback;

@end

@interface WorksCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *sepearateL;

@end

@interface WorksView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UIButton *publishBtn;

@property (strong, nonatomic) UILabel *tips;

@property (strong, nonatomic) UICollectionView *worksCollection;

@property (strong, nonatomic) NSMutableArray *worksArray;

@property (weak, nonatomic) id<WorksViewDelegate> delegate;

- (void)updateWorksArray:(NSMutableArray *)works;

@end


