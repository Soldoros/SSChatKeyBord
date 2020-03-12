//
//  PBEditController.h
//  htcm1
//
//  Created by soldoros on 2018/5/21.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseController.h"


/**
 编辑类型确认

 - PBEditStyleNickname: 编辑昵称
 - PBEditStyleName: 姓名
 - PBEditStyleIntroduce: 自我介绍
 - PBEditStyleCard: 编辑身份证号
 - PBEditStyleAddress: 编辑详细地址
 - PBEditStyleShopName: 店铺名称
 - PBEditStyleLeveMsg:下单留言
 - PBEditStyleIndustry:行业
 */
typedef NS_ENUM(NSInteger,PBEditStyle) {
    PBEditStyleNickname=1,
    PBEditStyleName,
    PBEditStyleIntroduce,
    PBEditStyleCard,
    PBEditStyleAddress,
    PBEditStyleShopName,
    PBEditStyleLeveMsg,
    PBEditStyleIndustry,
    PBEditStylePatient,
};

@protocol PBEditControllerDelegate <NSObject>

-(void)PBEditControllerBtnClick:(NSString *)string style:(PBEditStyle)style;

@end

@interface PBEditController : BaseController

@property(nonatomic,assign)id<PBEditControllerDelegate>delegate;

//姓名（默认）
@property(nonatomic,assign)PBEditStyle style;

//显示单行输入框1  还是多行2
@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)NSString *editPlaceholder;







@end
