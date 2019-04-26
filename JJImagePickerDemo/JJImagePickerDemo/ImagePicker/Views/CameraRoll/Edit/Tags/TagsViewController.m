//
//  TagsViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "TagsViewController.h"
#define TEXTBTN_WH 80.0f
#define LOCATION_WH 80.0f
#define BRANDS_WH 100.0f
#define PADDING 30.0f


@interface TagsViewController ()

@end

@implementation TagsViewController
@synthesize classifyView = _classifyView;
@synthesize tagsCategoryView = _tagsCategoryView;
@synthesize textTagBtn = _textTagBtn;
@synthesize brandsTagBtn = _brandsTagBtn;
@synthesize locationTagBtn = _locationTagBtn;
@synthesize tagClassification = _tagClassification;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    self.classifyView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.classifyView setBackgroundColor:[UIColor clearColor]];

    self.brandsTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.brandsTagBtn setBackgroundColor:[UIColor blackColor]];
    [self.brandsTagBtn setTitle:@"名牌" forState:UIControlStateNormal];
    [self.brandsTagBtn setFrame:CGRectMake(0, 0, BRANDS_WH, BRANDS_WH)];
    self.brandsTagBtn.center = self.view.center;
    [self.brandsTagBtn addTarget:self action:@selector(tagBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.brandsTagBtn];
    
    self.textTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.textTagBtn setBackgroundColor:[UIColor blackColor]];
    [self.textTagBtn setTitle:@"A" forState:UIControlStateNormal];
    [self.textTagBtn setFrame:CGRectMake(0, 0, TEXTBTN_WH, TEXTBTN_WH)];
    self.textTagBtn.center = CGPointMake(self.view.center.x - BRANDS_WH/2 - TEXTBTN_WH/2 - PADDING, self.view.center.y);
    [self.textTagBtn addTarget:self action:@selector(tagBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.textTagBtn];
    
    self.locationTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.locationTagBtn setBackgroundColor:[UIColor blackColor]];
    [self.locationTagBtn setTitle:@"地点" forState:UIControlStateNormal];
    [self.locationTagBtn setFrame:CGRectMake(0, 0, LOCATION_WH, LOCATION_WH)];
    self.locationTagBtn.center = CGPointMake(self.view.center.x + BRANDS_WH/2 + TEXTBTN_WH/2 + PADDING, self.view.center.y);
    [self.locationTagBtn addTarget:self action:@selector(tagBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.locationTagBtn];
}

- (void)tagBtnclicked:(UIButton *)sender{
    if(sender == self.textTagBtn){
        self.tagClassification = TAG_TEXT;
    }else if(sender == self.brandsTagBtn){
        self.tagClassification = TAG_BRANDS;
    }else if(sender == self.locationTagBtn){
        self.tagClassification = TAG_LOCATION;
    }
}

- (TagCategoryView *)tagsCategoryView{
    if(!_tagsCategoryView){
        _tagsCategoryView = [[TagCategoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    
    return _tagsCategoryView;
}

@end
