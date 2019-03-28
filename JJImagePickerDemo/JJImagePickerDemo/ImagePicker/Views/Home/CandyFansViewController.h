//
//  CandyFansViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/3/27.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"

@interface CandyFansViewController : CustomPhotoViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *fansList;

@property (strong, nonatomic) UITableView *fansTableView;

- (void)setCandyFansList:(NSMutableArray *)fansData;

@end


