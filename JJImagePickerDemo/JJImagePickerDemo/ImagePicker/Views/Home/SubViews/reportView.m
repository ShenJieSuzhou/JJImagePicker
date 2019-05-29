//
//  reportView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/29.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import "reportView.h"

@implementation reportView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)getInstance{
    return [[[NSBundle mainBundle] loadNibNamed:@"reportView" owner:self options:nil] firstObject];
}

- (IBAction)reportContent:(id)sender {
    
    
}


- (IBAction)pullToBlacklist:(id)sender {

    
}





@end
