//
//  PBSearchController.h
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//



//搜索页面
#import "BaseTableViewGroupedController.h"
#import "PBSearchView.h"


@interface PBSearchController : BaseTableViewGroupedController

//搜索藏品 医院 圈子  科室
@property(nonatomic,assign)PBSearchAllType searchType;

//科室的id
@property(nonatomic,strong)NSString *dataId;

//搜索结果
@property(nonatomic,strong)NSString *searchString;
//是否成为第一响应者
@property(nonatomic,assign)BOOL FirstResponder;
//搜索状态 是否在输入中
@property(nonatomic,assign)BOOL isSearch;




@end
