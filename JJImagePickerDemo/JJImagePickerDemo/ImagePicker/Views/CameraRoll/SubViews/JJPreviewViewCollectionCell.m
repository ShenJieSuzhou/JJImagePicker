//
//  JJPreviewViewCollectionCell.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/6/15.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJPreviewViewCollectionCell.h"
#import "JJZoomImageViewImageGenerator.h"

@implementation JJPreviewViewCollectionCell
@synthesize videoBtn = _videoBtn;
@synthesize previewImage = _previewImage;
@synthesize videoPlayerView = _videoPlayerView;
@synthesize isVideoType = _isVideoType;
@synthesize isLivePhotoType = _isLivePhotoType;
@synthesize identifier = _identifier;

@synthesize image = _image;
@synthesize videoPlayerItem = _videoPlayerItem;
@synthesize videoPlayerLayer = _videoPlayerLayer;
@synthesize avPlayer = _avPlayer;
@synthesize videoSize = _videoSize;

@synthesize jjVideoToolBar = _jjVideoToolBar;
@synthesize mDelegate = _mDelegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    [self setBackgroundColor:[UIColor clearColor]];
    _previewImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _previewImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_videoBtn setBackgroundColor:[UIColor clearColor]];
    [_videoBtn setBackgroundImage:[JJZoomImageViewImageGenerator largePlayImage] forState:UIControlStateNormal];
    [_videoBtn addTarget:self action:@selector(handlePlayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _videoPlayerView = [[JJImageVideoPlayerView alloc] init];
    _videoPlayerLayer = (AVPlayerLayer *)_videoPlayerView.layer;
    _videoPlayerView.hidden = YES;
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGestureWithPoint:)];
    singleTapGesture.delegate = self;
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTapGesture];
    
    [self.contentView addSubview:self.previewImage];
    [self.contentView addSubview:self.videoPlayerView];
    [self.contentView addSubview:self.videoBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_previewImage setFrame:self.bounds];
    
    if(_videoBtn){
        [_videoBtn sizeToFit];
        _videoBtn.center = CGPointMake(0, 0);
        [_videoBtn setFrame:CGRectMake((self.frame.size.width - _videoBtn.frame.size.width)/2, (self.frame.size.height - _videoBtn.frame.size.height)/2, _videoBtn.frame.size.width, _videoBtn.frame.size.height)];
    }

    if(_isVideoType){
        [_videoBtn setHidden:NO];
    }else{
        [_videoBtn setHidden:YES];
    }
}

- (void)setImage:(UIImage *)image{
    if(!image){
        return;
    }
    
    _image = image;
    
    _previewImage.image = image;
    [self.previewImage setFrame:CGRectApplyAffineTransform(CGRectMake(0, 0, image.size.width, image.size.height), self.previewImage.transform)];
}

#pragma mark - video

- (void)setVideoPlayerItem:(AVPlayerItem *)videoPlayerItem{
    if(!videoPlayerItem){
        
        return;
    }
    
    _videoPlayerItem = videoPlayerItem;
    
    NSArray<AVAssetTrack *> *tracksArray = videoPlayerItem.asset.tracks;
    self.videoSize = CGSizeZero;
    for(AVAssetTrack *track in tracksArray){
        if([track.mediaType isEqualToString:AVMediaTypeVideo]){
            CGSize size = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
            self.videoSize = CGSizeMake(fabs(size.width), fabs(size.height));
            break;
        }
    }
    
    self.avPlayer = [AVPlayer playerWithPlayerItem:videoPlayerItem];
    self.videoPlayerLayer.player = self.avPlayer;
    self.videoPlayerView.frame = CGRectApplyAffineTransform(CGRectMake(0, 0, self.videoSize.width, self.videoSize.height), self.videoPlayerView.transform);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleVideoPlayToEndEvent) name:AVPlayerItemDidPlayToEndTimeNotification object:videoPlayerItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    self.videoPlayerLayer.hidden = NO;
    self.videoBtn.hidden = NO;
}

//播放按钮点击事件
- (void)handlePlayButton:(UIButton *)button{
    
    [self.avPlayer play];
    self.videoBtn.hidden = YES;
    //播放视频，回调通知界面隐藏上方导航和底部工具栏
    [_mDelegate videoPlayerButtonClick:button didModifyUI:YES];
}

//视频播放结束
- (void)handleVideoPlayToEndEvent {
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    self.videoBtn.hidden = NO;
    //视频播放结束，回调通知界面显示上方导航和底部工具栏
    [_mDelegate videoPlayerButtonClick:self.videoBtn didModifyUI:NO];
}

//暂停
- (void)pauseVideo{
    if(!self.avPlayer){
        return;
    }
    
    [self.avPlayer pause];
    [_mDelegate videoPlayerButtonClick:self.videoBtn didModifyUI:NO];
}

//结束
- (void)endPlayingVideo{
    if(!self.avPlayer){
        return;
    }
    
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self pauseVideo];
    
    self.videoBtn.hidden = NO;
    [_mDelegate videoPlayerButtonClick:self.videoBtn didModifyUI:NO];
}

- (void)applicationDidEnterBackground {
    //app 进入后台后，结束视频播放
    [self endPlayingVideo];
}

#pragma mark - GestureRecognizers

- (void)handleSingleTapGestureWithPoint:(UITapGestureRecognizer *)gestureRecognizer {
    if(!self.avPlayer){
        return;
    }
    
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self pauseVideo];
    
    self.videoBtn.hidden = NO;
    [_mDelegate videoPlayerButtonClick:self.videoBtn didModifyUI:NO];
}


@end
