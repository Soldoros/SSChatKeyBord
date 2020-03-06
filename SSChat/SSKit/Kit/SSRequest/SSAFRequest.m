//
//  SSAFRequest.m
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

/*
 
 
   
 //    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
 //    [dic setValue:@"iosApp" forKey:@"source"];
     
 
 */

#import "SSAFRequest.h"
#import "RSAUtil.h"

@implementation SSAFRequest


+(void)cancelAllRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

//设置默认请求头
+(void)setHeader:(AFHTTPSessionManager *)manager{
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}


//设置登录后的请求头
+(void)setAuthHeader:(AFHTTPSessionManager *)manager{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *header = [user valueForKey:USER_Token];
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
}


//登录过期后跳转到登录界面
+(void)setResult:(Result)result object:(id)object error:(NSError *)error task:(NSURLSessionDataTask *)task{
    NSDictionary *dic = makeDicWithJsonStr(object);
    if([dic[@"code"]integerValue] == 2){
        [[AppDelegate sharedAppDelegate].window showTime:dic[@"desc"]];
        makeUserLoginNo();
        [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@(NO)];
    }else{
        result(object,error,task);
    }
}

//用参数形式传递tocken
+(NSDictionary *)dicWithTocken:(NSDictionary *)dic{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *header = [user valueForKey:USER_Token];
    NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithDictionary:dic];
    cout(header);
    [dd setValue:header forKey:@"token"];
    
    return dd;
}


//网络请求
+(void)RequestNetWorking:(SSRequestType)requestType parameters:(id)parameters method:(NSString *)method  requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    NSString *urlString = makeString(URLContentString, method);
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    [dic setValuesForKeysWithDictionary:parameters];
    
    cout(dic);
    cout(urlString);
    SSRequestCode code = requestCode;
    code = RequestHTTP;
    switch (requestType) {
        case SSRequestPost:{
            
            [SSAFRequest postWith:dic method:urlString requestCode:code  result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestPostHeader:{
            
            [SSAFRequest postWithHedaer:dic method:urlString requestCode:code result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestGet:{
            [SSAFRequest getWith:dic method:urlString requestCode:code result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestGetHeader:{
            
            [SSAFRequest getWithHeader:dic method:urlString requestCode:code result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestPut:{
            [SSAFRequest putWith:dic method:urlString requestCode:code result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestPutHeader:{
            
            [SSAFRequest putWithHeader:dic method:urlString requestCode:code result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestDelete:{
            [SSAFRequest deleteWith:dic method:urlString requestCode:code result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
            }];
        }
            break;
        case SSRequestDeleteHeader:{
            
            [SSAFRequest deleteWithHeader:dic method:urlString requestCode:code result:^(id object, NSError *error, NSURLSessionDataTask *task) {
                [self setResult:result object:object error:error task:task];
               
            }];
        }
            break;
        default:
            break;
    }
}



//POST请求  不带表头的  上传普通参数  JSON 1   HTTP 2   其他 3
+(void)postWith:(NSDictionary *)dic method:(NSString *)method requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    [manager POST:method parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        cout(@(responses.statusCode));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求错误%@",error.userInfo);
    cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
        
    }];
    
}




// 带请求头的post 上传普通格式参数
+(void)postWithHedaer:(id)dic method:(NSString *)method  requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    //设置请求头
    [SSAFRequest setAuthHeader:manager];
    
    [manager.requestSerializer requestWithMethod:@"POST" URLString:method parameters:dic error:nil];
    
    [manager POST:method parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSString class]]){
//            NSData *data = responseObject;
            
        }
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
 
    
}



//不带表头的get请求
+(void)getWith:(NSDictionary *)dic method:(NSString *)method requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    [SSAFRequest setHeader:manager];
    
    [manager GET:method parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        [downloadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
}


// 带请求头的get请求 上传普通格式参数
+(void)getWithHeader:(NSDictionary *)dic method:(NSString *)method  requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    // 设置请求头
    [SSAFRequest setAuthHeader:manager];
  

    [manager GET:method parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        [downloadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
}


//不带表头的delete请求
+(void)deleteWith:(NSDictionary *)dic method:(NSString *)method requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    [SSAFRequest setHeader:manager];
    
    [manager DELETE:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
    
}


//带表头的delete请求
+(void)deleteWithHeader:(NSDictionary *)dic method:(NSString *)method requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    // 设置请求头
    [SSAFRequest setAuthHeader:manager];
    
    [manager DELETE:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
}



//不带表头的put请求
+(void)putWith:(NSDictionary *)dic method:(NSString *)method requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    [SSAFRequest setHeader:manager];
    
    [manager PUT:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        cout(makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]));
        result(nil,error,task);
    }];
    
}



//带表头的put请求
+(void)putWithHeader:(NSDictionary *)dic method:(NSString *)method  requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/javascript",@"text/plain", nil];
    
    //超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    // 设置请求头
    [SSAFRequest setAuthHeader:manager];
    
    [manager PUT:method parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        NSString *dd = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        cout(makeDicWithJsonStr(dd));
        cout(makeDicWithJsonStr(dd)[@"message"]);
        result(nil,error,task);
    }];
    
}




//post上传头像 带请求头  上传普通参数  JSON 1   HTTP 2   其他 3
+(void)PostWithFile:(NSDictionary *)dic method:(NSString *)method  imgData:(NSData *)imgData name:(NSString *)name requestCode:(SSRequestCode)requestCode result:(Result)result{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    // 设置请求头
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:method parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        cout(formData);
        if(imgData){
            [formData appendPartWithFileData:imgData name:name fileName:@"image.png" mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        NSDictionary *dd = makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]);
        cout(dd);
        result(nil,error,task);

    }];
    
