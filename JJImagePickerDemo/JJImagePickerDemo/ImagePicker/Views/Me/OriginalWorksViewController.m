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


@interface OriginalWorksViewController ()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *workView;
@property (strong, nonatomic) UIScrollView *worksInfoView;
@property (strong, nonatomic) YYLabel *worksDesc;
@property (strong, nonatomic) UILabel *timeLine;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) Works *photoWork;
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
    
    //    self.worksInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.customNaviBar.frame.size.height)];
    self.worksInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.customNaviBar.frame.size.height)];
    [self.worksInfoView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.worksInfoView];
    [self.worksInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.customNaviBar.mas_bottom).offset(10.0f);
    }];
    
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.iconView setBackgroundColor:[UIColor clearColor]];
    [self.iconView.layer setCornerRadius:self.iconView.frame.size.width/2];
    [self.iconView.layer setMasksToBounds:YES];
    [self.iconView setImage:[UIImage imageNamed:@"filter2"]];
    [self.worksInfoView addSubview:self.iconView];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
        make.left.top.mas_equalTo(self.worksInfoView).offset(10.0f);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.nameLabel setText:@"刘德华"];
    [self.worksInfoView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150.0f, 30.0f));
        make.left.equalTo(self.iconView.mas_right).offset(10.0f);
        make.centerY.mas_equalTo(self.iconView);
    }];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setTitle:@"..." forState:UIControlStateNormal];
    [self.shareBtn setBackgroundColor:[UIColor clearColor]];
    [self.worksInfoView addSubview:self.shareBtn];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40.0f, 30.0f));
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.worksInfoView).offset(self.view.frame.size.width - 50.0f);
    }];
    
    NSString *imageUrl = self.photoWork.path;
    UIImage *workImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    CGFloat width = workImage.size.width;
    CGFloat height = workImage.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat workVHeight = (screenWidth - 10) * (height/width);
    
    self.workView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - 10, workVHeight)];
    self.workView.contentMode = UIViewContentModeScaleAspectFit;
    [self.worksInfoView addSubview:self.workView];
    [self.workView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWidth - 10, workVHeight));
        make.left.equalTo(self.worksInfoView).offset(5.0f);
        make.top.equalTo(self.iconView.mas_bottom).offset(10.0f);
    }];
    [self.workView setImage:workImage];
    
    self.worksDesc = [YYLabel new];
    [self.worksInfoView addSubview:self.worksDesc];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"PI 兼容 UILabel 和 UITextView 支持高性能的异步排版和渲染Powerful text framework for iOS to display and edit rich text.Powerful text framework for iOS to display and edit rich text.Powerful text framework for iOS to display and edit rich text.PI 兼容 UILabel 和 UITextView 支持高性能的异步排版和渲染Powerful text framework for iOS to display and edit rich text.Powerful text framework for iOS to display and edit rich text.Powerful text framework for iOS to display and edit rich text."];

    text.yy_font = [UIFont systemFontOfSize:16];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 2;
    
    CGSize size = CGSizeMake(screenWidth - 10, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];

    self.worksDesc.textLayout = layout;
    self.worksDesc.attributedText = text;
    [self.worksDesc setFrame:layout.textBoundingRect];
    [self.worksDesc mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(layout.textBoundingSize.width, layout.textBoundingSize.height));
        make.left.equalTo(self.worksInfoView).offset(5.0f);
        make.top.equalTo(self.workView.mas_bottom).offset(10.0f);
    }];
    
    
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
