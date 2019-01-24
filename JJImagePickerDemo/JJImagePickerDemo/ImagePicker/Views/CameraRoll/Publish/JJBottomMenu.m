//
//  BottomMenu.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/11/6.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "JJBottomMenu.h"
#define LOCATION_WIDTH 120.0f
#define LOCATION_HEIGHT 30.0f
#define MENU_HEIGHT 50.0f
#define MENU_PADDING 10.0f
#define MENU_VIEW_WIDTH self.view.frame.size.width
#define MENU_VIEW_HEIGHT self.view.frame.size.height


@implementation JJBottomMenu
@synthesize locationBtn = _locationBtn;
@synthesize menuView = _menuView;
//@synthesize emojBtn = _emojBtn;
@synthesize topicBtn = _topicBtn;
@synthesize delegate = _delegate;

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
    _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationBtn setImage:[UIImage imageNamed:@"phototagaddresscheck"] forState:UIControlStateNormal];
    [_locationBtn setTitle:@"你在哪里?" forState:UIControlStateNormal];
    [_locationBtn setTitleColor:[UIColor colorWithRed:147/255.0f green:147/255.0f blue:147/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_locationBtn setBackgroundColor:[UIColor colorWithRed:246/255.0f green:246/255.0f blue:246/255.0f alpha:1]];
    [self addSubview:_locationBtn];
    
//    _emojBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_emojBtn setImage:[UIImage imageNamed:@"chat_input_message_face"] forState:UIControlStateNormal];
//    [_emojBtn setImage:[UIImage imageNamed:@"chat_input_keywoad"] forState:UIControlStateSelected];
//    [_emojBtn setFrame:CGRectMake(10.0f, 10.0f, 30.0f, 30.0f)];
//    [_emojBtn addTarget:self action:@selector(popEmojSelectView:) forControlEvents:UIControlEventTouchUpInside];
//    _emojBtn.tag = ChatFunctionViewShowFace;
    
    _menuView = [[UIView alloc] initWithFrame:CGRectZero];
    [_menuView setBackgroundColor:[UIColor whiteColor]];
    [_menuView addSubview:_locationBtn];
    [self addSubview:_menuView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    [_locationBtn setFrame:CGRectMake(MENU_PADDING, 10.0f, LOCATION_WIDTH, LOCATION_HEIGHT)];
    [_locationBtn.layer setCornerRadius:15];
    [_menuView setFrame:CGRectMake(0, MENU_HEIGHT, width, MENU_HEIGHT)];
}

//- (void)popEmojSelectView:(UIButton *)sender{
//    ChatFunctionViewShowType showType = sender.tag;
////    self.emojBtn.selected = !self.emojBtn.selected;
//    
//    if(!sender.selected){
//        showType = ChatFunctionViewShowKeyboard;
//    }
//    
//    [_delegate showViewWithType:showType];
//}

@end
