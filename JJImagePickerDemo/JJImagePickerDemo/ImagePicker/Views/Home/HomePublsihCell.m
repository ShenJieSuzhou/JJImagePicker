//
//  HomePublsihCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "HomePublsihCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "HttpRequestUtil.h"
#import "HttpRequestUrlDefine.h"
#import "JJTokenManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "GlobalDefine.h"

@implementation HomePublsihCell
@synthesize hpImageView = _hpImageView;
@synthesize imgDesclabel = _imgDesclabel;
@synthesize avaterView = _avaterView;
@synthesize likeBtn = _likeBtn;
@synthesize likeCount = _likeCount;
@synthesize currentLikes = _currentLikes;
@synthesize photoID = _photoID;
@synthesize userID = _userID;


- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:2.0f];
        [self.layer setMasksToBounds:YES];
        
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    _hpImageView = [[UIImageView alloc] init];
    _hpImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_hpImageView setBackgroundColor:[UIColor whiteColor]];
    [_hpImageView.layer setCornerRadius:3.0f];
    [_hpImageView.layer setMasksToBounds:YES];
    [self addSubview:_hpImageView];
    
    _imgDesclabel = [[UILabel alloc] init];
    [_imgDesclabel setTextAlignment:NSTextAlignmentLeft];
    _imgDesclabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_imgDesclabel setText:@""];
    [_imgDesclabel setTextColor:[UIColor blackColor]];
    [_imgDesclabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];//Helvetica
    [self addSubview:_imgDesclabel];
    
    _avaterView = [[UIImageView alloc] init];
    [_avaterView setImage:[UIImage imageNamed:@"userPlaceHold"]];
    _avaterView.layer.cornerRadius = 12.5f;
    [_avaterView.layer setMasksToBounds:YES];
    [self addSubview:_avaterView];
    
    _likeBtn = [JJLikeButton coolButtonWithImage:[UIImage imageNamed:@"heart"] ImageFrame:CGRectMake(0, 0, 20, 20)];
    //图片选中状态颜色
    _likeBtn.imageColorOn = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    //圆圈颜色
    _likeBtn.circleColor = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    //线条颜色
    _likeBtn.lineColor = [UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1];
    [_likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeBtn];
    
    _likeCount = [[UILabel alloc] init];
    [_likeCount setText:@"0"];
    [_likeCount setTextAlignment:NSTextAlignmentCenter];
    [_likeCount setTextColor:[UIColor blackColor]];
    [_likeCount setFont:[UIFont systemFontOfSize:13.0f]];
    [self addSubview:_likeCount];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_hpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(5.0f);
        make.left.mas_equalTo(self.mas_left).offset(5.0f);
        make.right.mas_equalTo(self.mas_right).offset(-5.0f);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-80.0f);
    }];
    
    [_imgDesclabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 15, 30.0f));
        make.top.mas_equalTo(self.hpImageView.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.mas_left).offset(10.0f);
        make.right.mas_equalTo(self.mas_right).offset(-5.0f);
    }];
    
    [_avaterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.mas_left).offset(10.0f);
    }];

    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_bottom).offset(5.0f);
        make.right.mas_equalTo(self.mas_right).offset(-50.0f);
    }];

    [_likeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 20.0f));
        make.top.mas_equalTo(self.imgDesclabel.mas_bottom).offset(5.0f);
        make.left.mas_equalTo(self.likeBtn.mas_right).offset(5.0f);
        make.right.mas_equalTo(self.mas_right).offset(5.0f);
    }];
}

// 用户点赞操作
- (void)clickLikeBtn:(JJLikeButton *)sender{
    NSLog(@"%s", __func__);
    if (sender.selected) {
        //未选中状态
        [sender deselect];
        self.currentLikes = self.currentLikes - 1;
    } else {
        //选中状态
        [sender select];
        self.currentLikes = self.currentLikes + 1;
    }
    [_likeCount setText:[NSString stringWithFormat:@"%ld", (long)self.currentLikes]];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoSomething:) object:sender];
    [self performSelector:@selector(toDoSomething:) withObject:sender afterDelay:0.2f];
}

// 将数据上传服务器
- (void)toDoSomething:(UIButton *)button{
    if(button.selected){
        [HttpRequestUtil JJ_INCREMENT_LIKECOUNT:POST_LIKE_REQUEST token:[JJTokenManager shareInstance].getUserToken photoId:self.photoID userid:self.userID callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
        }];
    }else{
        [HttpRequestUtil JJ_DECREMENT_LIKECOUNT:POST_UNLIKE_REQUEST token:[JJTokenManager shareInstance].getUserToken photoId:self.photoID userid:self.userID callback:^(NSDictionary *data, NSError *error) {
            if(error){
                [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
                [SVProgressHUD dismissWithDelay:1.0f];
                return ;
            }
        }];
    }
}

- (void)updateCell:(HomeCubeModel *)work{
    NSString *showedImgUrl = [work.path objectAtIndex:0];
    NSString *avater = work.iconUrl;
    NSString *desc = work.work;
    NSString *likeCount = work.likeNum;
    self.currentLikes = likeCount.integerValue;
    self.photoID = work.photoId;
    self.userID = work.userid;
    
    [_hpImageView sd_setImageWithURL:[NSURL URLWithString:showedImgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [_imgDesclabel setText:desc];
    [_avaterView sd_setImageWithURL:[NSURL URLWithString:avater] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    [_likeCount setText:likeCount];
}


@end
