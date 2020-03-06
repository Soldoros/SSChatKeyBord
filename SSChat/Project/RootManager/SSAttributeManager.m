//
//  SSAttributeManager.m
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "SSAttributeManager.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>

static  NSString *Model_fontType   = @"fontType";
static  NSString *Model_themeType  = @"themeType";


static SSAttributeManager *attribute = nil;

@implementation SSAttributeManager


@synthesize    fontType      =      _fontType;
@synthesize    themeType     =      _themeType;


//初始化系统基础信息
+(SSAttributeManager *)shareAttributeManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        attribute = [[SSAttributeManager alloc]init];
    });
    return attribute;
}

-(instancetype)init{
    if(self = [super init]){
        [self regSterSDK];
        _userDefaults = [NSUserDefaults standardUserDefaults];
        self.fontType = self.fontType;
        self.themeType = self.themeType;
    }
    return self;
}


-(void)regSterSDK{
    
}

//获取字体
-(AttributeFontType)fontType{
    AttributeFontType fontType =  [_userDefaults integerForKey:Model_fontType];
    if(fontType == 0){
        cout(@"未初始化字体");
        fontType = AttributeFontMiddle;
    }
    return fontType;
}

//获取主题
-(AttributeThemeType)themeType{
    AttributeThemeType themeType = [_userDefaults integerForKey:Model_themeType];
    if(themeType == 0){
        cout(@"未初始化主题");
        themeType = AttributeThemeWhite;
    }
    return themeType;
}


//设置字体
-(void)setFontType:(AttributeFontType)fontType{
    _fontType = fontType;
    [_userDefaults setInteger:_fontType forKey:Model_fontType];
    
    switch (_fontType) {
        case AttributeFontMin:
            
            break;
        case AttributeFontMiddle:
        
        break;
        case AttributeFontMax:
        
        break;
            
        default:
            break;
    }
    
}

//设置主题
-(void)setThemeType:(AttributeThemeType)themeType{
    _themeType = themeType;
    [_userDefaults setInteger:_themeType forKey:Model_themeType];
    
    
    switch (_themeType) {

            //白色+主题绿
        case AttributeThemeWhite:{
            self.titleColor   = makeColorHex(@"#20D3B3");
            self.navBarColor  = makeColorRgb(237, 238, 239);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor blackColor];
            self.navLineColor    = makeColorHex(@"#E2E2E2");
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.tabBarTintSelectColor  = makeColorHex(@"20D3B3");
            self.barStyle = UIStatusBarStyleDefault;
            self.leftBtnImg = @"return";
        }
            break;
            //黑色
        case AttributeThemeBlack:{
            self.titleColor   = [UIColor blackColor];
            self.navBarColor  = makeColorRgb(38, 38, 38);
            self.navLineColor    = makeColorRgb(38, 38, 38);
            self.tabBarTintSelectColor  = makeColorRgb(38, 38, 38);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //蓝色
        case AttributeThemeBlue:{
            self.titleColor   = makeColorRgb(57, 152, 247);
            self.navBarColor  = makeColorRgb(57, 152, 247);
            self.navLineColor    = makeColorRgb(57, 152, 247);
            self.tabBarTintSelectColor  = makeColorRgb(57, 152, 247);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //绿色
        case AttributeThemeGreen:{
            self.titleColor   = makeColorHex(@"20D3B3");
            self.navBarColor  = makeColorHex(@"20D3B3");
            self.navLineColor    = makeColorHex(@"20D3B3");
            self.tabBarTintSelectColor  = makeColorHex(@"20D3B3");
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //红色
        case AttributeThemeRed:{
            self.titleColor   = makeColorRgb(215, 19, 28);
            self.navBarColor  = makeColorRgb(215, 19, 28);
            self.navLineColor    = makeColorRgb(215, 19, 28);
            self.tabBarTintSelectColor  = makeColorRgb(215, 19, 28);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
            //黄色
        case AttributeThemeYellow:{
            self.navBarColor  = makeColorRgb(254, 230, 88);
            self.navLineColor    = makeColorRgb(254, 230, 88);
            self.titleColor   = makeColorRgb(254, 230, 88);
            self.tabBarColor  = [UIColor whiteColor];
            self.navTintColor = [UIColor whiteColor];
            self.backGroundColor        = makeColorRgb(246, 246, 246);
            self.tabBarTintDefaultColor = makeColorHex(@"989C9E");
            self.barStyle = UIStatusBarStyleLightContent;
            self.leftBtnImg = @"yichui102";
        }
            break;
        default:{
            
        }
            break;
    }
}



@end


