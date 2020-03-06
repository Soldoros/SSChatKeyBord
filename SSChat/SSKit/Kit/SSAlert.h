//
//  SSAlert.h
//  SSChat
//
//  Created by soldoros on 2019/4/14.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 系统提示框按钮点击回调代码块
 
 @param action 点击的action
 */
typedef void (^AlertBlock)(UIAlertAction * action);


@interface SSAlert : NSObject

+(void)pressentAlertControllerWithTitle:(NSString *)title message:(NSString *)message okButton:(NSString *)ok cancelButton:(NSString *)cancel alertBlock:(AlertBlock)alertBlock;


//返回一个红色小圆点 传给圆点直径
+(UIView *)redRoundView:(CGFloat)size;

//返回一个红色数字圆点
+(UILabel *)redNumber:(NSInteger)number;



//系统分享
+(void)shareWithSystemController:(UIViewController *)controller url:(NSString *)url;


@end

