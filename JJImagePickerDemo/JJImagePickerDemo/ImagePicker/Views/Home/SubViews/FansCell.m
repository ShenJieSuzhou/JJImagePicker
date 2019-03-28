//
//  FansCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/28.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "FansCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FansCell
@synthesize avatarView = _avatarView;
@synthesize nameLabel = _nameLabel;
@synthesize seperateLine = _seperateLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier{
    if(self = [super initWithStyle:style reuseIdentifier:identifier]){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    _nameLabel = [[UILabel alloc] init];
    [_nameLabel setTextAlignment:NSTextAlignmentLeft];
    [_nameLabel setText:@""];
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_nameLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];//Helvetica
    [self addSubview:_nameLabel];
    
    _avatarView = [[UIImageView alloc] init];
    [_avatarView setContentMode:UIViewContentModeScaleAspectFill];
    [_avatarView setImage:[UIImage imageNamed:@"userPlaceHold"]];
    _avatarView.layer.cornerRadius = 20.f;
    [_avatarView.layer setMasksToBounds:YES];
    [self addSubview:_avatarView];
    
    _seperateLine = [[UIImageView alloc] init];
    [_seperateLine setBackgroundColor:[UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.0f]];
    [self addSubview:_seperateLine];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        make.top.mas_equalTo(self.mas_top).offset(5.0f);
        make.left.mas_equalTo(self.mas_left).offset(10.0f);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 80, 30.0f));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.avatarView.mas_right).offset(10.0f);
    }];
    
    //分割
    [self.seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 20, 1));
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1.0f);
        make.left.mas_equalTo(self.mas_left).offset(10.0f);
    }];
}

- (void)updateCell:(NSString *)avatar name:(NSString *)name{
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"userPlaceHold"]];
    [_nameLabel setText:name];
}

@end
