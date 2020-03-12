//
//  MineSettingThemeController.m
//  SSChat
//
//  Created by soldoros on 2020/3/4.
//  Copyright © 2020 soldoros. All rights reserved.
//

//设置主题
#import "MineSettingThemeController.h"

@interface MineSettingThemeController (){
    UIView *mView[9];
    UIButton *mButton[9];
}

@end

@implementation MineSettingThemeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"设置主题"];
    
    //白色 黑色 蓝色 绿色 红色 黄色
    UIColor *color1 = makeColorRgb(237, 238, 239);
    UIColor *color2 = makeColorRgb(38, 38, 38);
    UIColor *color3 = makeColorRgb(57, 152, 247);
    UIColor *color4 = makeColorHex(@"20D3B3");
    UIColor *color5 = makeColorRgb(215, 19, 28);
    UIColor *color6 = makeColorRgb(254, 230, 88);
    NSArray *colors = @[color1,color2,color3,color4,color5,color6];
    
    CGFloat size = SCREEN_Width/3;
    for(int i=0;i<colors.count;++i){
        
        mView[i] = [UIView new];
        mView[i].bounds = makeRect(0, 0, size, size);
        mView[i].left = i%3*size;
        mView[i].top = SafeAreaTop_Height + 150 + i/3 * size;
        [self.view addSubview:mView[i]];
        
        
        mButton[i] = [UIButton buttonWithType:UIButtonTypeCustom];
        mButton[i].bounds = makeRect(0, 0, size-20, size-20);
        mButton[i].centerX = size * 0.5;
        mButton[i].centerY = size * 0.5;
        mButton[i].clipsToBounds = YES;
        mButton[i].layer.cornerRadius = 5;
        mButton[i].backgroundColor = colors[i];
        mButton[i].titleLabel.font = makeBlodFont(55);
        [mButton[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [mView[i] addSubview:mButton[i]];
        mButton[i].tag = i + 10;
        [mButton[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if(i == [SSConfigManager shareManager].themeType-1){
            [mButton[i] setTitle:@"√" forState:UIControlStateNormal];
        }
    }
    
}


-(void)buttonPressed:(UIButton *)sender{
    
    for(int i=0;i<6;++i){
        [mButton[i] setTitle:@"" forState:UIControlStateNormal];
    }
    
    [sender setTitle:@"√" forState:UIControlStateNormal];
    [SSConfigManager shareManager].themeType = sender.tag - 9;
    
    [self viewWillAppear:YES];
}


@end