//    [manager POST:method parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:imgData name:@"file" fileName:@"icon.png" mimeType:@"icon/png"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        [uploadProgress cout];
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        result(responseObject,nil,task);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求错误%@",error.userInfo);
//        NSDictionary *dd = makeDicWithJsonStr(error.userInfo[@"com.alamofire.serialization.response.error.data"]);
//        cout(dd);
//        result(nil,error,task);
//    }];
}


//发送多个文件 上传普通参数  JSON 1   HTTP 2   其他 3
+(void)PostWithFiles:(NSDictionary *)dic method:(NSString *)method  datas:(NSArray *)datas names:(NSArray *)names requestCode:(SSRequestCode)requestCode result:(Result)result{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 返回HTTP格式数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //传参编码格式
    if(requestCode==RequestJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else if(requestCode==RequestHTTP){
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }

    
    // 设置请求头
    [SSAFRequest setAuthHeader:manager];
    
    [manager POST:method parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        cout(formData);
        for(int i=0;i<datas.count;++i){
            NSData *data = datas[i];
            if(data){
                [formData appendPartWithFileData:data name:names[i] fileName:@"htcmImage.jpg" mimeType:@"image/png"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [uploadProgress cout];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject,nil,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求错误%@",error.userInfo);
        result(nil,error,task);
        
    }];
}





#pragma mark - 检测网络状态 共4种状态
+(void)startCheckNetStatus:(Status)netStatus{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        netStatus(status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:{
                NSLog(@"其他网络");
            }
                break;
        }
        
    }] ;
    
    [manager startMonitoring];
}


//关闭监测
+(void)stopCheckNetStatus{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}



#pragma mark - Session 下载
+(void)downloadWithUrlString:(NSString *)method progressBlock:(ProgressBlock)progressBlock downloadBlock:(DownloadBlock)downloadBlock{
    
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:[method stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //下载进度
        NSLog(@"%@",downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //下载到哪个文件夹
        NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *fileName=[cachePath stringByAppendingPathComponent:response.suggestedFilename];
        
        return [NSURL fileURLWithPath:fileName];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成了
        NSLog(@"下载完成了 %@",filePath);
        
        downloadBlock(filePath.path);
    }];
    
    // 5.启动下载任务
    [task resume];
}




+ (id)JSONObjectWithData:(NSData *)data{
    
    if (data.length == 0) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return object;
}





@end
