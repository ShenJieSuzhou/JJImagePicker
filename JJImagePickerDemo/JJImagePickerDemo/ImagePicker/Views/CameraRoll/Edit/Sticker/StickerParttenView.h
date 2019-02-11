//
//  StickerParttenView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StickerParttenView;
@protocol StickerParttenDelegate <NSObject>
- (void)stickerDidTapped:(nonnull StickerParttenView *)stick;
- (void)stickerDidDelete:(nonnull StickerParttenView *)stick;
@end

@interface StickerParttenView : UIView

@property (strong, nonatomic) UIImage *sticker;
@property (strong, nonatomic) UIImageView *deleteImageView;
@property (strong, nonatomic) UIImageView *scaleImageView;
@property (strong, nonatomic) UIImageView *stickerImageView;
@property (weak, nonatomic) id<StickerParttenDelegate> stickPtDelgate;


@property (assign) CGPoint prevMovePoint;
@property (assign) CGFloat deltaAngle;
@property (assign) CGPoint touchStart;
@property (assign) CGRect bgRect;
@property (assign) CGFloat minW;
@property (assign) CGFloat minH;

@property (assign) BOOL isHide;


/*
 * 初始化 贴纸view
 */
- (instancetype)initWithFrame:(CGRect)frame sticker:(UIImage *)pasterImage;

/*
 * 显示贴纸
 */
- (void)showDelAndMoveBtn;

/*
 * 隐藏贴纸
*/
- (void)hideDelAndMoveBtn;

@end
