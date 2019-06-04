//
//  UserItemsViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "UserItemsViewController.h"
#import "GlobalDefine.h"
#import "MyWebViewController.h"
#import "ContactUsViewController.h"


@interface UserItemsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *userItemsTable;
@end

@implementation UserItemsViewController
@synthesize userItemsTable = _userItemsTable;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"服务条款"];
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self.view addSubview:self.userItemsTable];
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//懒加载
- (UITableView *)userItemsTable{
    if(!_userItemsTable){
        _userItemsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, JJ_NAV_ST_H, self.view.frame.size.width, self.view.frame.size.height - JJ_NAV_ST_H) style:UITableViewStyleGrouped];
        _userItemsTable.delegate = self;
        _userItemsTable.dataSource = self;
        _userItemsTable.tableFooterView = [UIView new];
    }
    return _userItemsTable;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        MyWebViewController *myWebView = [MyWebViewController new];
        [myWebView.navigationItem setTitle:@"用户服务协议"];
        [myWebView loadRequest:@"http://www.candyart.top/userItem"];
        [self.navigationController pushViewController:myWebView animated:YES];
    }else if(indexPath.section == 1){
        MyWebViewController *myWebView = [MyWebViewController new];
        [myWebView.navigationItem setTitle:@"隐私政策"];
        [myWebView loadRequest:@"http://www.candyart.top/privacy"];
        [self.navigationController pushViewController:myWebView animated:YES];
    }else if(indexPath.section == 2){
        ContactUsViewController *contactUs = [ContactUsViewController new];
        [self.navigationController pushViewController:contactUs animated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 1;
        default:
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"UserItem_Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"用户服务协议";
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"隐私政策";
    }else if (indexPath.section == 2) {
        cell.textLabel.text = @"联系客服";
    }
    
    return cell;
}

@end

