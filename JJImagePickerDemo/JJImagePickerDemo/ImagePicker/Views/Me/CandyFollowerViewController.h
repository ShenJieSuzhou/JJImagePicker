//
//  CandyFollowerViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/6.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyFollowerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *followerList;

@property (strong, nonatomic) UITableView *followerTableView;

@property (copy, nonatomic) NSString *showTitle;

- (void)setCandyfollowersList:(NSMutableArray *)followersData;

@end

