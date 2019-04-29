//
//  AboutAppViewController.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutAppViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *aboutTableView;
@property (strong, nonatomic) UIImageView *appIconV;
@property (strong, nonatomic) UILabel *version;
@property (strong, nonatomic) UILabel *myCopyRightH;
@property (strong, nonatomic) UILabel *myCopyRightB;

@end

