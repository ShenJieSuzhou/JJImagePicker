//
//  JJDatePicker.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/12/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJDatePicker.h"

@implementation JJDatePicker
@synthesize datePicker = _datePicker;
@synthesize cancelBtn = _cancelBtn;
@synthesize saveBtn = _saveBtn;
@synthesize delegate = _delegate;
@synthesize currentDate = _currentDate;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInitlization];
    }
    
    return self;
}

- (void)commonInitlization{
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [_datePicker setBackgroundColor:[UIColor whiteColor]];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_saveBtn setBackgroundColor:[UIColor whiteColor]];
    [_saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(clickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_datePicker];
    [self addSubview:_cancelBtn];
    [self addSubview:_saveBtn];
}

- (void)layoutSubviews{
    self.layer.cornerRadius = 8.0f;
    self.layer.masksToBounds = YES;
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat btnHeight = 50.0f;
    
    [_datePicker setFrame:CGRectMake(0, 0, width, height - btnHeight)];
    [_cancelBtn setFrame:CGRectMake(0, height - btnHeight, width / 2.0f, btnHeight)];
    [_saveBtn setFrame:CGRectMake(width / 2.0f, height - btnHeight, width / 2.0f, btnHeight)];
}

- (void)dateChange:(UIDatePicker *)sender{
    NSDate *theDate = sender.date;
    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    self.currentDate = [dateFormatter stringFromDate:theDate];
}

- (void)clickCancelBtn:(UIButton *)sender{
    [_delegate cancelBtnClickCallBack:self];
}

- (void)clickSaveBtn:(UIButton *)sender{
    [_delegate saveBtnClickCallBack:self date:self.currentDate];
}

@end
