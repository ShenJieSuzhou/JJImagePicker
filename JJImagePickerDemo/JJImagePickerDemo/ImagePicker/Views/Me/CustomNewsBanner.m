//
//  CustomNewsBanner.m
//  CoolFrame
//
//  Created by shenjie on 2017/9/18.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "CustomNewsBanner.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "JJCacheUtil.h"

@implementation CustomNewsBanner

@synthesize productsArray = _productsArray;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentIndex = _currentIndex;
@synthesize imgVLeft = _imgVLeft;
@synthesize imgVRight = _imgVRight;
@synthesize imgVCenter = _imgVCenter;
@synthesize delegate = _delegate;
@synthesize downloadBtn = _downloadBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //1.创建 UIScrollView
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        //图片视图；左边
        _imgVLeft = [[UIImageView alloc] init];
        _imgVLeft.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgVLeft];
        
        //图片视图；中间
        _imgVCenter = [[UIImageView alloc] init];
        _imgVCenter.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgVCenter];
        
        //图片视图；右边
        _imgVRight = [[UIImageView alloc] init];
        _imgVRight.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgVRight];
        
        //2.创建 UIPageControl
        _pageControl = [[UIPageControl alloc] init];
        //设置当前页指示器的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        //设置指示器的颜色
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        
        //3.添加到视图
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
        //4.下载按钮
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"ic_download"] forState:UIControlStateNormal];
        [_downloadBtn addTarget:self action:@selector(saveImgToAlbum:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_downloadBtn];
        
        [_downloadBtn bringSubviewToFront:_scrollView];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    [_scrollView setFrame:rect];
    _scrollView.contentSize = CGSizeMake(rect.size.width * 3, rect.size.height);
    [_scrollView setContentOffset:CGPointMake(rect.size.width, 0) animated:NO];
    
    //图片视图；左边
    [_imgVLeft setFrame:CGRectMake(0.0, 60.0, rect.size.width, rect.size.height - 120)];
    
    //图片视图；中间
    [_imgVCenter setFrame:CGRectMake(rect.size.width, 60.0, rect.size.width, rect.size.height - 120)];
    
    //图片视图；右边
     [_imgVRight setFrame:CGRectMake(rect.size.width * 2, 60.0, rect.size.width, rect.size.height - 120)];
    
    //2.创建 UIPageControl
    CGSize size= [_pageControl sizeForNumberOfPages:[_productsArray count]];
    _pageControl.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
    _pageControl.center = CGPointMake(rect.size.width / 2.0, rect.size.height - 20.0);
    _pageControl.numberOfPages = [_productsArray count];
    
    if([_productsArray count] == 1){
        [_pageControl setHidden:YES];
        _scrollView.scrollEnabled = NO;
    }
    
    //3.下载按钮
    [_downloadBtn setFrame:CGRectMake(rect.size.width - 80.0f, rect.size.height - 40.0f, 30.0f, 30.0f)];
}

- (void)setProductsArray:(NSMutableArray *)productsArray{
    if(!productsArray){
        return;
    }
    
    _productsArray = [productsArray copy];
    _currentIndex = 0;
    [self setDefaultImage];
}


- (void)reloadImage{
    int leftImageIndex, rightImageIndex;
    NSInteger imageCount = [_productsArray count];
    CGPoint contentOffset = [_scrollView contentOffset];
    __weak typeof(self) weakself = self;
    
    if(imageCount == 1){
        NSString *url = [_productsArray objectAtIndex:_currentIndex];
        [JJCacheUtil diskImageExistsWithUrl:url completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.imgVCenter setImage:image];
            });
        }];
        return;
    }
    
    //向右滑动
    if(contentOffset.x > self.frame.size.width){
        _currentIndex = (int)(_currentIndex + 1) % imageCount;
    }else if(contentOffset.x < self.frame.size.width){
        _currentIndex = (int)(_currentIndex - 1 + imageCount) % imageCount;
    }
    
    NSString *url = [_productsArray objectAtIndex:_currentIndex];
    [JJCacheUtil diskImageExistsWithUrl:url completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.imgVCenter setImage:image];
        });
    }];
    
    //重新设置左右图片
    leftImageIndex = (int)(_currentIndex+imageCount-1)%imageCount;
    rightImageIndex = (int)(_currentIndex+1)%imageCount;
    
    NSString *url1 = [_productsArray objectAtIndex:leftImageIndex];
    [JJCacheUtil diskImageExistsWithUrl:url1 completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.imgVLeft setImage:image];
        });
    }];
    
    NSString *url2 = [_productsArray objectAtIndex:rightImageIndex];
    [JJCacheUtil diskImageExistsWithUrl:url2 completion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.imgVRight setImage:image];
        });
    }];
}

- (void)setDefaultImage{
    int count = (int)[_productsArray count];
    __weak typeof(self) weakself = self;
    if(count == 1){
        NSString *url = [_productsArray objectAtIndex:0];
        [JJCacheUtil diskImageExistsWithUrl:url completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.imgVCenter setImage:image];
            });
        }];
    }else{
        NSString *url = [_productsArray objectAtIndex:count - 1];
        [JJCacheUtil diskImageExistsWithUrl:url completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.imgVLeft setImage:image];
            });
        }];
        
        NSString *url1 = [_productsArray objectAtIndex:0];
        [JJCacheUtil diskImageExistsWithUrl:url1 completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.imgVCenter setImage:image];
            });
        }];
        
        NSString *url2 = [_productsArray objectAtIndex:1];
        [JJCacheUtil diskImageExistsWithUrl:url2 completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.imgVRight setImage:image];
            });
        }];
    }
    _currentIndex = 0;
    _pageControl.currentPage = _currentIndex;
}

- (void)saveImgToAlbum:(id)sender{
    NSString *url = [_productsArray objectAtIndex:_currentIndex];
    [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:url] completion:^(BOOL isInCache) {
        if (isInCache) {
            NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
            UIImage *adImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
            UIImageWriteToSavedPhotosAlbum(adImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }else{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}

#pragma mark - UIScrollViewDelegate

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    //页码设置
    _pageControl.currentPage = _currentIndex;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    if([[self delegate] respondsToSelector:@selector(newsbanner:didSelectItemAtIndex:)]){
        [_delegate newsbanner:self didSelectItemAtIndex:_currentIndex];
    }
}

@end
