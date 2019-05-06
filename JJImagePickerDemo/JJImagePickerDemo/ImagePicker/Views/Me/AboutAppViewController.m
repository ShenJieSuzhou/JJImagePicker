//
//  AboutAppViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "AboutAppViewController.h"
#import <Masonry/Masonry.h>
#import "GlobalDefine.h"


#define APPID @""
#define APPSTORE_APPPYNAME @""


@interface AboutAppViewController ()


@property (strong, nonatomic) NSMutableArray *contentArray;
@end

@implementation AboutAppViewController
@synthesize appIconV = _appIconV;
@synthesize version = _version;
@synthesize myCopyRightH = _myCopyRightH;
@synthesize myCopyRightB = _myCopyRightB;
@synthesize footerV = _footerV;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    [self.navigationItem setTitle:@"关于我们"];
    UIImage *img = [[UIImage imageNamed:@"tabbar_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClicked)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    self.contentArray = [[NSMutableArray alloc] initWithObjects:@"给我们评分", @"检查更新", nil];
    
    [self.view addSubview:self.aboutTableView];
    [self.aboutTableView addSubview:self.footerV];
}

- (void)leftBarBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImageView *)appIconV{
    if(!_appIconV){
        _appIconV = [[UIImageView alloc] init];
        _appIconV.contentMode = UIViewContentModeScaleAspectFit;
        [_appIconV setImage:[UIImage imageNamed:@"aboutme"]];
    }
    
    return _appIconV;
}

- (UITableView *)aboutTableView{
    if(!_aboutTableView){
        _aboutTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        [_aboutTableView setBackgroundColor:[UIColor whiteColor]];
        _aboutTableView.delegate = self;
        _aboutTableView.dataSource = self;
        _aboutTableView.tableHeaderView = [UIView new];
//        _aboutTableView.tableFooterView = [UIView new];
    }

    return _aboutTableView;
}

- (UILabel *)version{
    if(!_version){
        _version = [[UILabel alloc] init];
        [_version setTextAlignment:NSTextAlignmentCenter];
        [_version setFont:[UIFont systemFontOfSize:11.0f]];
        [_version setTextColor:[UIColor grayColor]];
        NSString *vt = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [_version setText:[NSString stringWithFormat:@"版本号: %@", vt]];
    }
    
    return _version;
}

- (UILabel *)myCopyRightH{
    if(!_myCopyRightH){
        _myCopyRightH = [[UILabel alloc] init];
        [_myCopyRightH setTextAlignment:NSTextAlignmentCenter];
        [_myCopyRightH setFont:[UIFont systemFontOfSize:12.0f]];
        [_myCopyRightH setTextColor:[UIColor grayColor]];
        [_myCopyRightH setText:@"糖果科技 版权所有"];
    }
    
    return _myCopyRightH;
}

- (UILabel *)myCopyRightB{
    if(!_myCopyRightB){
        _myCopyRightB = [[UILabel alloc] init];
        [_myCopyRightB setTextAlignment:NSTextAlignmentCenter];
        [_myCopyRightB setFont:[UIFont systemFontOfSize:12.0f]];
        [_myCopyRightB setTextColor:[UIColor grayColor]];
        [_myCopyRightB setText:@"Copyright ©️ 2018-2019 CandyCam. All Rights Reserved"];
    }
    
    return _myCopyRightB;
}

-(UIView *)footerV{
    if (!_footerV) {
        _footerV = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 140, [UIScreen mainScreen].bounds.size.width, 40)];
        [self.myCopyRightH setFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        [self.myCopyRightB setFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
        [_footerV addSubview:self.myCopyRightH];
        [_footerV addSubview:self.myCopyRightB];
    }
    return _footerV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setText:[self.contentArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NSURL*appURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/%@/id%@?mt=8",APPSTORE_APPPYNAME,APPID]];
        [[UIApplication sharedApplication] openURL:appURL];
        
    }else if(indexPath.row == 1){
        NSString* str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=%@", APPID];
        NSURL  *rateURL = [NSURL URLWithString:str];
        if (!IsiOS7Later)
        {
            [[UIApplication sharedApplication] openURL:rateURL];
        }
        else
        {
            NSURL*appURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/%@/id%@?mt=8&uo=4",APPSTORE_APPPYNAME,APPID]];
            [[UIApplication sharedApplication] openURL:appURL];
        }
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    [self.appIconV setFrame:CGRectMake((self.view.frame.size.width - 80)/2, 10, 70, 70)];
    [self.version setFrame:CGRectMake(0, 90, self.view.frame.size.width, 20.0f)];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100.0f)];
    header.backgroundColor = [UIColor clearColor];
    [header addSubview:self.appIconV];
    [header addSubview:self.version];
    return header;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
//    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
//    footer.backgroundColor = [UIColor clearColor];
//    [footer addSubview:self.myCopyRightH];
//    [footer addSubview:self.myCopyRightB];

    return nil;
}  

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

@end
