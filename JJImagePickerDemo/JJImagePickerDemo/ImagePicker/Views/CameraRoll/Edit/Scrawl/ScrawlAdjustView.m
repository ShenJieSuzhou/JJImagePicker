//
//  ScrawlAdjustView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/18.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "ScrawlAdjustView.h"
#define SCRAWL_MARGIN 0.0f


@implementation ScrawlAdjustView
@synthesize cancelBtn = _cancelBtn;
@synthesize confirmBtn = _confirmBtn;
@synthesize mTitle = _mTitle;
@synthesize stoolSlider = _stoolSlider;

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
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.stoolSlider];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setBackgroundImage:[UIImage imageNamed:@"tabbar_close"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirm setBackgroundImage:[UIImage imageNamed:@"tabbar_finish"] forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBtn = cancel;
    self.confirmBtn = confirm;
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.confirmBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIImage *close = [UIImage imageNamed:@"tabbar_close"];
    UIImage *finish = [UIImage imageNamed:@"tabbar_finish"];
    
    [self.cancelBtn setFrame:CGRectMake(20.0f, self.bounds.size.height - close.size.height - 10.0f, close.size.width, close.size.height)];
    
    [self.confirmBtn setFrame:CGRectMake(self.bounds.size.width - finish.size.width - 20.0f, self.bounds.size.height - close.size.height - 10.0f, finish.size.width, finish.size.width)];
}

#pragma mark -lazy
/*
 * @brief stoolSlider
 */
- (CustomSlider *)stoolSlider{
    if(!_stoolSlider){
        _stoolSlider = [[CustomSlider alloc] initWithFrame:CGRectMake(0, SCRAWL_MARGIN, self.bounds.size.width, 40) Title:@"粗细" color:[UIColor redColor]];
        _stoolSlider.delegate = self;
    }
    
    return _stoolSlider;
}

- (void)clickCancelBtn:(UIButton *)sender{
    NSLog(@"cancel");
}

- (void)clickConfirmBtn:(UIButton *)sender{
    NSLog(@"confrim");
}

#pragma mark - CustomSliderDelegate
- (void)customSliderValueChangeCallBacK:(float)value{
    
}

@end
