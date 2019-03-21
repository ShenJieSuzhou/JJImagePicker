//
//  HomeViewController.m
//  JJImagePickerDemo
//
//  Created by silicon on 2018/10/28.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeContentmManager.h"
#import "JSONKit.h"
#import "HttpRequestUrlDefine.h"
#import "JJLoginViewController.h"
#import "LoginSessionManager.h"

#define JJDEBUG YES

@implementation HomeViewController
@synthesize kkWebView = _kkWebView;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 用户是否登录
//    if(![[LoginSessionManager getInstance] isUserLogin]){
//        [self popLoginViewController];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLoginSuccess:) name:LOGINSUCCESS_NOTIFICATION object:nil];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"getHomeData"];
    
    self.kkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:config];
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

/**
 弹出登录界面
 */
- (void)popLoginViewController{
    JJLoginViewController *jjLoginView = [JJLoginViewController new];
    [self.navigationController pushViewController:jjLoginView animated:YES];
}


- (void)receiveLoginSuccess:(NSNotification *)notify{
    NSLog(@"%s", __func__);
    [self TriggerRefresh];
}


-(void)TriggerRefresh{
    NSLog(@"11111111111111111");
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
    if([message.name isEqualToString:@"getHomeData"]){
        NSLog(@"%@", message.body);
    
        if(JJDEBUG){
            NSString *jsStr = [NSString stringWithFormat:@"sendKey('%@')",@""];
            [self.kkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                if(error){
                    NSLog(@"++++++error: %@++++++", error);
                }
            }];
        }else{
            NSMutableArray *array = [[HomeContentmManager shareInstance] getHomeContent];
            if([array count] == 0){
                return;
            }
            NSData *data = [self toJSONData:[array objectAtIndex:0]];
            NSString *jsonString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
            NSString *jsStr = [NSString stringWithFormat:@"sendKey('%@')",jsonString];
            [self.kkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                if(error){
                    NSLog(@"++++++error: %@++++++", error);
                }
            }];
        }
    }
}

-(NSData *)toJSONData:(id)theData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:0
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //开始加载
    //    [webView
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
    
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    //网络错误
}

#pragma mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
