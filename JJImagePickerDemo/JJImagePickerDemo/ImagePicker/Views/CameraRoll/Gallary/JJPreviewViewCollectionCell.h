//
//  JJPreviewViewCollectionCell.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JJVideoToolBar.h"
#import "JJImageVideoPlayerView.h"

@protocol videoPlayerButtonDelegate<NSObject>

- (void)videoPlayerButtonClick:(UIButton *)button didModifyUI:(BOOL)didhide;

@end

@interface JJPreviewViewCollectionCell : UICollectionViewCell<UIGestureRecognizerDelegate>
// 设置当前要显示的图片，会把 livePhoto/video 相关内容清空，因此注意不要直接通过 imageView.image 来设置图片。
@property(nonatomic, weak) UIImage *image;
//预览图
@property (strong, nonatomic) UIImageView *previewImage;
//视频播放
@property (strong, nonatomic) JJImageVideoPlayerView *videoPlayerView;
//是否是视频
@property (assign) BOOL isVideoType;
//是否是livephoto
@property (assign) BOOL isLivePhotoType;
//视频mark
@property (strong, nonatomic) UIButton *videoBtn;
//cell 标识
@property (nonatomic, copy) NSString *identifier;
//设置当前要显示的video
@property (nonatomic, strong) AVPlayerItem *videoPlayerItem;
//用于显示 video 的layer
@property (nonatomic, strong) AVPlayerLayer *videoPlayerLayer;
//AVPlayer
@property (nonatomic, strong) AVPlayer *avPlayer;
//视频尺寸
@property (nonatomic, assign) CGSize videoSize;
//底部的播放栏目
@property (nonatomic, strong) JJVideoToolBar *jjVideoToolBar;

@property (nonatomic, strong) id<videoPlayerButtonDelegate> mDelegate;

//暂停视频播放
- (void)pauseVideo;
//停止视频播放
- (void)endPlayingVideo;
//zoom  控件

@end
