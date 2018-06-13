//
//  CameraRollView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/1.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTableViewCell.h"
#import "JJPhotoAlbum.h"

@protocol CameraRollViewDelegate<NSObject>

/// 点击相簿里某一行时，需要给一个 PhotosViewController 对象用于展示九宫格图片列表
- (void)imagePickerViewControllerForCameraRollView:(JJPhotoAlbum *)album;

///**
// *  取消查看相册列表后被调用
// */
//- (void)albumViewControllerDidCancel:(QMUIAlbumViewController *)albumViewController;
//
///**
// *  即将需要显示 Loading 时调用
// *
// *  @see shouldShowDefaultLoadingView
// */
//- (void)albumViewControllerWillStartLoading:(QMUIAlbumViewController *)albumViewController;
//
///**
// *  即将需要隐藏 Loading 时调用
// *
// *  @see shouldShowDefaultLoadingView
// */
//- (void)albumViewControllerWillFinishLoading:(QMUIAlbumViewController *)albumViewController;

@end


@interface CameraRollView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id<CameraRollViewDelegate> delegate;

//背景色
@property (strong, nonatomic) UIView *background;

//胶卷视图
@property (strong, nonatomic) UITableView *rollsTableView;

//胶卷数据源
@property (strong, nonatomic) NSMutableArray *rollsArray;

/*
 * 刷新相册
 */
- (void)refreshAlbumAseets:(NSMutableArray *)albums;

@end
