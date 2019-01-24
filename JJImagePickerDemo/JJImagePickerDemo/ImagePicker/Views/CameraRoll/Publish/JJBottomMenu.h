//
//  BottomMenu.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/6.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  functionView 类型
 */
typedef NS_ENUM(NSUInteger, ChatFunctionViewShowType){
    ChatFunctionViewSendMessage, //!< 发送消息
    ChatFunctionViewShowFace     /**< 显示表情View */,
    ChatFunctionViewShowKeyboard /**< 显示键盘 */,
    ChatFunctionViewShowNothing  /**< 不显示functionView */,
};

@protocol JJBottomMenuDelegate <NSObject>

- (void)showViewWithType:(ChatFunctionViewShowType)showType;

@end

@interface JJBottomMenu : UIView

@property (strong, nonatomic) UIButton *locationBtn;

@property (strong, nonatomic) UIView *menuView;

//@property (strong, nonatomic) UIButton *emojBtn;

@property (strong, nonatomic) UIButton *topicBtn;

@property (weak, nonatomic) id<JJBottomMenuDelegate> delegate;

@end

