//
//  OthersIDView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/27.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OthersIDInfoViewDelegate <NSObject>

- (void)showFansListCallback;

- (void)focusHerCandy:(UIButton *)sender;

- (void)goback;

@end


@interface OthersIDView : UIView

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIButton *concernBtn;
@property (nonatomic, strong) UIButton *goBackBtn;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel  *userName;

@property (nonatomic, strong) UIView *worksNumView;
@property (nonatomic, strong) UILabel *workTitle;
@property (nonatomic, strong) UILabel *workNum;

@property (nonatomic, strong) UIView *likesView;
@property (nonatomic, strong) UILabel *likesTitle;
@property (nonatomic, strong) UILabel *likesNum;

@property (nonatomic, strong) UIView *fansView;
@property (nonatomic, strong) UILabel *fansTitle;
@property (nonatomic, strong) UILabel *fansNum;

@property (copy, nonatomic) NSArray *personalBKs;


@property (weak, nonatomic) id<OthersIDInfoViewDelegate> delegate;

- (void)updateViewInfo:(UIImage *)avater name:(NSString *)name worksCount:(NSString *)worksCount fans:(NSString *)fansNum likes:(NSString *)likesCount hasFocused:(BOOL)hasFocused isSelf:(BOOL)isSelf;

@end


