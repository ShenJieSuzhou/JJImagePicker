//
//  CandyFansViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/27.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "CandyFansViewController.h"
#import "FansModel.h"
#import "FansCell.h"
#import "OthersMainPageViewController.h"
#import "GlobalDefine.h"

#define CANDY_FANSCELL_IDENTIFIER @"CANDY_FANSCELL_IDENTIFIER"

@interface CandyFansViewController ()

@end

@implementation CandyFansViewController
@synthesize fansTableView = _fansTableView;
@synthesize fansList = _fansList;
@synthesize showTitle = _showTitle;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationItem setTitle:_showTitle];
    UIImage *img = [[UIImage imageNamed:@"in_pay_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    // 添加fanstable
    [self.view addSubview:self.fansTableView];
}

- (void)setCandyFansList:(NSMutableArray *)fansData{
    if(!fansData){
        return;
    }
    
    // 初始化fans用户
    self.fansList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [fansData count]; i++) {
        NSDictionary *fansinfo = [fansData objectAtIndex:i];
        NSString *userId = [fansinfo objectForKey:@"userId"];
        NSString *userName = [fansinfo objectForKey:@"name"];
        NSString *iconUrl = [fansinfo objectForKey:@"iconUrl"];
        FansModel *model = [[FansModel alloc] initWithUser:userId name:userName iconUrl:iconUrl];
        [self.fansList addObject:model];
    }
}

- (UITableView *)fansTableView{
    if(!_fansTableView){
        _fansTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, JJ_NAV_ST_H, self.view.frame.size.width, self.view.frame.size.height - JJ_NAV_ST_H) style:UITableViewStylePlain];
        _fansTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _fansTableView.delegate = self;
        _fansTableView.dataSource = self;
    }
    return _fansTableView;
}


- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [self.fansList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FansCell *fansCell = [tableView dequeueReusableCellWithIdentifier:CANDY_FANSCELL_IDENTIFIER];
    if(!fansCell){
        fansCell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CANDY_FANSCELL_IDENTIFIER];
        [fansCell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50.0f)];
    }
    
    FansModel *fansModel = [self.fansList objectAtIndex:indexPath.row];
    NSString *url = [fansModel iconUrl];
    NSString *name = [fansModel userName];
    [fansCell updateCell:url name:name];
    
    return fansCell;
}

// 跳转到粉丝详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FansModel *fansModel = [self.fansList objectAtIndex:indexPath.row];

    OthersMainPageViewController *fansZone = [OthersMainPageViewController new];
    [fansZone setFansModel:fansModel];
    [self.navigationController pushViewController:fansZone animated:YES];
}

@end
