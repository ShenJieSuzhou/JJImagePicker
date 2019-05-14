//
//  SecurityViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "SecurityViewController.h"
#import "JJTokenManager.h"
#import "LoginPWDViewController.h"
#import "BindPhoneViewController.h"
#import "GlobalDefine.h"

@interface SecurityViewController ()<UITableViewDelegate,UITableViewDataSource,SetPwdDelegate>

@property (strong, nonatomic) UITableView *securityTable;

@end

@implementation SecurityViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"帐号安全"];
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self.view addSubview:self.securityTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//懒加载
- (UITableView *)securityTable{
    if(!_securityTable){
        _securityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, JJ_NAV_ST_H, self.view.frame.size.width, self.view.frame.size.height - JJ_NAV_ST_H) style:UITableViewStyleGrouped];
        _securityTable.delegate = self;
        _securityTable.dataSource = self;
        _securityTable.tableFooterView = [UIView new];
    }
    return _securityTable;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        LoginPWDViewController *loginPWDCtrl = [[LoginPWDViewController alloc] initWithNibName:@"LoginPWDViewController" bundle:nil];
        loginPWDCtrl.isFreshMan = NO;
        loginPWDCtrl.delegate = self;
        [self.navigationController pushViewController:loginPWDCtrl animated:YES];
    }else if(indexPath.section == 1){
        BindPhoneViewController *bindViewCtrl = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
        [self.navigationController pushViewController:bindViewCtrl animated:YES];
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
    
    static NSString *CellIdentifier = @"SECURTY_Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"登录密码";
                cell.detailTextLabel.text = @"更改";
                break;
        }
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"手机号";
        if([JJTokenManager shareInstance].getUserMobile.length == 0){
            cell.detailTextLabel.text = @"未绑定";
        }else{
            cell.detailTextLabel.text = @"已绑定";
        }
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"微信";
        cell.detailTextLabel.text = @"已绑定";
    }
    
    return cell;
}

- (void)setPwdSuccessCallBack:(LoginPWDViewController *)viewCtl{
//    UITableViewCell *cell = [self.securityTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    if(!cell){
//        return;
//    }
//    cell.detailTextLabel.text = @"更改";
    [viewCtl.navigationController popViewControllerAnimated:YES];
}

@end
