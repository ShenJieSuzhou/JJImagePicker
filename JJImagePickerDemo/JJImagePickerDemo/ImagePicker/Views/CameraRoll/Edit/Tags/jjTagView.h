//
//  jjTagView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/9/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"
#import "UIView+ZYTagView.h"

@class JJTagView;
@protocol JJTagDelegate<NSObject>
- (void)activeTapGesture:(JJTagView *)tagView;
@end

@interface JJTagView : UIView

@property (nonatomic, weak) id<JJTagDelegate> delegate;
@property (nonatomic, strong) TagModel *tagModel;
@property (assign) TAG_DIRECTION direction;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint arrowPoint;

@property (nonatomic, weak) CAShapeLayer *backLayer;
@property (nonatomic, weak) CAShapeLayer *pointLayer;
@property (nonatomic, weak) CAShapeLayer *pointShadowLayer;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *deleteBtn;
@property (nonatomic, weak) UIImageView *separateLine;

//处理临界点
@property (assign) CGFloat criticalX;
@property (assign) CGFloat criticalY;


- (instancetype)initWithTagModel:(TagModel *)tagModel;

- (void)showAnimation;

- (void)removeAnimation;

- (void)showDeleteBtn;

- (void)hiddenDeleteBtn;

@end
