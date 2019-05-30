//
//  reportView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/29.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "reportView.h"

@implementation reportView
@synthesize delegate = _delegate;

+(instancetype)getInstance{
    return [[[NSBundle mainBundle] loadNibNamed:@"reportView" owner:self options:nil] firstObject];
}

- (IBAction)reportContent:(id)sender {
    NSLog(@"%s", __func__);
    
    [_delegate clickTipOffCallBack];
}


- (IBAction)pullToBlacklist:(id)sender {
    NSLog(@"%s", __func__);
    
    [_delegate clickPullBlackCallBack];
}





@end
