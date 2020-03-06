//
//  SSImageGroupData.h
//  SSChatView
//
//  Created by soldoros on 2018/11/8.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 展示图类型
 
 - SSImageGroupImage: 图片
 - SSImageGroupVideo: 短视频
 */
typedef NS_ENUM(NSInteger, SSImageGroupType) {
    SSImageGroupImage = 1,
    SSImageGroupVideo ,
};



@interface SSImageGroupData : NSObject

@end


