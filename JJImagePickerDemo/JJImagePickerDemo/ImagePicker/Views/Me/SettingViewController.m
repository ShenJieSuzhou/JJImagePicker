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
#import "EditAvaterViewController.h"
#import "EditNameViewController.h"
#import "EditAgendViewController.h"
#import "JJDatePicker.h"
#import "AboutAppViewController.h"
#import "JJTokenManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HttpRequestUrlDefine.h"
#import "HttpRequestUtil.h"
#import "GlobalDefine.h"
#import "PushUtil.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,JJDatePickerDelegate,EditAgendDelegate,EditNameDelegate,EditAvaterDelegate>

@property (strong, nonatomic) UITableView *settingTable;

@end

@implementation SettingViewController
//@synthesize datePicker = _datePicker;
@synthesize delegate = _delegate;

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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                NSString *iconUrl = [JJTokenManager shareInstance].getUserAvatar;
                EditAvaterViewController *editAvater = [EditAvaterViewController new];
                editAvater.delegate = self;
                [editAvater setAvaterUrl:iconUrl];
                [self.navigationController pushViewController:editAvater animated:YES];
            }
                break;
            case 1:{
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                NSString *name = cell.detailTextLabel.text;
                EditNameViewController *editNameView = [EditNameViewController new];
                editNameView.delegate = self;
                [editNameView setNickName:name];
                [self.navigationController pushViewController:editNameView animated:YES];
            }
                break;
            case 2:{
                EditAgendViewController *agendaView = [EditAgendViewController new];
                agendaView.delegate = self;
                [self.navigationController pushViewController:agendaView animated:YES];
            }
                break;
            case 3:{
                JJDatePicker *datePicker = [[JJDatePicker alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
                datePicker.delegate = self;
                [datePicker setCenter:self.view.center];
                [self.settingTable setUserInteractionEnabled:NO];
                [self.view addSubview:datePicker];
            }
                break;
            case 4:
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SecurityViewController *securityView = [SecurityViewController new];
            [self.navigationController pushViewController:securityView animated:YES];
        }
    }else if(indexPath.section == 2){
        
    }else if(indexPath.section == 3){
        
    }else if(indexPath.section == 4){
        AboutAppViewController *aboutView = [AboutAppViewController new];
        [self.navigationController pushViewController:aboutView animated:YES];
    }else if(indexPath.section == 5){
        //通知服务器下线
        [[JJTokenManager shareInstance] removeAllUserInfo];
        if([_delegate respondsToSelector:@selector(userLoginOutCallBack:)]){
            [_delegate userLoginOutCallBack:self];
        }        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

#pragma mark JJDatePickerDelegate
- (void)cancelBtnClickCallBack:(JJDatePicker *)picker{
     [self.settingTable setUserInteractionEnabled:YES];
    [picker removeFromSuperview];
}

- (void)saveBtnClickCallBack:(JJDatePicker *)picker date:(NSString *)date{
     [self.settingTable setUserInteractionEnabled:YES];
    [picker removeFromSuperview];
    
    UITableViewCell *cell = [self.settingTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if(!cell){
        return;
    }
    cell.detailTextLabel.text = date;
    [[JJTokenManager shareInstance] saveUserBirth:date];
}

#pragma mark EditAvaterDelegate
- (void)EditAvaterSuccessCallBack:(NSString *)imageUrl localImg:(UIImage *)img viewControl:(EditAvaterViewController *)editViewCtrl{
    [editViewCtrl.navigationController popViewControllerAnimated:YES];
    
    [HttpRequestUtil JJ_UpdateUserAvatar:UPDATE_AVATAR_REQUEST token:[JJTokenManager shareInstance].getUserToken avatar:imageUrl userid:[JJTokenManager shareInstance].getUserID callback:^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:1.0f];
            return ;
        }
    
        if([[data objectForKey:@"result"] isEqualToString:@"1"]){
            [[JJTokenManager shareInstance] saveUserAvatar:imageUrl];
            UITableViewCell *cell = [self.settingTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            if(!cell){
                return;
            }
            
            UIImageView *avaterView = (UIImageView *) [cell viewWithTag:190];
            [avaterView setImage:img];
            [SVProgressHUD showSuccessWithStatus:JJ_MODIFIY_SUCCESS];
            [SVProgressHUD dismissWithDelay:1.0f];
        }else{
            [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
            [SVProgressHUD dismissWithDelay:1.0f];
        }
    }];
}

#pragma mark EditAgendDelegate
- (void)EditAgendSucceedCallBack:(int)agend viewController:(EditAgendViewController *)viewCtrl{
    [viewCtrl.navigationController popViewControllerAnimated:YES];
    
    NSString *value = @"";
    if(agend == 0){
        value = @"男生";
    }else if(agend == 1){
        value = @"女生";
    }else if(agend == 2){
        value = @"蒙面侠";
    }
    
    UITableViewCell *cell = [self.settingTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if(!cell){
        return;
    }
    cell.detailTextLabel.text = value;
    [[JJTokenManager shareInstance] saveUserGender:[NSNumber numberWithInt:agend]];
}

#pragma mark EditNameDelegate
- (void)EditNameSuccessCallBack:(NSString *)name viewController:(EditNameViewController *)viewCtl{
    [viewCtl.navigationController popViewControllerAnimated:YES];
    
    UITableViewCell *cell = [self.settingTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if(!cell){
        return;
    }
    cell.detailTextLabel.text = name;
    [[JJTokenManager shareInstance] saveUserName:name];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
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
                avater.tag = 190;
                NSString *iconUrl = [JJTokenManager shareInstance].getUserAvatar;
                [avater sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"userPlaceHold"]];
                [avater.layer setCornerRadius:(height-10)/2.0];
                avater.layer.masksToBounds = YES;
                [cell addSubview:avater];
            }
                break;
            case 1:
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = [JJTokenManager shareInstance].getUserName;
                break;
            case 2:{
                cell.textLabel.text = @"性别";
                NSString *value = @"";
                if([[JJTokenManager shareInstance].getUserGender isEqualToString:@"0"]){
                    value = @"男生";
                }else if([[JJTokenManager shareInstance].getUserGender isEqualToString:@"1"]){
                    value = @"女生";
                }else if([[JJTokenManager shareInstance].getUserGender isEqualToString:@"2"]){
                    value = @"蒙面侠";
                }
                cell.detailTextLabel.text = value;
                
            }
                break;
            case 3:
                cell.textLabel.text = @"出生年月";
                cell.detailTextLabel.text = [JJTokenManager shareInstance].getUserBirth;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"账号与安全";
    }else if(indexPath.section == 2){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"消息通知";

        CGFloat width = self.view.frame.size.width;
        CGFloat swiBtnHeight = 40.0f;
        CGFloat swiBtnWidth = 50.0f;
        UISwitch *switchFunc = [[UISwitch alloc] initWithFrame:CGRectMake(width - swiBtnWidth - 20.0f, 5.0f,  swiBtnWidth,  swiBtnHeight)];
        [switchFunc setOnTintColor:[UIColor colorWithRed:240/255.0f green:76/255.0f blue:64/255.0f alpha:1]];
        [switchFunc addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        BOOL bUserPushNotificationEnabled = [[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone ? YES : NO;
        [switchFunc setOn:bUserPushNotificationEnabled];
        [cell addSubview:switchFunc];
        
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

/**
 switch 开关

 @param sender 控件
 */
- (void)switchAction:(UISwitch *)sender{
    
    if(!sender.on){
        [PushUtil removeAllLocalNotifications];
        [sender setOn:NO];
        return;
    }
    
    [sender setOn:YES];
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    [PushUtil registerLocalNotification];
}


/**
 更新用户信息
 */
- (void)updateUserInfo{
    
}


@end
