//
//  OriginalWorksViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/1/15.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "OriginalWorksViewController.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <YYText/YYLabel.h>
#import <YYText/NSAttributedString+YYText.h>
#import "UIScrollView+UITouch.h"

@interface OriginalWorksViewController ()
//@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *workView;
@property (strong, nonatomic) UIScrollView *worksInfoView;
@property (strong, nonatomic) YYLabel *worksDesc;
@property (strong, nonatomic) UILabel *timeLine;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) Works *photoWork;
@property (strong, nonatomic) UIButton *likeBtn;
@property (strong, nonatomic) UILabel *likeNum;
@end

@implementation OriginalWorksViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI{
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    CGFloat w = self.view.frame.size.width;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((w - 200)/2, 25.0f, 200.0f, 40.0f)];
    [title setText:@"作品详情"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];
    [self.jjTabBarView setHidden:YES];
    
    //滚动视图
    self.worksInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height + 10.0f, self.view.frame.size.height, self.view.frame.size.height - self.customNaviBar.frame.size.height - 10.0f)];
    self.worksInfoView.showsHorizontalScrollIndicator = NO;
    self.worksInfoView.alwaysBounceVertical = YES;
    [self.worksInfoView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.worksInfoView];
    
    //icon
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.iconView setBackgroundColor:[UIColor clearColor]];
    [self.iconView.layer setCornerRadius:self.iconView.frame.size.width/2];
    [self.iconView.layer setMasksToBounds:YES];
    [self.iconView setImage:[UIImage imageNamed:@"filter2"]];
    [self.worksInfoView addSubview:self.iconView];
    
    //名字
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.nameLabel setText:@"刘德华"];
    [self.worksInfoView addSubview:self.nameLabel];
    
    //关注
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.shareBtn setBackgroundColor:[UIColor clearColor]];
    [self.shareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.shareBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.shareBtn.layer setBorderWidth:1.0f];
    [self.shareBtn.layer setBorderColor:[UIColor redColor].CGColor];
    [self.shareBtn.layer setCornerRadius:8.0f];
    [self.shareBtn.layer setMasksToBounds:YES];
    [self.shareBtn addTarget:self action:@selector(clickConcernBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.worksInfoView addSubview:self.shareBtn];
    
    //图片
    NSString *imageUrl = self.photoWork.path;
    UIImage *workImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    CGFloat width = workImage.size.width;
    CGFloat height = workImage.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat workVHeight = (screenWidth - 10) * (height/width);
    self.workView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - 10, workVHeight)];
    [self.workView setImage:workImage];
    self.workView.contentMode = UIViewContentModeScaleAspectFit;
    [self.worksInfoView addSubview:self.workView];
    
    //描述
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"今天的天气这心好！\r\n 我是天才"];
    
    text.yy_font = [UIFont systemFontOfSize:15.0f];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 2;
    
    CGSize size = CGSizeMake(screenWidth - 30, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    self.worksDesc = [YYLabel new];
    self.worksDesc.textLayout = layout;
    self.worksDesc.attributedText = text;
    [self.worksDesc setFrame:layout.textBoundingRect];
    [self.worksInfoView addSubview:self.worksDesc];
    
    //时间
    self.timeLine = [[UILabel alloc] init];
    [self.timeLine setTextAlignment:NSTextAlignmentLeft];
    [self.timeLine setTextColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1]];
    [self.timeLine setFont:[UIFont systemFontOfSize:12.0f]];
    [self.timeLine setText:@"2019-01-01"];
    [self.worksInfoView addSubview:self.timeLine];
    
    //点赞
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setBackgroundColor:[UIColor clearColor]];
    [self.likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"like_sel"] forState:UIControlStateSelected];
    [self.likeBtn addTarget:self action:@selector(clickLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.worksInfoView addSubview:self.likeBtn];
    
    //点赞数
    self.likeNum = [[UILabel alloc] init];
    [self.likeNum setTextAlignment:NSTextAlignmentCenter];
    [self.likeNum setTextColor:[UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1]];
    [self.likeNum setFont:[UIFont systemFontOfSize:12.0f]];
    [self.likeNum setText:@"9999"];
    [self.worksInfoView addSubview:self.likeNum];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        make.left.top.mas_equalTo(self.worksInfoView).offset(10.0f);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150.0f, 30.0f));
        make.left.equalTo(self.iconView.mas_right).offset(10.0f);
        make.centerY.mas_equalTo(self.iconView);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45.0f, 25.0f));
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.worksInfoView).offset(self.view.frame.size.width - 60.0f);
    }];
    
    [self.workView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWidth - 10, workVHeight));
        make.left.equalTo(self.worksInfoView).offset(5.0f);
        make.top.equalTo(self.iconView.mas_bottom).offset(10.0f);
    }];
    
    [self.worksDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(layout.textBoundingSize.width, layout.textBoundingSize.height));
        make.left.equalTo(self.worksInfoView).offset(15.0f);
        make.top.equalTo(self.workView.mas_bottom).offset(10.0f);
    }];
    
    
    [self.timeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150.0f, 20.0f));
        make.left.equalTo(self.worksInfoView).offset(15.0f);
        make.top.equalTo(self.worksDesc.mas_bottom).offset(20.0f);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25.0f, 23.0f));
        make.centerY.mas_equalTo(self.timeLine);
        make.right.mas_equalTo(self.workView).offset(-50.0f);
        make.bottom.equalTo(self.worksInfoView).offset(-50.0f);
    }];
    
    [self.likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 20.0f));
        make.right.equalTo(self.workView);
        make.centerY.equalTo(self.likeBtn);
    }];
}

- (void)clickConcernBtn:(UIButton *)sender{
    NSLog(@"111111");
}

- (void)clickLikeBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        
    }
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setWorksInfo:(Works *)workModel{
    if(!workModel){
        return;
    }
    
    self.photoWork = workModel;
}

@end
