//
//  CandyFollowerViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/6.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "CandyFollowerViewController.h"
#import "FansModel.h"
#import "FansCell.h"
#import "OthersMainPageViewController.h"
#import "GlobalDefine.h"

#define CANDY_FOLLOWERCELL_IDENTIFIER @"CANDY_FOLLOWERCELL_IDENTIFIER"

@interface CandyFollowerViewController ()

@end

@implementation CandyFollowerViewController
@synthesize followerTableView = _followerTableView;
@synthesize followerList = _followerList;
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
    [self.view addSubview:self.followerTableView];
}

- (void)setCandyfollowersList:(NSMutableArray *)followersData{
    if(!followersData){
        return;
    }
    
    // 初始化fans用户
    self.followerList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [followersData count]; i++) {
        NSDictionary *fansinfo = [followersData objectAtIndex:i];
        NSString *userId = [fansinfo objectForKey:@"userId"];
        NSString *userName = [fansinfo objectForKey:@"name"];
        NSString *iconUrl = [fansinfo objectForKey:@"iconUrl"];
        FansModel *model = [[FansModel alloc] initWithUser:userId name:userName iconUrl:iconUrl];
        [self.followerList addObject:model];
    }
}

- (UITableView *)followerTableView{
    if(!_followerTableView){
        _followerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, JJ_NAV_ST_H, self.view.frame.size.width, self.view.frame.size.height - JJ_NAV_ST_H) style:UITableViewStylePlain];
        _followerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _followerTableView.delegate = self;
        _followerTableView.dataSource = self;
    }
    return _followerTableView;
}


- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.followerList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FansCell *fansCell = [tableView dequeueReusableCellWithIdentifier:CANDY_FOLLOWERCELL_IDENTIFIER];
    if(!fansCell){
        fansCell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CANDY_FOLLOWERCELL_IDENTIFIER];
        [fansCell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50.0f)];
    }
    
    FansModel *fansModel = [self.followerList objectAtIndex:indexPath.row];
    NSString *url = [fansModel iconUrl];
    NSString *name = [fansModel userName];
    [fansCell updateCell:url name:name];
    
    return fansCell;
}

// 跳转到粉丝详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FansModel *fansModel = [self.followerList objectAtIndex:indexPath.row];
    
    //请求粉丝信息
    
    
    OthersMainPageViewController *fansZone = [OthersMainPageViewController new];
    [fansZone setFansModel:fansModel];
    [self.navigationController pushViewController:fansZone animated:YES];
}

@end
