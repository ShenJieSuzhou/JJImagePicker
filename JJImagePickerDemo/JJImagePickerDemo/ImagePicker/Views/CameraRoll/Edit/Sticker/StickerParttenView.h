//
//  StickerParttenView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/26.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickerParttenView : UIView

@property (strong, nonatomic) UIImage *sticker;
@property (strong, nonatomic) UIImageView *deleteImageView;
@property (strong, nonatomic) UIImageView *scaleImageView;
@property (strong, nonatomic) UIImageView *stickerImageView;

@property (assign) CGPoint prevMovePoint;
@property (assign) CGFloat deltaAngle;
@property (assign) CGPoint touchStart;
@property (assign) CGRect bgRect;
@property (assign) CGFloat minW;
@property (assign) CGFloat minH;


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