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
    
    MessageController  *vc1 = [[MessageController alloc]initWithRoot:YES];
    ContactController  *vc2 = [[ContactController alloc]initWithRoot:YES];
    MineController     *vc3 = [[MineController alloc]initWithRoot:YES];
    
    RootNavigationController *nav1 = [self setNav:vc1 index:0];
    RootNavigationController *nav2 = [self setNav:vc2 index:1];
    RootNavigationController *nav3 = [self setNav:vc3 index:2];
    
    self.viewControllers = @[nav1,nav2,nav3];
    self.tabBar.backgroundColor = BackGroundColor;
}


-(RootNavigationController *)setNav:(BaseController *)vc index:(NSInteger)index{
    
    [vc setItemIndex:index color1:TabBarTintDefaultColor color2:TabBarTintSelectColor];
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:vc];
    return nav;
    
}


@end
