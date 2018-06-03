//
//  CameraRollView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/1.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraRollView : UIView<UITableViewDataSource, UITableViewDelegate>

//背景色
@property (strong, nonatomic) UIView *background;

//胶卷视图
@property (strong, nonatomic) UITableView *rollsTableView;

//胶卷数据源
@property (strong, nonatomic) NSMutableArray *rollsArray;


@end
