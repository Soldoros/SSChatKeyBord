//
//  SSRootManager.m
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSRootManager.h"
#import "AccountLoginController.h"
#import "RootTabBarController.h"
#import "SSAccountManager.h"


static SSRootManager *root = nil;

@implementation SSRootManager

+(SSRootManager *)shareRootManager{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        root = [[SSRootManager alloc]init];
    });
    return root;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:NotiLoginStatusChange object:nil];
        
        SSAccountModel *model = [SSAccountManager shareManager].model;
        if(model.account.length && model.password.length){
            [self initalizeRootController:YES];
        }else{
            [self initalizeRootController:NO];
        }
    }
    return self;
}

-(void)loginStateChange:(NSNotification *)noti{
    
    BOOL isLogin = [noti.object boolValue];
    [self initalizeRootController:isLogin];
}

-(void)initalizeRootController:(BOOL)isLogin{
    if(isLogin == NO) {
        
        [SSAccountManager shareManager].model = nil;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        AccountLoginController *vc = [AccountLoginController new];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [AppDelegate sharedAppDelegate].window.rootViewController = nav;
    }else{
        
        RootTabBarController *tab = [RootTabBarController new];
        [AppDelegate sharedAppDelegate].window.rootViewController = tab;
    }
}



@end
