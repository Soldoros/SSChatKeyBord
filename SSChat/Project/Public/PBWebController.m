//
//  PBWebController.m
//  DEShop
//
//  Created by soldoros on 2017/4/26.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "PBWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SSShareViewController.h"

//WKScriptMessageHandler
@interface PBWebController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation PBWebController

-(instancetype)init{
    if(self = [super init]){
        self.webTitle = @"";
        _urlString = @"";
        _style = 1;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"title"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationBarColorImg:BackGroundColor];
    [self setNavgaionTitle:self.webTitle];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setRightOneBtnImg:@"yichui194"];
    self.navLine.hidden = YES;
    
    //以下代码适配大小
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    
    //js调用oc方法 getAppUserToken 与js里面的函数名保持一致
    WKUserContentController* userController = [[WKUserContentController alloc]init];
    [userController addUserScript:wkUScript];
    
    WKWebViewConfiguration *_webConfig = [[WKWebViewConfiguration alloc]init];
    _webConfig.userContentController = userController;

    
    _webView = [[WKWebView alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height) configuration:_webConfig];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.backgroundColor = BackGroundColor;
    _webView.scrollView.backgroundColor = BackGroundColor;
    [self.view addSubview:_webView];
    _webView.opaque = NO;
     
 
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
     if(_urlString.length != 0 && _urlString != nil){
               NSString *string = [_urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
               NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
               [_webView loadRequest:request];
           }
           else{
               NSString *path = [[NSBundle mainBundle] pathForResource:_loadPath ofType:@"html"];
               [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
           }
    
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}

//跟js交互
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
    
    
}


#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]){
        if (object == _webView){
            if(_style==2){
                [self setNavgaionTitle:_webView.title];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


 


//分享
-(void)rightBtnClick{
    
    //分享普通商品和限时抢购商品
    dispatch_async(dispatch_get_main_queue(), ^{
      
      SSShareViewController *vc = [SSShareViewController new];
      self.definesPresentationContext = YES;
        vc.urlString = self.urlString;
      vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
      [self presentViewController:vc animated:NO completion:^{
          [vc setViewAnimation];
      }];
       vc.shareViewBlock = ^(UIButton *sender) {
           
           [self showTime:@"分享成功"];
       };
    });
    
}




@end
