//
//  MineSettingController.m
//  SSChat
//
//  Created by soldoros on 2020/3/4.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "MineSettingController.h"
#import "MineSettingThemeController.h"
#import "SSAccountManager.h"

@interface MineSettingController ()

@end

@implementation MineSettingController

-(instancetype)init{
    if(self = [super init]){
        self.datas = [NSMutableArray new];
        [self.datas addObjectsFromArray:@[@[@"主题"],@[@"退出"]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"设置"];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        cell.textLabel.font = makeFont(14);
        cell.textLabel.textColor = makeColorHex(@"#333333");
    }
    cell.textLabel.text = self.datas[indexPath.section][indexPath.row];
    if([cell.textLabel.text isEqualToString:@"退出"]){
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0 && indexPath.row == 0){
        MineSettingThemeController *vc = [MineSettingThemeController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.section == 1 && indexPath.row == 0){
        [self loginOut];
    }
}

-(void)loginOut{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:@"退出登录后数据会保存，下次登录还可正常使用" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* outAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"确认退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        
        SSAccountManager *manager = [SSAccountManager shareManager];
        manager.model = nil;
        [self sendNotifCation:NotiLoginStatusChange data:@(NO)];
    }];
    
    [alert addAction:outAction];
    [alert addAction:deleteAction];
    dispatch_async(dispatch_get_main_queue(), ^{
       [self presentViewController:alert animated:YES completion:nil];
    });
}

@end
