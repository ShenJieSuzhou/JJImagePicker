//
//  kindWarming.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "kindWarming.h"

@implementation kindWarming
@synthesize delegate = _delegate;

+(instancetype)getInstance{
    return [[[NSBundle mainBundle] loadNibNamed:@"kindWarming" owner:self options:nil] firstObject];
}

- (IBAction)showUserItems:(id)sender {
    [_delegate showUserItem:self];
}


- (IBAction)showPrivacy:(id)sender {
    [_delegate showPrivacy:self];
}

- (IBAction)clickAgreeBtn:(id)sender {
    [self removeFromSuperview];
}


@end
