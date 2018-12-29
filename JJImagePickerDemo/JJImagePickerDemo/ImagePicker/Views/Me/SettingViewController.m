//
//  SettingViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/11/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingViewCell.h"
#import "SecurityViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *settingTable;

@end

@implementation SettingViewController

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
    [title setText:@"设置"];
    [title setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [self.customNaviBar addSubview:title];
    
    [self.jjTabBarView setHidden:YES];
 
    [self.view addSubview:self.settingTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//懒加载
- (UITableView *)settingTable{
    if(!_settingTable){
        _settingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.customNaviBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.customNaviBar.frame.size.height) style:UITableViewStyleGrouped];
        _settingTable.delegate = self;
        _settingTable.dataSource = self;
        _settingTable.tableFooterView = [UIView new];
    }
    return _settingTable;
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SecurityViewController *securityView = [SecurityViewController new];
            [self presentViewController:securityView animated:YES completion:^{
                
            }];
        }
    }else if(indexPath.section == 2){
        
    }else if(indexPath.section == 3){
        
    }else if(indexPath.section == 4){
        
    }else if(indexPath.section == 5){
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 5;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return 1;
        case 4:
            return 1;
        case 5:
            return 1;
        case 6:
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
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"头像";
                CGFloat height = cell.frame.size.height;
                CGFloat width = self.view.frame.size.width;
                UIImageView *avater = [[UIImageView alloc] initWithFrame:CGRectMake(width - height - 10.0f, 5.0f,  height-10,  height-10)];
                [avater setImage:[UIImage imageNamed:@"filterDemo"]];
                [avater.layer setCornerRadius:(height-10)/2.0];
                avater.layer.masksToBounds = YES;
                [cell addSubview:avater];
            }
                break;
            case 1:
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = @"张三";
                break;
            case 2:
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = @"男";
                break;
            case 3:
                cell.textLabel.text = @"出生年月";
                cell.detailTextLabel.text = @"1991-01-17";
                break;
            case 4:
                cell.textLabel.text = @"个性签名";
                cell.detailTextLabel.text = @"哈哈哈哈哈哈啊哈";
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"账号与安全";
    }else if(indexPath.section == 2){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"消息通知";
//        CGFloat height = cell.frame.size.height;
//        CGFloat width = self.view.frame.size.width;
//        UISwitch * _switchFunc = [[UISwitch alloc] initWithFrame:CGRectMake(width - 50 - 20.0f, 2.0f,  50,  40)];
//        [_switchFunc setBackgroundColor:[UIColor whiteColor]];
//        [_switchFunc setOnTintColor:[UIColor blueColor]];
//        [_switchFunc setThumbTintColor:[UIColor whiteColor]];
//        _switchFunc.layer.cornerRadius = 15.5f;
//        _switchFunc.layer.masksToBounds = YES;
//        [_switchFunc addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//        [cell addSubview:_switchFunc];
    }else if(indexPath.section == 3){
        cell.textLabel.text = @"清除缓存";
    }else if(indexPath.section == 4){
        cell.textLabel.text = @"关于爱拍享";
    }else if(indexPath.section == 5){
        cell.accessoryType = UITableViewCellAccessoryNone;
        CGFloat height = cell.frame.size.height;
        CGFloat width = self.view.frame.size.width;
        UILabel *logOutT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        logOutT.textAlignment = NSTextAlignmentCenter;//文字居中
        [logOutT setTextColor:[UIColor redColor]];
        logOutT.text = @"退出登录";
        [cell addSubview:logOutT];
    }
    
    return cell;
}

@end
