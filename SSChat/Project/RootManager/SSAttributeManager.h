//
//  SSAttributeManager.h
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 
 app字号设置
 
 - AttributeFontMin: 小号字体
 - AttributeFontMiddle: 中号字体
 - AttributeFontMax: 大号字体
 */
typedef NS_ENUM(NSInteger,AttributeFontType) {
    
    AttributeFontMin = 1,
    AttributeFontMiddle,
    AttributeFontMax,
};


/**
 
 app主题色设置
 
 - AttributeThemeWhite: 白色
 - AttributeThemeBlack: 黑色
 - AttributeThemeBlue: 蓝色
 - AttributeThemeGreen: 绿色
 - AttributeThemeRed: 红色
 - AttributeThemeYellow: 黄色
 */
typedef NS_ENUM(NSInteger,AttributeThemeType) {
    
    AttributeThemeWhite = 1,
    AttributeThemeBlack,
    AttributeThemeBlue,
    AttributeThemeGreen,
    AttributeThemeRed,
    AttributeThemeYellow,
};



@interface SSAttributeManager : NSObject


//初始化APP属性
+(SSAttributeManager *)shareAttributeManager;

@property(nonatomic, strong)NSUserDefaults *userDefaults;

//字号规格
@property(nonatomic, assign )AttributeFontType fontType;
//主题
@property(nonatomic, assign)AttributeThemeType  themeType;


//主题颜色
@property(nonatomic, strong)UIColor   *titleColor;
//导航栏+状态栏背景颜色
@property(nonatomic, strong)UIColor   *navBarColor;
//标签栏背景颜色
@property(nonatomic, strong)UIColor   *tabBarColor;
//导航栏图标颜色
@property(nonatomic, strong)UIColor   *navTintColor;
//标签栏图标默认状态颜色
@property(nonatomic, strong)UIColor   *tabBarTintDefaultColor;
//标签栏图标选中状态颜色
@property(nonatomic, strong)UIColor   *tabBarTintSelectColor;
//视图背景色
@property(nonatomic, strong)UIColor   *backGroundColor;
//导航栏底部线条颜色
@property(nonatomic, strong)UIColor   *navLineColor;
//状态栏文字颜色
@property(nonatomic,assign)UIStatusBarStyle barStyle;
//返回按钮图片
@property(nonatomic, strong)NSString *leftBtnImg;


//聊天背景图
@property(nonatomic, strong)NSString   *chatBackImage;


@end




