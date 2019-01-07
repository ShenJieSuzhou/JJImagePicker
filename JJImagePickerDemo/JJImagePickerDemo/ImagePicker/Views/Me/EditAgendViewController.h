//
//  EditAgendViewController.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/29.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPhotoViewController.h"
@protocol EditAgendDelegate <NSObject>

- (void)EditAgendSucceedCallBack:(int)agend;

@end

@interface EditAgendViewController : CustomPhotoViewController
@property (weak, nonatomic) id<EditAgendDelegate> delegate;
@end
