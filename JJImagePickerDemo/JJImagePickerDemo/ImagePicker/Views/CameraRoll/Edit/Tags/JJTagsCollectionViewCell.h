//
//  JJTagsCollectionViewCell.h
//  testTag
//
//  Created by silicon on 2018/10/4.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"

@interface JJTagsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *tagText;

- (void)updateCell:(TagModel *)tag;

@end
