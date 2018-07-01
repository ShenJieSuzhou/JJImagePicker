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
@synthesize isVideoType = _isVideoType;
@synthesize isLivePhotoType = _isLivePhotoType;
@synthesize identifier = _identifier;

@synthesize image = _image;
@synthesize videoPlayerItem = _videoPlayerItem;
@synthesize videoPlayerLayer = _videoPlayerLayer;
@synthesize avPlayer = _avPlayer;
@synthesize videoSize = _videoSize;

@synthesize jjVideoToolBar = _jjVideoToolBar;


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
    [self.contentView addSubview:self.previewImage];
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

}

//播放按钮点击事件
- (void)handlePlayButton:(UIButton *)button{
    
    [self.avPlayer play];
    self.videoBtn.hidden = YES;
//    self.jjVideoToolBar
    
}

- (void)pauseVideo{
    if(!self.avPlayer){
        return;
    }
    
    [self.avPlayer pause];
    
}

- (void)endPlayingVideo{
    if(!self.avPlayer){
        return;
    }
    
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self pauseVideo];
    
    self.jjVideoToolBar.hidden = YES;
    self.videoBtn.hidden = NO;
}

- (AVPlayerLayer *)videoPlayerLayer{
    return _videoPlayerLayer;
}

@end
