//
//  JJDatePicker.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJDatePicker;

@protocol JJDatePickerDelegate<NSObject>

- (void)cancelBtnClickCallBack:(JJDatePicker *)picker;

- (void)saveBtnClickCallBack:(JJDatePicker *)picker date:(NSString *)date;

@end


@interface JJDatePicker : UIView
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *saveBtn;

@property (strong, nonatomic) NSString *currentDate;

@property (weak, nonatomic) id<JJDatePickerDelegate> delegate;

@end

