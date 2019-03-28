//
//  HomeViewController.h
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <WebKit/WebKit.h>
//#import <JavaScriptCore/JavaScriptCore.h>
#import "HomePhotosCollectionView.h"
#import "HomeTopView.h"

//@interface HomeViewController : UIViewController<UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>
//@property (strong, nonatomic) WKWebView *kkWebView;


@interface HomeViewController : UIViewController<HomePhotosViewDelegate>

@property (assign) NSInteger *pageIndex;

@property (strong, nonatomic) HomePhotosCollectionView *homePhotoView;

@property (strong, nonatomic) HomeTopView *homeTopView;

@end
