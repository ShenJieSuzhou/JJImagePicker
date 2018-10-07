//
//  JJTagsCollectionViewCell.h
//  testTag
//
//  Created by silicon on 2018/10/4.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubTagModel.h"

@interface JJTagsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *tagText;

- (void)updateCell:(SubTagModel *)tag;

@end
