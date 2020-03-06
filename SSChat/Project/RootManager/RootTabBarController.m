//
//  RootTabBarController.m
//  SSChat
//
//  Created by soldoros on 2019/5/12.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@property(nonatomic,strong)UIImageView *imgView;

@end

@implementation RootTabBarController


-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.selectedViewController;
}


//首页 分类  购物车 我的
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MessageController   *vc1 = [[MessageController alloc]initWithRoot:YES];
    ContactController  *vc2 = [[ContactController alloc]initWithRoot:YES];
    MineController  *vc3 = [[MineController alloc]initWithRoot:YES];
    
    RootNavigationController *nav1 = [self setNav:vc1 title:@"消息" nomImg:@"Tab_message_nol" selImg:@"Tab_message_sel"];
    RootNavigationController *nav2 = [self setNav:vc2 title:@"联系人" nomImg:@"Tab_contact_nol" selImg:@"Tab_contact_sel"];
    RootNavigationController *nav3 = [self setNav:vc3 title:@"我的" nomImg:@"Tab_wode_nol" selImg:@"Tab_wode_sel"];
    
    self.viewControllers = @[nav1,nav2,nav3];
    self.tabBar.backgroundColor = BackGroundColor;
}


-(RootNavigationController *)setNav:(BaseController *)vc title:(NSString *)title nomImg:(NSString *)img1 selImg:(NSString *)img2{
    
    [vc setItemImg1:img1 img2:img2 title:title color1:TabBarTintDefaultColor color2:TabBarTintSelectColor];
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:vc];
    return nav;
    
}


@end
