//
//  JJCollectionReusableView.h
//  testTag
//
//  Created by silicon on 2018/10/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *leftImg;

- (void)setTitle:(NSString *)title image:(UIImage *)img;

@end
