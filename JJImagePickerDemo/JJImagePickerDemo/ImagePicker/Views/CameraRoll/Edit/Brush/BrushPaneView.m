//
//  BrushPaneView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/10/20.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "BrushPaneView.h"
#define COLOR_BTN_TAG 2018

@implementation BrushPaneView
//@synthesize colorCollectionView = _colorCollectionView;
@synthesize colorArray = _colorArray;
@synthesize colorScrollView = _colorScrollView;

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _colorArray = @[[UIColor blackColor],
                        [UIColor darkGrayColor],
                        [UIColor lightGrayColor],
                        [UIColor whiteColor],
                        [UIColor grayColor],
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor cyanColor],
                        [UIColor yellowColor],
                        [UIColor magentaColor],
                        [UIColor orangeColor],
                        [UIColor purpleColor],
                        [UIColor brownColor]];
        
        [self commoniInitlization];
    }
    return self;
}

- (void)commoniInitlization{
    [self addSubview:self.colorScrollView];
    
    for (int i = 0; i < [_colorArray count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTag:(i + COLOR_BTN_TAG)];
        [btn addTarget:self action:@selector(clickColorBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.colorScrollView addSubview:btn];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i < [_colorArray count]; i++) {
        UIButton *btn = [self viewWithTag:(i+COLOR_BTN_TAG)];
        [btn setBackgroundColor:[_colorArray objectAtIndex:i]];
        CGFloat btnWidth = 25.0f;
        CGFloat btnHeight = 25.0f;
        [btn setFrame:CGRectMake(i*(btnWidth + 15.0f), 0, btnWidth, btnHeight)];
        [btn.layer setCornerRadius:btnWidth/2];
        [btn.layer setBorderWidth:1.5f];
        [btn.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
}

- (void)clickColorBtn:(UIButton *)sender{
    if(!sender.selected){
        CGFloat btnWidth = 30.0f;
        CGFloat btnHeight = 30.0f;
        [sender setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, btnWidth, btnHeight)];
        [sender.layer setCornerRadius:btnWidth/2];
        [sender.layer setBorderWidth:1.5f];
        [sender.layer setBorderColor:[UIColor whiteColor].CGColor];
    }else{
        CGFloat btnWidth = 25.0f;
        CGFloat btnHeight = 25.0f;
        [sender setFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, btnWidth, btnHeight)];
        [sender.layer setCornerRadius:btnWidth/2];
        [sender.layer setBorderWidth:1.5f];
        [sender.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
}

#pragma mark -lazyLoad
- (UIScrollView *)colorScrollView{
    if(!_colorScrollView){
        _colorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50.0f)];
        _colorScrollView.contentSize = CGSizeMake(40 * _colorArray.count, 50.0f);
        _colorScrollView.backgroundColor = [UIColor clearColor];
        _colorScrollView.bounces = YES;
        _colorScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        _colorScrollView.showsVerticalScrollIndicator = NO;
        _colorScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _colorScrollView;
}

@end
