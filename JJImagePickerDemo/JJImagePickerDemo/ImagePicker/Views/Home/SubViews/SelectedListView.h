//
//  SelectedListView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/30.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedListModel.h"

@protocol TipoffDelegate <NSObject>

- (void)tipOffSelectedCallBack:(SelectedListModel *)model;

@end

@interface SelectedListView : UITableView

@property (nonatomic , strong ) NSArray<SelectedListModel *>* array;

/**
 已选中Block
 */
@property (nonatomic , copy ) void (^selectedBlock)(NSArray <SelectedListModel *>*);

/**
 选择改变Block (多选情况 当选择改变时调用)
 */
@property (nonatomic , copy ) void (^changedBlock)(NSArray <SelectedListModel *>*);

@property (weak, nonatomic) id<TipoffDelegate> mDelegate;

/**
 是否单选
 */
@property (nonatomic , assign ) BOOL isSingle;

/**
 完成选择 (多选会调用selectedBlock回调所选结果)
 */
- (void)finish;

@end

