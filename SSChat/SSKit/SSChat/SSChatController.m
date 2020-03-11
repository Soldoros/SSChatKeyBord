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
        self.datas = [NSMutableArray new];
        
        for(int i=0;i<30;++i){
            [self.datas addObject:@(i)];
        }
        
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
    
    
    self.mTableView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, _backViewH);
    
//    [self.mTableView registerClass:NSClassFromString(@"SSChatTextCell") forCellReuseIdentifier:SSChatTextCellId];
//    [self.mTableView registerClass:NSClassFromString(@"SSChatImageCell") forCellReuseIdentifier:SSChatImageCellId];
//    [self.mTableView registerClass:NSClassFromString(@"SSChatVoiceCell") forCellReuseIdentifier:SSChatVoiceCellId];
//    [self.mTableView registerClass:NSClassFromString(@"SSChatMapCell") forCellReuseIdentifier:SSChatMapCellId];
//    [self.mTableView registerClass:NSClassFromString(@"SSChatVideoCell") forCellReuseIdentifier:SSChatVideoCellId];
//
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIImage *image = [UIImage imageNamed:[SSAttributeManager shareAttributeManager].chatBackImage];
//    self.mTableView.backgroundView = [[UIImageView alloc]initWithImage:image];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = makeMoreStr(@"第",makeStrWithInt(indexPath.row+1),@"行",nil);
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
        [self updateTableView:YES];
    } completion:^(BOOL finished) {
        
    }];
}


//发送文本 列表滚动至底部
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string{
    
    [self showTime:@"发送消息"];
    [self.datas addObject:@(100)];
    [self updateTableView:YES];
}

-(void)updateTableView:(BOOL)animation{
    [self.mTableView reloadData];
    if(self.datas.count>0){
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animation];
    }
}

@end
