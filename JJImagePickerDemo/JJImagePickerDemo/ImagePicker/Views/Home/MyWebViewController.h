//
//  MyWebViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2019/5/25.
//  Copyright © 2019年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MyWebViewController : UIViewController

@property (strong, nonatomic) WKWebView *itemWebView;

- (void)loadRequest:(NSString *)url;

@end

