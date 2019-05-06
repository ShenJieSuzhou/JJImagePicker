//
//  EditAgendViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "EditAgendViewController.h"
#import "JJTokenManager.h"
#import "HttpRequestUrlDefine.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HttpRequestUtil.h"
#import "GlobalDefine.h"

@interface EditAgendViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView *agendTable;
@property (assign) NSInteger currentRow;
@property (strong, nonatomic) NSString *gender;
@end

@implementation EditAgendViewController
@synthesize agendTable = _agendTable;
@synthesize delegate = _delegate;
@synthesize gender = _gender;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    
    [self.navigationItem setTitle:@"性别"];
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(clickCancelBtn:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickSaveBtn:)];
    [self.navigationItem setRightBarButtonItem:rightItem];

    [self.view addSubview:self.agendTable];
}

//懒加载
- (UITableView *)agendTable{
    if(!_agendTable){
        _agendTable = [[UITableView alloc] initWithFrame:CGRectMake(0, JJ_NAV_ST_H, self.view.frame.size.width, self.view.frame.size.height - JJ_NAV_ST_H) style:UITableViewStylePlain];
        _agendTable.delegate = self;
        _agendTable.dataSource = self;
        _agendTable.tableFooterView = [UIView new];
    }
    return _agendTable;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentRow = indexPath.row;
    [tableView reloadData];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"AGENDA_CELL";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType  = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"男生";
                break;
            case 1:
                cell.textLabel.text = @"女生";
                break;
            case 2:
                cell.textLabel.text = @"蒙面侠";
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)clickCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickSaveBtn:(UIButton *)sender{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    __weak typeof(self)weakSelf = self;
    [HttpRequestUtil JJ_UpdateUserGender:UPDATE_GENDER_REQUEST token:[JJTokenManager shareInstance].getUserToken gender:(int)self.currentRow userid:[JJTokenManager shareInstance].getUserID callback:^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            [SVProgressHUD showErrorWithStatus:JJ_NETWORK_ERROR];
            [SVProgressHUD dismissWithDelay:2.0f];
            return ;
        }else if([[data objectForKey:@"result"] isEqualToString:@"0"]){
            [SVProgressHUD showErrorWithStatus:[data objectForKey:@"errorMsg"]];
            [SVProgressHUD dismissWithDelay:2.0f];
            return;
        }else{
            [weakSelf.delegate EditAgendSucceedCallBack:(int)self.currentRow viewController:weakSelf];
        }
    }];
}

@end
