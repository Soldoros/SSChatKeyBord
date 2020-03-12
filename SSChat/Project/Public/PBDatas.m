//
//  PBDatas.m
//  QuFound
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "PBDatas.h"

@implementation PBDatas

/// 保存搜索记录
/// @param string 传入搜索记录给本地单例
+(void)saveSearchHistory:(NSString *)string{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [NSMutableArray new];
    NSArray *arr = [user arrayForKey:USER_Serchhistory];
    if(arr==nil){
        [array addObject:string];
        [user setObject:array forKey:USER_Serchhistory];
        return;
    }
    [array addObjectsFromArray:arr];
    
    BOOL bu = NO;
    for(NSString *str in arr){
        if([str isEqualToString:string]){
            bu = YES;
            break;
        }
    }
    if(bu==NO){
        [array addObject:string];
    }
    if(array.count<8){
        [user setObject:array forKey:USER_Serchhistory];
        return;
    }
    for(int i=0;i<array.count-8;++i){
        [array removeObjectAtIndex:i];
    }
    [user setObject:array forKey:USER_Serchhistory];
}

/// 删除某个搜索记录
/// @param string 传入要删除的搜索记录对象
+(void)deleteSearchHistory:(NSString *)string{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:[user objectForKey:USER_Serchhistory]];
    [array removeObject:string];
    [user setObject:array forKey:USER_Serchhistory];
}


/// 获取搜索记录 返回数组
+(NSArray *)getSearchHistory{
    
    NSArray *_datas;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user arrayForKey:USER_Serchhistory]){
        _datas = [user arrayForKey:USER_Serchhistory];
        NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
        _datas = reversedArray;
    }
    return _datas;
}

@end
