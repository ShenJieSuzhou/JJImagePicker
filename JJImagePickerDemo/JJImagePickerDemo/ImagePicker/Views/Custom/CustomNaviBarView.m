//
//  CustomNaviBarView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/5/31.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "CustomNaviBarView.h"
#import "GlobalDefine.h"

@implementation CustomNaviBarView

@synthesize btnBack = _btnBack;
@synthesize labelTitle = _labelTitle;
@synthesize imgViewBg = _imgViewBg;
@synthesize btnLeft = _btnLeft;
@synthesize btnRight = _btnRight;
//@synthesize titleImage = _titleImage;
@synthesize btnTitle = _btnTitle;

+ (CGRect)leftBtnFrame{
    return Rect(10, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
}

+ (CGRect)rightBtnFrame{
    return Rect(ScreenWidth - 60.0f, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
}

+ (CGSize)barBtnSize{
    return Size(35.0f, 35.0f);
}

+ (CGSize)barSize{
    return Size(ScreenWidth, 64.0f);
}

+ (CGRect)titleViewFrame{
    return Rect(65.0f, 22.0F, ScreenWidth - 130, 40.0f);
}

//+ (CGRect)titleImageViewFrame{
//    return Rect(65.0f, 22.0F, 40.0f, 40.0f);
//}

+ (CGRect)titleBtnFrame{
    return Rect(65.0f, 20.0F, ScreenWidth - 130, 40.0f);
}

+ (UIButton *)createNavBarImageBtn:(NSString *)imgStr
                       Highligthed:(NSString *)imgHighStr
                            Target:(id)target
                            Action:(SEL)action{
    
    UIImage *imgNormal = [UIImage imageNamed:imgStr];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imgNormal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:(imgHighStr ? imgHighStr : imgStr)] forState:UIControlStateHighlighted];
    
    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - imgNormal.size.width)/2.0f;
    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - imgNormal.size.height)/2.0f;
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth, fDeltaHeight, fDeltaWidth)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -imgNormal.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.btnBack = [[self class] createNavBarImageBtn:@"return_icon" Highligthed:@"return_icon" Target:self Action:@selector(btnBack:)];
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelTitle.backgroundColor = [UIColor clearColor];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    self.imgViewBg = [[UIImageView alloc] initWithFrame:self.bounds];
    self.labelTitle.frame = [[self class] titleViewFrame];
    
    [self addSubview:self.imgViewBg];
    [self addSubview:self.labelTitle];

    [self addSubview:self.btnBack];
}

- (UIImage *)m_background{
    return _imgViewBg.image;
}

- (void)setM_background:(UIImage *)m_background{
    if(_imgViewBg){
        [_imgViewBg setImage:nil];
    }
    
    [_imgViewBg setImage:m_background];
}

- (void)setTitle:(NSString *)titleStr textColor:(UIColor *)color font:(UIFont *)font{
    [self.labelTitle setFont:font];
    [self.labelTitle setText:titleStr];
    [self.labelTitle setTextColor:color];

    CGSize textSize = [titleStr sizeWithAttributes:@{NSFontAttributeName: font}];
    [_labelTitle setFrame:Rect((ScreenWidth - textSize.width - 40)/2, 22.0F, textSize.width, 40.0f)];
    CGPoint jjTitle = CGPointMake(self.center.x, self.center.y + 8.0f);
    _labelTitle.center = jjTitle;
}

//- (void)setTitleImg:(NSString *)imgStr{
//    [self.titleImage setImage:[UIImage imageNamed:imgStr]];
//    [self.titleImage setFrame:Rect(_labelTitle.frame.origin.x + _labelTitle.frame.size.width, 22.0f, 40.0F, 40.0F)];
//    NSLog(@"%@", self.titleImage);
//}

- (void)setLabelTitle:(UILabel *)labelTitle{
    if(_labelTitle){
        [_labelTitle removeFromSuperview];
        _labelTitle = nil;
    }
    
    _labelTitle = labelTitle;
    if(_labelTitle){
        [_labelTitle setFrame:[[self class] titleViewFrame]];
        [self addSubview:_labelTitle];
    }
}

