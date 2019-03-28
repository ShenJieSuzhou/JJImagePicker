//
//  FansCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/28.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FansCell : UITableViewCell

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *seperateLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier;

- (void)updateCell:(NSString *)avatar name:(NSString *)name;

@end

