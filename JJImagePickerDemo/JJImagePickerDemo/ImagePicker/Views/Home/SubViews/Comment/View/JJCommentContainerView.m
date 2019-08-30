//
//  JJCommentContainerView.m
//  CommectProj
//
//  Created by shenjie on 2019/8/13.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJCommentContainerView.h"
#import <Masonry/Masonry.h>
#import "JJCommentConstant.h"

@implementation JJCommentContainerView
@synthesize commentCount = _commentCount;
@synthesize commentBtn = _commentBtn;
@synthesize shareBtn = _shareBtn;
@synthesize sendBtn = _sendBtn;
@synthesize commentCountView = _commentCountView;
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    return self;
}

- (void)commonInitlization{
    [self setBackgroundColor:JJAlphaColor(234, 233, 235, 1)];
    [self.layer setBorderWidth:1.0];
    [self.layer setBorderColor:[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1].CGColor];
    [self.layer setMasksToBounds:YES];
    
    [self.commentBtn setTitle:@"快来说说你的感想吧" forState:UIControlStateNormal];
    
    [self addSubview:self.commentBtn];
//    [self addSubview:self.commentCountView];
//    [self addSubview:self.shareBtn];
    
    [self addSubview:self.sendBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.0f);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 30));
    }];
    
//    [self.commentCountView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.commentBtn.mas_right).offset(20.0f);
//        make.centerY.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];

//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.commentBtn.mas_right).offset(10.0f);
//        make.centerY.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentBtn.mas_right).offset(10.0f);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}

- (UIButton *)commentBtn{
    if(!_commentBtn){
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn addTarget:self action:@selector(commentBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_commentBtn setBackgroundColor:[UIColor whiteColor]];
        [_commentBtn setTitleColor:JJAlphaColor(194, 194, 194, 1) forState:UIControlStateNormal];
        [_commentBtn.titleLabel setFont:JJReguFont(12.0f)];
        _commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_commentBtn.layer setCornerRadius:10.0f];
        [_commentBtn.layer setBorderColor:[UIColor colorWithRed:249/255.0f green:249/255.0f blue:249/255.0f alpha:1].CGColor];
        [_commentBtn.layer setMasksToBounds:YES];
    }
    return _commentBtn;
}

- (CommentCountView *)commentCountView{
    if(!_commentCountView){
        _commentCountView = [[CommentCountView alloc] initWithFrame:CGRectZero];
    }
    return _commentCountView;
}

- (void)setCommentCount:(NSInteger)commentCount{
    _commentCount = commentCount;
    [self.commentCountView setCommentsNum:_commentCount];
}

- (UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (UIButton *)sendBtn{
    if(!_sendBtn){
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:JJAlphaColor(194, 194, 194, 1) forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:JJBlodFont(15.0f)];
    }
    return _sendBtn;
}

#pragma mark - 事件处理
- (void)commentBtnDidClicked:(UIButton *)sender{
    // 评论点击
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentContaninerBtnClickAction:)]) {
        [self.delegate commentContaninerBtnClickAction:self];
    }
}

@end
