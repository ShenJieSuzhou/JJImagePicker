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

/*
 * 初始化 贴纸view
 */
- (instancetype)initWithFrame:(CGRect)frame sticker:(UIImage *)pasterImage;

/*
 * 删除贴纸
 */
- (void)deleteTheSticker;

/*
 * 显示贴纸
 */
- (void)showDelAndMoveBtn;

/*
 * 隐藏贴纸
*/
- (void)hideDelAndMoveBtn;

@end
