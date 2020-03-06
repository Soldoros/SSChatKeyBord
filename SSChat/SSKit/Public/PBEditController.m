//
//  PBEditController.m
//  htcm1
//
//  Created by soldoros on 2018/5/21.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "PBEditController.h"

@interface PBEditController ()<UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UITextField *topTextF;

@property(nonatomic,strong)UITextView *mTextView;


@property(nonatomic,strong)UIButton *mButton;

@end

@implementation PBEditController

-(instancetype)init{
    if(self = [super init]){
        _editPlaceholder = @"请输入文字";
        _style = PBEditStyleNickname;
        _type = 1;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)setUserInterfaceWithStyle{
    if(_style == PBEditStyleNickname){
        [self setNavgaionTitle:@"编辑昵称"];
        _editPlaceholder = @"请输入昵称";
    }
    else if(_style == PBEditStyleIntroduce){
        [self setNavgaionTitle:@"自我介绍"];
        _editPlaceholder = @"自我介绍一下吧...";
    }
    else if(_style == PBEditStyleName){
        [self setNavgaionTitle:@"编辑姓名"];
        _editPlaceholder = @"请输入姓名...";
    }
    else if(_style == PBEditStyleCard){
        [self setNavgaionTitle:@"编辑身份证号"];
        _editPlaceholder = @"请输入身份证号";
    }
    else if(_style == PBEditStyleShopName){
        [self setNavgaionTitle:@"编辑店铺名称"];
        _editPlaceholder = @"请输入店铺名称";
    }
    else if(_style == PBEditStyleAddress){
        [self setNavgaionTitle:@"详细地址"];
        _editPlaceholder = @"请输入详细地址";
    }
    else if(_style == PBEditStyleLeveMsg){
        [self setNavgaionTitle:@"编辑订单留言"];
        _editPlaceholder = @"请输入留言...";
    }
    else if(_style == PBEditStyleIndustry){
        [self setNavgaionTitle:@"编辑行业"];
        _editPlaceholder = @"请输入行业...";
    }
    else {
        [self setNavgaionTitle:@"编辑"];
        _editPlaceholder = @"请输入...";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.navLine.hidden = YES;
    [self setUserInterfaceWithStyle];
   
    
    _topView = [UIView new];
    _topView.frame = makeRect(12, SafeAreaTop_Height+28, SCREEN_Width, 50);
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    _topView.clipsToBounds = YES;
    _topView.layer.cornerRadius = _topView.height * 0.5;
    
    _topTextF = [UITextField new];
    _topTextF.frame = makeRect(20, 0, _topView.width-40, _topView.height);
    [_topView addSubview:_topTextF];
    _topTextF.delegate = self;
    _topTextF.font = [UIFont systemFontOfSize:14];
    _topTextF.textColor = makeColorHex(@"333333");
    _topTextF.attributedPlaceholder = [NSString placehodString:_editPlaceholder color:makeColorHex(@"#999999")];
    
    _mTextView = [UITextView new];
    _mTextView.frame = makeRect(10, 15, _topView.width - 30, _topView.height - 20);
    [_topView addSubview:_mTextView];
    _mTextView.textColor = makeColorHex(@"#9B9B9B");
    _mTextView.font = makeFont(15);
    _mTextView.text = @"自我介绍一下吧...";
    
      //登录
      _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
      _mButton.bounds = CGRectMake(0, 0, SCREEN_Width - 24, 45);
   
      _mButton.centerX = SCREEN_Width * 0.5;
      _mButton.tag = 100;
      _mButton.clipsToBounds = YES;
      _mButton.layer.cornerRadius = _mButton.height * 0.5;
      _mButton.backgroundColor = TitleColor;
      _mButton.titleLabel.font = [UIFont systemFontOfSize:17];
      [_mButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:_mButton];
      [_mButton setTitle:@"确认" forState:UIControlStateNormal];
    
    
    if(_type == 1){
        _mTextView.hidden = YES;
    }else{
        _topTextF.hidden = YES;
        _topView.frame = makeRect(12, SafeAreaTop_Height+28, SCREEN_Width - 24, 250);
        _topTextF.layer.cornerRadius = 10;
        _mTextView.frame = makeRect(10, 15, _topView.width - 30, _topView.height - 20);
    }
    
     _mButton.top = _topView.bottom + 32;
}

//这里只对长度做检查 限制输入32个字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string length] == 0){
        return YES;
    }
    if (range.location < 32){
        return YES;
    }
    else{
        return NO;
    }
}

-(void)buttonPressed:(UIButton *)sender{
    
    NSString *string = _topTextF.text;
    if(_style == PBEditStyleIntroduce){
        string = _mTextView.text;
    }
    if(_delegate && [_delegate respondsToSelector:@selector(PBEditControllerBtnClick:style:)]){
        [_delegate PBEditControllerBtnClick:string style:_style];
    }
    [self.navigationController popViewControllerAnimated:YES];
}





@end
