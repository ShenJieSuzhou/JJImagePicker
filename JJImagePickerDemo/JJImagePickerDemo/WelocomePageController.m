//
//  WelocomePageController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2019/5/8.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "WelocomePageController.h"

@interface WelocomePageController ()

@end

@implementation WelocomePageController
@synthesize guideScrollView = _guideScrollView;
@synthesize pageControl = _pageControl;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat JJScreenW = self.view.frame.size.width;
    CGFloat JJScreenH = self.view.frame.size.height;
    
    NSArray *imageArray = @[@"welcome_p1", @"welcome_p2", @"welcome_p3", @"welcome_p4"];
    
    // 设置引导视图的scrollview
    _guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, JJScreenW, JJScreenH)];
    [_guideScrollView setDelegate:self];
    [_guideScrollView setBackgroundColor:[UIColor whiteColor]];
    
    // 根据传入图片数组中的个数来计算UIScrollView的contentSize
    [_guideScrollView setContentSize:CGSizeMake(JJScreenW * 4, JJScreenH)];
    _guideScrollView.contentOffset = CGPointMake(0, 0);
    [_guideScrollView setBounces:NO];
    [_guideScrollView setPagingEnabled:YES];
    [_guideScrollView setShowsHorizontalScrollIndicator:NO];
    [_guideScrollView setShowsVerticalScrollIndicator:NO];
    if (@available(iOS 11.0, *)) {
        _guideScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.view addSubview:_guideScrollView];
    
    // 添加在引导视图上的多张引导图片
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(JJScreenW * i, 0, JJScreenW, JJScreenH)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *img = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [imageView setImage:img];
        [_guideScrollView addSubview:imageView];
        
        // 设置在最后一张图片上显示进入体验按钮
        if (i == imageArray.count - 1) {
            [imageView setUserInteractionEnabled:YES];
            UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(JJScreenW*0.3, JJScreenH*0.8, JJScreenW*0.4, JJScreenH*0.08)];
            [startButton setTitle:@"开始体验" forState:UIControlStateNormal];
            [startButton setTitleColor:[UIColor colorWithRed:164/255.0 green:201/255.0 blue:67/255.0 alpha:1.0] forState:UIControlStateNormal];
            [startButton.titleLabel setFont:[UIFont systemFontOfSize:21]];
            [startButton setBackgroundImage:[UIImage imageNamed:@"guideImage_button_backgound"] forState:UIControlStateNormal];
            [startButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:startButton];
        }
    }
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, JJScreenH - 80, JJScreenW, 30)];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.numberOfPages = imageArray.count;
    [self.view addSubview:_pageControl];
}

- (void)buttonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // pageControl 与 scrollView 联动
    CGFloat offsetWidth = scrollView.contentOffset.x;
    int pageNum = offsetWidth / [[UIScreen mainScreen] bounds].size.width;
    self.pageControl.currentPage = pageNum;
    if (scrollView.contentOffset.x >= scrollView.contentSize.width - self.view.bounds.size.width + 40) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
