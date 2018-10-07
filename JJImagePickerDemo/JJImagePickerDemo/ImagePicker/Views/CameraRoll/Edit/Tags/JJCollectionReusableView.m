//
//  JJCollectionReusableView.m
//  testTag
//
//  Created by silicon on 2018/10/5.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJCollectionReusableView.h"
#define IMG_LEFT_MARGIN 20.0f
#define IMG_TOP_MARGIN 15.0f

@implementation JJCollectionReusableView
@synthesize textLabel = _textLabel;
@synthesize leftImg = _leftImg;

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _leftImg = [[UIImageView alloc] init];
        _leftImg.contentMode = UIViewContentModeScaleAspectFit;
        [_leftImg setFrame:CGRectMake(IMG_LEFT_MARGIN, IMG_TOP_MARGIN, 15, 15)];
        [self addSubview:_leftImg];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(IMG_LEFT_MARGIN + 25.0f, IMG_TOP_MARGIN, self.bounds.size.width, 15.0f)];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        [_textLabel setFont:[UIFont systemFontOfSize:15.0f]];
        _textLabel.text = @"This is a section header/footer";
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title image:(UIImage *)img{
    [_textLabel setText:title];
    [_leftImg setImage:img];
}



@end
