//
//  SSDeviceManager.h
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 判断设备大的类型

 - iPhone: 苹果手机
 - iPodTouch: 苹果mp4设备
 - iPad: 苹果平板电脑设备
 */
typedef NS_ENUM(NSInteger,SSDeviceType) {
    DeviceiPhone=1,
    DeviceiPodTouch,
    DeviceiPad,
};


/**
 - Simulator: 模拟器
 - iPhone: 真机
 */
typedef NS_ENUM(NSInteger,SSDeviceModel) {
    
    Simulator=1,
    iPhone,
};



@interface SSDeviceManager : NSObject

+(SSDeviceManager *)shareDeviceManager;
-(void)initData;

//设备信息
@property(nonatomic,assign)SSDeviceType deviceType;
@property(nonatomic,assign)SSDeviceModel deviceModel;


//状态栏 导航栏 安全区域顶部  安全区域(iPhone X有) 标签栏
@property(nonatomic,assign)CGFloat statuBarHeight;
@property(nonatomic,assign)CGFloat navBarHeight;
@property(nonatomic,assign)CGFloat safeAreaTopHeight;
@property(nonatomic,assign)CGFloat safeAreaBottomHeight;
@property(nonatomic,assign)CGFloat tabBarHeight;



@end



