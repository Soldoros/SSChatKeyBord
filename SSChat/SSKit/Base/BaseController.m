//
//  BaseController.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//


#import "BaseController.h"


@interface BaseController ()



@end

@implementation BaseController


-(instancetype)init{
    if(self = [super init]){
        self.isRoot = NO;
         [self initUserDatas];
    }
    return self;
}
    
-(instancetype)initWithRoot:(BOOL)root{
    if([super init]){
        self.isRoot = root;
        [self initUserDatas];
    }
    return self;
}
    
-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if([super init]){
        self.isRoot = root;
        self.titleString = title;
        [self initUserDatas];
    }
    return self;
}

-(void)initUserDatas{
    _attributeManager = [SSAttributeManager shareAttributeManager];
    _barStyle = _attributeManager.barStyle;
    _user = [NSUserDefaults standardUserDefaults];
}

-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _barStyle;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}


-(void)viewDidLoad{
    
    cout(NavBarColor);
    [super viewDidLoad];
    [self setNavgationBarColorImg:NavBarColor];
    [self setNavgationBarLine:[UIColor clearColor]];
    [self setNavgationTitleFont:makeFont(18) color:NavBarTitColor];
    if(!_isRoot){
        [self setLeftOneBtnImg:_attributeManager.leftBtnImg];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    //适配ios 11  滚动视图返回时有偏移
    for (UIView* subView in self.view.subviews){
        if([subView isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView *)subView;
            
            if (@available(iOS 11.0, *)){
                tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                tableView.scrollIndicatorInsets = tableView.contentInset;
            }
            UIScrollView *scro = (UIScrollView *)subView;
            scro.scrollIndicatorInsets = tableView.contentInset;
            
            if (@available(iOS 13.0, *)) {
                tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
            }
        }
    }
    
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = !_isRoot;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
    
    [self updateAppAttbuteInterface];
}


//刷新界面主题
-(void)updateAppAttbuteInterface{
    
    [self setNavgationBarColorImg:NavBarColor];
    [self setNavgationBarLine:_attributeManager.navLineColor];
    [self setNavgationTitleFont:makeFont(18) color:NavBarTitColor];
    
    if(_isRoot == NO){
        [self setLeftOneBtnImg:_attributeManager.leftBtnImg];
    }
    _barStyle = _attributeManager.barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
    
    NSArray *arr1 = @[@"Tab_message_nol",@"Tab_contact_nol",@"Tab_wode_nol"];
    NSArray *arr2 = @[@"Tab_message_sel",@"Tab_contact_sel",@"Tab_wode_sel"];
    NSArray *arr3 = @[@"消息",@"联系人",@"我的"];
    for(int i=0;i<3;++i){
        RootNavigationController *nav = self.tabBarController.viewControllers[i];
        [nav.viewControllers[0] setItemImg1:arr1[i] img2:arr2[i] title:arr3[i] color1:TabBarTintDefaultColor color2:TabBarTintSelectColor];
    }
}


//返回按钮
-(void)navgationButtonPressed:(UIButton *)sender{
    if([sender isEqual:self.leftBtn1]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


//回车键回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}




@end
