//
//  GBverifyButton.m
//  SMSLimmitOpation
//
//  Created by 张国兵 on 15/6/18.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "GBverifyButton.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>

#define R_G_B_16(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@interface GBverifyButton(){
    int timeCount;
    NSTimer*timer;
    
}

@property(nonatomic,retain) UIButton *verifyButton;
@property(nonatomic,retain) UILabel *tipLabel;

@end

@implementation GBverifyButton

-(id)initWithFrame:(CGRect)frame{
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

    timeCount = 60;
    
    //获取验证码按钮
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [button addTarget:self action:@selector(clickYZMBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 15;
    [button.layer setBorderColor:[UIColor colorWithRed:236/255.0f green:77/255.0f blue:65/255.0f alpha:1.0f].CGColor];
    [button.layer setBorderWidth:1.0f];
    button.clipsToBounds = YES;
    _verifyButton = button;
    [self addSubview:_verifyButton];
    
    //验证提交之后的跑秒提示防止用户的重复提交数据有效时间60秒
    _tipLabel = [[UILabel alloc ] init];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [_tipLabel setFont:[UIFont systemFontOfSize:12.0f]];
    _tipLabel.text = [[NSString alloc]initWithFormat:@"%ds后 重新获取", timeCount];
    _tipLabel.textColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
    _tipLabel.layer.cornerRadius = 15;
    [_tipLabel.layer setBorderColor:[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f].CGColor];
    [_tipLabel.layer setBorderWidth:1.0f];
    _tipLabel.clipsToBounds = YES;
    _tipLabel.hidden = YES;
    [self addSubview:_tipLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.frame.size);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.frame.size);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
}

- (void)clickYZMBtn:(UIButton *)sender{
    [self startGetMessage];
}

#pragma mark-->读秒开始
-(void)readSecond{
    _verifyButton.hidden=YES;
    
    _tipLabel.hidden=NO;
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    timer.fireDate=[NSDate distantPast];
}

#pragma mark-->跑秒操作
-(void)dealTimer{
    
    _tipLabel.text=[[NSString alloc]initWithFormat:@"%ds后 重新发送",timeCount];
    timeCount=timeCount-1;
    if(timeCount==0){
        timer.fireDate=[NSDate distantFuture];
        timeCount=60;
        _tipLabel.hidden=YES;
        _verifyButton.hidden=NO;
    }
    
}
#pragma mark-获取验证码
-(void)getVerifyClick{
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"GBVerifyEnterAgain"]==NO){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GBVerifyEnterAgain"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //第一次点击直接读秒
        [self readSecond];
        //读秒开始记录时间
        NSDate *datenow = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[datenow timeIntervalSince1970]];
        [[NSUserDefaults standardUserDefaults] setObject:timeSp forKey:@"getMessageTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else{
        //第二次点击，先进行时间对比
        NSString*signTime=[[NSUserDefaults standardUserDefaults]objectForKey:@"getMessageTime"];
        int signTime_NUM=[signTime intValue];
        /**
         获取获取验证码的时间
         */
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:signTime_NUM];
        NSTimeInterval interval=[[NSDate date]timeIntervalSinceDate:confromTimesp];
        
        NSLog(@"%d",(int)interval );
        //如果时间间隔大于60秒，点击允许下次点击，重新记录获取时间
        if(interval>60){
            NSLog(@"获取验证码");
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[datenow timeIntervalSince1970]];
            [[NSUserDefaults standardUserDefaults] setObject:timeSp forKey:@"getMessageTime"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self readSecond];
            
        }else{
            [SVProgressHUD showWithStatus:@"您的操作过于频繁请稍后再试"];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    }
}

-(void)setEnabled:(BOOL)enabled{
    _verifyButton.enabled = enabled;
    if(enabled==YES){
        
        [_verifyButton setBackgroundColor:R_G_B_16(0x4edb69)];

    }else{
        
       [_verifyButton setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:.8]];
    }
}

#pragma -获取验证码
-(void)startGetMessage{
    [self getVerifyClick];
}

//- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
//    [_verifyButton setBackgroundImage:image forState:state];
//}
//
//-(void)setTitleFont:(UIFont*)font{
//    _verifyButton.titleLabel.font=font;
//    _tipLabel.font=font;
//}

-(void)colseTimer{
     //在invalidate之前最好先用isValid先判断是否还在线程中
    if ([timer isValid] == YES) {
        [timer invalidate];
         timer = nil;
    }
}


@end
