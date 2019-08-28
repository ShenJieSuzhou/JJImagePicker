//
//  JJDetailsInfoFooterView.m
//  JJImagePickerDemo
//
//  Created by silicon on 2019/8/25.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJDetailsInfoFooterView.h"
#import <Masonry/Masonry.h>
#import "JJCommentConstant.h"

@implementation JJDetailsInfoFooterView
@synthesize commentTitle = _commentTitle;
@synthesize seperateLine = _seperateLine;
@synthesize noCommentV = _noCommentV;


+ (instancetype)footerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"detailsFooter";
    JJDetailsInfoFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (footer == nil) {
        // 缓存池中没有, 自己创建
        footer = [[self alloc] initWithReuseIdentifier:ID];
    }
    return footer;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 初始化
        [self setup];
        
        // 创建自控制器
        [self setupSubViews];
        
        // 布局子控件
        [self makeSubViewsConstraints];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    return self;
}


- (void)setup{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubViews{
    // 分割线
    self.seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, 5)];
    [self.seperateLine setBackgroundColor:[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f]];
    [self.contentView addSubview:self.seperateLine];
    
    self.commentTitle = [[YYLabel alloc] initWithFrame:CGRectMake(10, 20, 100, 50)];
    self.commentTitle.text = @"精彩评论";
    self.commentTitle.font = JJFont(16, YES);
    self.commentTitle.textColor = [UIColor blackColor];
    self.commentTitle.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.commentTitle];
    
    self.noCommentV = [[UIView alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 300.0f)];
    [self.noCommentV setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat noCommentW = self.noCommentV.frame.size.width;
    CGFloat noCommentH = self.noCommentV.frame.size.height;
    UIImageView *noComments = [[UIImageView alloc] initWithFrame:CGRectMake((noCommentW - 100)/2, (noCommentH - 200)/2, 100.0f, 100.0f)];
    [noComments setImage:[UIImage imageNamed:@"noComments"]];
    [self.noCommentV addSubview:noComments];
    
    UILabel *noMore = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noComments.frame) + 5, noCommentW, 30)];
    [noMore setText:@"暂无评论 快来抢沙发"];
    [noMore setTextAlignment:NSTextAlignmentCenter];
    [noMore setFont:JJBlodFont(12.0f)];
    [noMore setTextColor:JJAlphaColor(101,101,101,1)];
    [self.noCommentV addSubview:noMore];
    [self.contentView addSubview:self.noCommentV];
}

#pragma mark - 布局子控件
- (void)makeSubViewsConstraints{
//    [self.commentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 50));
//        make.left.top.bottom.mas_equalTo(self.contentView);
//    }];
}

@end
