//
//  AppDelegate.m
//  SSChat
//
//  Created by soldoros on 2020/2/28.
//  Copyright © 2020 soldoros. All rights reserved.
//


/*
 
 git  add .
 git commit –m “”


 git remote add origin https://github.com/Soldoros/SSChatKeyBord.git
 
 git clone https://github.com/Soldoros/SSChatKeyBord.git
 git pull origin master
 git push -u origin master
 
 
 */


#import "AppDelegate.h"
#import "SSConfigManager.h"
#import "SSRootManager.h"

@interface AppDelegate ()

@property(nonatomic,strong)SSConfigManager *config;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _config = [SSConfigManager shareManager];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = _config.backGroundColor;
    [self.window makeKeyAndVisible];

    [SSRootManager shareRootManager];
    
    return YES;
}

@end
