//
//  EditNameViewController.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"
@class EditNameViewController;
@protocol EditNameDelegate <NSObject>

- (void)EditNameSuccessCallBack:(NSString *)name viewController:(EditNameViewController *)viewCtl;

@end

@interface EditNameViewController : CustomPhotoViewController

@property (weak, nonatomic) id<EditNameDelegate> delegate;

- (void)setNickName:(NSString *)name;


@end