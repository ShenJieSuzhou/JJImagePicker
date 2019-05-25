//
//  HomeViewController.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomePhotosCollectionView.h"
#import "HomeTopView.h"
#import "JJPageInfo.h"
#import "HomeDetailsViewController.h"
#import "kindWarming.h"
//@interface HomeViewController : UIViewController<UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>
//@property (strong, nonatomic) WKWebView *kkWebView;
//#import <JavaScriptCore/JavaScriptCore.h>


@interface HomeViewController : UIViewController<HomePhotosViewDelegate, kindWarmingDelegate>

@property (assign) NSInteger pageIndex;

@property (strong, nonatomic) HomePhotosCollectionView *homePhotoView;

@property (strong, nonatomic) HomeTopView *homeTopView;

@property (strong, nonatomic) NSMutableArray *photoDataSource;

@property (strong, nonatomic) JJPageInfo *currentPageInfo;

@property (strong, nonatomic) kindWarming *warmingBox;

@end