//-(void)setTitleImage:(UIImageView *)titleImage{
//    if(_titleImage){
//        [_titleImage removeFromSuperview];
//        _titleImage = nil;
//    }
//
//    _titleImage = titleImage;
//    [_titleImage setFrame:[[self class] titleImageViewFrame]];
//    [self addSubview:_titleImage];
//}

- (void)setLeftBtn:(UIButton *)btn{
    if(_btnLeft){
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
    }
    
    _btnLeft = btn;
    if(_btnLeft){
        [_btnLeft setFrame:[[self class] leftBtnFrame]];
        [self addSubview:_btnLeft];
    }
}

- (void)setRightBtn:(UIButton *)btn{
    if(_btnRight){
        [_btnRight removeFromSuperview];
        _btnRight = nil;
    }
    
    _btnRight = btn;
    if(_btnRight){
        [_btnRight setFrame:[[self class] rightBtnFrame]];
        [self addSubview:_btnRight];
    }
}

- (void)setLeftBtn:(UIButton *)btn withFrame:(CGRect)frame{
    if(_btnLeft){
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
    }
    
    _btnLeft = btn;
    if(_btnLeft){
        [_btnLeft setFrame:frame];
        [self addSubview:_btnLeft];
    }
}

- (void)setRightBtn:(UIButton *)btn withFrame:(CGRect)frame{
    if(_btnRight){
        [_btnRight removeFromSuperview];
        _btnRight = nil;
    }
    
    _btnRight = btn;
    if(_btnRight){
        [_btnRight setFrame:frame];
        [self addSubview:_btnRight];
    }
}

- (void)setTitleBtn:(UIButton *)titleBtn{
    if(_btnTitle){
        [_btnTitle removeFromSuperview];
        _btnTitle = nil;
    }
    
    if(_labelTitle){
        [_labelTitle removeFromSuperview];
        _labelTitle = nil;
    }
    
//    if(_titleImage){
//        [_titleImage removeFromSuperview];
//        _titleImage = nil;
//    }
    
    _btnTitle = titleBtn;
    if(_btnTitle){
        [_btnTitle setFrame:[[self class] titleBtnFrame]];
        [self addSubview:_btnTitle];
    }
}

- (void)btnBack:(id)sender{
    if(self.m_viewCtrlParent){
        [self.m_viewCtrlParent.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showCoverView:(UIView *)view
{
    [self showCoverView:view animation:NO];
}

- (void)showCoverView:(UIView *)view animation:(BOOL)bIsAnimation
{
    if (view)
    {
        [self hideOriginalBarItem:YES];
        
        [view removeFromSuperview];
        
        view.alpha = 0.4f;
        [self addSubview:view];
        if (bIsAnimation)
        {
            [UIView animateWithDuration:0.2f animations:^()
             {
                 view.alpha = 1.0f;
             }completion:^(BOOL f){}];
        }
        else
        {
            view.alpha = 1.0f;
        }
    }
}

- (void)showCoverViewOnTitleView:(UIView *)view
{
    if (view)
    {
        if (_labelTitle)
        {
            _labelTitle.hidden = YES;
        }else{}
        
        [view removeFromSuperview];
        view.frame = CGRectMake(_labelTitle.frame.origin.x + 10, _labelTitle.frame.origin.y +4, _labelTitle.frame.size.width - 20, _labelTitle.frame.size.height - 8);
        [self addSubview:view];
    }
}

- (void)hideCoverView:(UIView *)view
{
    [self hideOriginalBarItem:NO];
    if (view && (view.superview == self))
    {
        [view removeFromSuperview];
    }
}

- (void)hideOriginalBarItem:(BOOL)bIsHide
{
    if (_btnLeft)
    {
        _btnLeft.hidden = bIsHide;
    }
    
    if (_btnBack)
    {
        _btnBack.hidden = bIsHide;
    }
    
    if (_btnRight)
    {
        _btnRight.hidden = bIsHide;
    }
    
    if (_labelTitle)
    {
        _labelTitle.hidden = bIsHide;
    }
    
//    if (_titleImage)
//    {
//        _titleImage.hidden = bIsHide;
//    }
    
    if (_btnTitle)
    {
        _btnTitle.hidden = bIsHide;
    }
}

@end
