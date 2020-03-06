//
//  MineController.m
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "MineController.h"
#import "MineSettingController.h"

@interface MineController ()

@end

@implementation MineController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setRightOneBtnTitle:@"设置"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"我的"];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)navgationButtonPressed:(UIButton *)sender{
    if(sender.tag == 12){
        MineSettingController *vc = [MineSettingController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
