//
//  SSChatController.m
//  SSChat
//
//  Created by soldoros on 2020/3/4.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "SSChatController.h"
#import "SSChatKeyBoardInputView.h"
#import "SSChatBaseCell.h"

@interface SSChatController ()<SSChatKeyBoardInputViewDelegate>

@property(nonatomic,strong)SSChatKeyBoardInputView *keyBordView;
@property(nonatomic,assign)CGFloat   backViewH;

@end

@implementation SSChatController

-(instancetype)init{
    if(self = [super init]){
        _backViewH = SCREEN_Height - SafeAreaBottom_Height - SSChatKeyBoardInputViewH;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"chat"];

    _keyBordView = [SSChatKeyBoardInputView new];
    _keyBordView.delegate = self;
    [self.view addSubview:_keyBordView];
    
    cout(@(SCREEN_Height));
    cout(@(MainViewSub_Height));
    cout(@(_backViewH));
    self.mTableView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, _backViewH);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIImage *image = [UIImage imageNamed:[SSAttributeManager shareAttributeManager].chatBackImage];
//    self.mTableView.backgroundView = [[UIImageView alloc]initWithImage:image];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [_keyBordView SetSSChatKeyBoardInputViewEndEditing];
   
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_keyBordView SetSSChatKeyBoardInputViewEndEditing];
}

#pragma SSChatKeyBoardInputViewDelegate 底部输入框代理回调
//点击按钮视图frame发生变化 调整当前列表frame
-(void)SSChatKeyBoardInputViewHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime{
 
    CGFloat height = _backViewH - keyBoardHeight;
    [UIView animateWithDuration:changeTime animations:^{
        self.mTableView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, height);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:19 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
}


//发送文本 列表滚动至底部
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string{
    
    [self showTime:@"发送消息"];
}

@end
