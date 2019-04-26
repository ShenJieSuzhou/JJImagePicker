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

@interface SecurityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *securityTable;

@end

@implementation SecurityViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNaviBar setLeftBtn:cancelBtn withFrame:CGRectMake(20.0f, 30.0f, 30.0f, 30.0f)];
    
    CGFloat w = self.view.frame.size.width;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((w - 200)/2, 25.0f, 200.0f, 40.0f)];
    [title setText:@"帐号安全"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];
    
    [self.jjTabBarView setHidden:YES];
    
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
        _securityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.customNaviBar.frame.size.height) style:UITableViewStyleGrouped];
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
        [self presentViewController:loginPWDCtrl animated:YES completion:^{
            
        }];
    }else if(indexPath.section == 1){
        BindPhoneViewController *bindViewCtrl = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
        [self presentViewController:bindViewCtrl animated:YES completion:^{
            
        }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
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
                if([JJTokenManager shareInstance].getPassword.length == 0){
                    cell.detailTextLabel.text = @"未设置";
                }else{
                    cell.detailTextLabel.text = @"更改";
                }
                break;
        }
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"绑定手机号";
        if([JJTokenManager shareInstance].getUserMobile.length == 0){
            cell.detailTextLabel.text = @"未绑定";
        }else{
            cell.detailTextLabel.text = [JJTokenManager shareInstance].getUserMobile;
        }
    }
    
    return cell;
}

@end
