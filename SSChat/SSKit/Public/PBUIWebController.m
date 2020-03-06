//
//  PBUIWebController.m
//  Petun
//
//  Created by soldoros on 2019/11/27.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "PBUIWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import <WebKit/WebKit.h>

@interface PBUIWebController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic,strong)JSContext *context;

@end

@implementation PBUIWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"网页"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //以下代码适配大小
     NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
     
     WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
     
     
     //js调用oc方法 getAppUserToken 与js里面的函数名保持一致
     WKUserContentController* userController = [[WKUserContentController alloc]init];
     [userController addScriptMessageHandler:self name:@"getAppUserToken"];
     [userController addScriptMessageHandler:self name:@"logger"];
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
    
    [self.view bringSubviewToFront:self.navtionBar];
    
    
    
}




//获取商品详情
-(void)netWorking:(NSString *)goods_code{
    
  
    NSString *urlString = URLGoodsGetGoodsInfo;
    NSDictionary *dic = @{@"goods_code":goods_code,
                          @"activity_goods_id":@"0"};
 
    cout(dic);
    [SSAFRequest RequestNetWorking:SSRequestPostHeader parameters:dic method:urlString requestCode:2 result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        
        if(error){
            [self showTime:error.description];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            if([dict[@"code"] integerValue] != 200){
                [self showTime:dict[@"desc"]];
            }
            else{
                
            }
        }
    }];
}


@end
