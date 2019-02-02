//
//  JJCollectionViewCell.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/6/11.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJCollectionViewCell.h"
#import "JJImagePickerHelper.h"

const UIEdgeInsets checkBoxMargins = {6, 0, 0, 6};
const UIEdgeInsets videoMarkMargins = {0, 8, 8, 0};
const UIEdgeInsets livePhotoMargins = {6, 6, 0, 0};
const UIEdgeInsets durationMargins = {0, 0, 8, 8};

@implementation SelectButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    SelectButton *btn = [super buttonWithType:buttonType];
//    [btn setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>]
    return btn;
}

@end

@implementation JJCollectionViewCell
@synthesize checkBox = _checkBox;
@synthesize contentImageView = _contentImageView;
@synthesize assetIdentifier = _assetIdentifier;
@synthesize livePhotoView = _livePhotoView;
@synthesize videoView = _videoView;
@synthesize selectedImage = _selectedImage;
@synthesize unselectedImage = _unselectedImage;
@synthesize videoDuration = _videoDuration;
@synthesize checked = _checked;
@synthesize maskView = _maskView;

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
    //添加图片视图
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.contentImageView];
    
    //添加checkbox
    _checkBox = [SelectButton buttonWithType:UIButtonTypeCustom];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [self.checkBox setFrame:CGRectMake(0, 0, 30, 30)];
    }else{
        [self.checkBox setFrame:CGRectMake(0, 0, 23, 23)];
    }
    //设置CheckBox背景
    self.unselectedImage = [UIImage imageNamed:@"chooseInterest_uncheaked"];
    self.selectedImage = [UIImage imageNamed:@"chooseInterest_cheaked"];
    [self.checkBox setBackgroundColor:[UIColor clearColor]];
    [self.checkBox setBackgroundImage:self.unselectedImage forState:UIControlStateNormal];
    [self.checkBox setBackgroundImage:self.selectedImage forState:UIControlStateSelected];
    [self.contentView addSubview:self.checkBox];
    
    //添加视频标记图片
    _videoView = [[UIImageView alloc] init];
    [_videoView setImage:[UIImage imageNamed:@"pickerImage_video_mark"]];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [_videoView setFrame:CGRectMake(0, 0, 40, 24)];
    }else{
        [_videoView setFrame:CGRectMake(0, 0, 20, 12)];
    }
    _videoView.contentMode = UIViewContentModeScaleAspectFill;
    _videoView.clipsToBounds = YES;
    [self.contentView addSubview:self.videoView];
    [self.videoView setHidden:YES];
    
    //添加视频的时间长度
    _videoDuration = [[UILabel alloc] init];
    [_videoDuration setFrame:CGRectZero];
    [_videoDuration setTextColor:[UIColor whiteColor]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
    }else{
        [_videoDuration setFont:[UIFont systemFontOfSize:12.0f]];
    }
    
    [self.contentView addSubview:self.videoDuration];
    [self.videoDuration setHidden:YES];
    
    self.maskView = [[UIImageView alloc] initWithFrame:self.frame];
    [self.maskView setBackgroundColor:[UIColor colorWithRed:254/255.f green:254/255.f blue:254/255.f alpha:0.5f]];
    [self.contentView addSubview:self.maskView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentImageView.frame = self.contentView.bounds;
    CGFloat cellWidth = self.contentView.bounds.size.width;;
    CGFloat cellHeight = self.contentView.bounds.size.height;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){

    }else{
        [self.checkBox setFrame:CGRectMake(cellWidth - checkBoxMargins.right - self.checkBox.frame.size.width, checkBoxMargins.top, self.checkBox.frame.size.width, self.checkBox.frame.size.height)];
        
        [self.videoView setFrame:CGRectMake(videoMarkMargins.left, cellHeight - self.videoView.frame.size.height - videoMarkMargins.bottom, self.videoView.frame.size.width, self.videoView.frame.size.height)];
        
        CGSize textSize = [_videoDuration.text sizeWithAttributes:@{NSFontAttributeName:_videoDuration.font}];
        [self.videoDuration setFrame:CGRectMake(cellWidth - durationMargins.right - textSize.width, cellHeight - textSize.height - durationMargins.bottom, textSize.width+10.0f, textSize.height)];
    }
}

- (void)setChecked:(BOOL)checked{
    _checked = checked;
    self.checkBox.selected = checked;
    
    //动画效果
    [JJImagePickerHelper removeactionSpringAnimationForView:self.checkBox];
    if(checked){
        [JJImagePickerHelper actionSpringAnimationForView:self.checkBox];
    }
}

- (void)updateAssetCell:(JJPhoto *)asset isVideo:(BOOL) isVideo{
    //异步请求资源对应的缩略图
    [asset requestThumbnailImageWithSize:CGSizeMake(80.0f, 80.0f) completion:^(UIImage *result, NSDictionary *info) {
        if([self.assetIdentifier isEqualToString:asset.identifier]){
            self.contentImageView.image = result;
        }else{
            self.contentImageView.image = nil;
        }
    }];
    
    //为视频加上时间跟类型标记
    if(isVideo){
        self.userInteractionEnabled = NO;
        [self.checkBox setHidden:YES];
        self.videoDuration.text = [NSString jj_timeStringWithMinsAndSecsFromSecs:asset.duration];
        [self.videoView setHidden:NO];
        [self.videoDuration setHidden:NO];
        [self.maskView setHidden:NO];
    }else{
        self.userInteractionEnabled = YES;
        [self.checkBox setHidden:NO];
        [self.maskView setHidden:YES];
    }
}

@end
