//
//  SSDeviceManager.m
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "SSDeviceManager.h"


static SSDeviceManager* device = nil;


@implementation SSDeviceManager

+(SSDeviceManager *)shareDeviceManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        device = [[SSDeviceManager alloc]init];
        [device initData];
    });
    return device;
}


-(void)initData{
    
    //默认设备
    device.deviceType = DeviceiPhone;
    device.deviceModel = Simulator;
    
    device.navBarHeight = 44;
    device.tabBarHeight = 49;
    
    //44 20
    device.statuBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    
    //64 88
    device.safeAreaTopHeight = device.statuBarHeight + 44;
    
    if(device.statuBarHeight == 20){
        device.safeAreaBottomHeight = 0;
    }else{
        device.safeAreaBottomHeight = 34;
    }
}


@end
