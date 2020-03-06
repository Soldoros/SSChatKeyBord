//
//  PBWebController.h
//  DEShop
//
//  Created by soldoros on 2017/4/26.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "BaseController.h"
#import <WebKit/WebKit.h>

@interface PBWebController : BaseController

//是否做网络请求 默认不请求0  请求1
@property(nonatomic,assign)NSInteger net;
@property(nonatomic,strong)NSString *detailId;

//自定义标题(默认)1  获取网页标题2
@property(nonatomic,assign)NSInteger style;

@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,strong)NSString *loadPath;

@property(nonatomic,strong)NSString *webTitle;

@end
