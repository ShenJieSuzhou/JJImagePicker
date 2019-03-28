//
//  HomePublsihCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Works.h"
#import "HomeCubeModel.h"
#import "JJLikeButton.h"

@interface HomePublsihCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *hpImageView;
@property (strong, nonatomic) UILabel *imgDesclabel;
@property (strong, nonatomic) UIImageView *avaterView;
@property (strong, nonatomic) JJLikeButton *likeBtn;
@property (strong, nonatomic) UILabel *likeCount;

- (void)updateCell:(HomeCubeModel *)work;

@end

