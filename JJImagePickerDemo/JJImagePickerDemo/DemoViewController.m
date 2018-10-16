//
//  DemoViewController.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/3.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "DemoViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface DemoViewController ()<UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *kkWebView;
@property (strong, nonatomic) UIView *header;
@end

@implementation DemoViewController
@synthesize kkWebView = _kkWebView;
@synthesize header = _header;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    [self.header setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.header];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"collectSendKey"];
    
    self.kkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80) configuration:config];
    self.kkWebView.UIDelegate = self;
    self.kkWebView.navigationDelegate = self;
    [self.view addSubview:self.kkWebView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"Cream"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.kkWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取该UIWebView的javascript上下文
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


#pragma mark - WKScriptMessageHandler
//实现js注入方法的协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if([message.name isEqualToString:@"collectSendKey"]){
        NSLog(@"%@", message.body);
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //开始加载
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    //加载完成
//    //获取该UIWebView的javascript上下文
//    JSContext *jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//
//    //这也是一种获取标题的方法。
//    JSValue *value = [jsContext evaluateScript:@"document.title"];
//    //更新标题
//    NSLog(@"%@", value.toString);
    
    NSString *jsStr = [NSString stringWithFormat:@"sendKey('%@')",@"1222222"];
    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    //网络错误
}

@end
