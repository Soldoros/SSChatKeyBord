//
//  SSPickerController.m
//  htcm
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSPickerController.h"





//选择日期弹窗
@implementation SSPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        
        _datas = [NSMutableArray new];
        
        _mTitleLab = [UILabel new];
        _mTitleLab.frame = makeRect(0, 0, SSPickerViewW, 50);
        [self addSubview:_mTitleLab];
        _mTitleLab.text = @"请选择日期";
        _mTitleLab.textAlignment = NSTextAlignmentCenter;
        _mTitleLab.textColor = makeColorHex(@"333333");
        _mTitleLab.font = makeBlodFont(18);
        
        
        UIView *line = [[UIView alloc]initWithFrame:makeRect(0, _mTitleLab.bottom-0.5, SSPickerViewW, 0.5)];
        line.backgroundColor = CellLineColor;
        [self addSubview:line];
        
        
        //返回按钮
        _mBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mBackBtn.bounds = makeRect(0, 0, self.width * 0.5, 45);
        _mBackBtn.left = 0;
        _mBackBtn.bottom = self.height;
        [self addSubview:_mBackBtn];
        _mBackBtn.tag = 10;
        _mBackBtn.titleLabel.font = makeFont(14);
        [_mBackBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_mBackBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mBackBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //确认
        _mOKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mOKBtn.bounds = makeRect(0, 0, self.width * 0.5, 45);
        _mOKBtn.left = _mBackBtn.right;
        _mOKBtn.bottom = self.height;
        [self addSubview:_mOKBtn];
        _mOKBtn.tag = 11;
        _mOKBtn.titleLabel.font = makeBlodFont(14);
        [_mOKBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_mOKBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mOKBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //两个按钮之间的分割线
        UIView *line2 = [[UIView alloc]init];
        line2.bounds = makeRect(0, 0, 0.5, 45);
        line2.centerX = self.width * 0.5;
        line2.bottom = self.height;
        line2.backgroundColor = CellLineColor;
        [self addSubview:line2];
        
        
        UIView *line3 = [[UIView alloc]initWithFrame:makeRect(0, _mOKBtn.top, SSPickerViewW, 0.5)];
        line3.backgroundColor = CellLineColor;
        [self addSubview:line3];
        

        _mPickerView = [UIPickerView new];
        _mPickerView.frame = makeRect(0, 45, SSPickerViewW, SSPickerViewH-_mTitleLab.height-_mBackBtn.height);
        [self addSubview:_mPickerView];
        _mPickerView.dataSource = self;
        _mPickerView.delegate = self;
        [self addSubview:_mPickerView];
        
        

    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _mTitleLab.text = title;
}

-(void)setDatas:(NSMutableArray *)datas{
    _datas = datas;
    
    //性别
    if([_mTitleLab.text isEqualToString:@"性别"]){
        [_mPickerView selectRow:0 inComponent:0 animated:YES];
    }
    //身高
    else if ([_mTitleLab.text isEqualToString:@"身高(cm)"]){
        [_mPickerView selectRow:60 inComponent:0 animated:YES];
        [_mPickerView selectRow:0 inComponent:1 animated:YES];
    }
    //体重 25-150
    else if([_mTitleLab.text isEqualToString:@"体重(kg)"]){
        [_mPickerView selectRow:20 inComponent:0 animated:YES];
        [_mPickerView selectRow:10 inComponent:1 animated:YES];
    }
    //年龄
    else if ([_mTitleLab.text isEqualToString:@"年龄(岁)"]){
        [_mPickerView selectRow:12 inComponent:0 animated:YES];
    }
    //心率
    else if ([_mTitleLab.text isEqualToString:@"心率(次/分钟)"]){
        [_mPickerView selectRow:90 inComponent:0 animated:YES];
    }
    //腰围
    else if ([_mTitleLab.text isEqualToString:@"腰围(cm)"]){
        [_mPickerView selectRow:60 inComponent:0 animated:YES];
        [_mPickerView selectRow:0 inComponent:1 animated:YES];
    }
    //臀围
    else if ([_mTitleLab.text isEqualToString:@"臀围(cm)"]){
        [_mPickerView selectRow:85 inComponent:0 animated:YES];
        [_mPickerView selectRow:0 inComponent:1 animated:YES];
    }
    //胸围
    else if ([_mTitleLab.text isEqualToString:@"胸围(cm)"]){
        [_mPickerView selectRow:85 inComponent:0 animated:YES];
        [_mPickerView selectRow:0 inComponent:1 animated:YES];
    }
    //臂围
    else if ([_mTitleLab.text isEqualToString:@"臂围(cm)"]){
        [_mPickerView selectRow:25 inComponent:0 animated:YES];
        [_mPickerView selectRow:0 inComponent:1 animated:YES];
    }
    //大腿围
    else if ([_mTitleLab.text isEqualToString:@"大腿围(cm)"]){
        [_mPickerView selectRow:50 inComponent:0 animated:YES];
        [_mPickerView selectRow:0 inComponent:1 animated:YES];
    }
    //小腿围
    else if ([_mTitleLab.text isEqualToString:@"小腿围(cm)"]){
        [_mPickerView selectRow:30 inComponent:0 animated:YES];
        [_mPickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    else{
        for(int i=0;i<datas.count;++i){
            NSArray *arr = datas[i];
            NSInteger r = arr.count/2-1;
            [_mPickerView selectRow:r inComponent:i animated:YES];
        }
    }
    
    [_mPickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource 分组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _datas.count;
}

//每个分组的行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_datas[component]count];
}

#pragma mark - UIPickerViewDelegate  行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _datas[component][row];
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    if (lbl == nil) {
        lbl = [[UILabel alloc]init];
        lbl.font = [UIFont systemFontOfSize:18];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    lbl.text = _datas[component][row];
    return lbl;
}



// 滚动选中某个分组的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _row = row;
    _component = component;
}


//返回10  确认11
-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSPickerViewBtnDidSelectRow:inComponent:sender:)]){
        [_delegate SSPickerViewBtnDidSelectRow:_row inComponent:_component sender:sender];
    }
    
}


@end







@interface SSPickerController ()

@end

@implementation SSPickerController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    _backView = [[UIView alloc]initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backView];
    _backView.alpha = 0.01;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewClick)];
    [_backView addGestureRecognizer: tap];
    
    
    _pickerView = [[SSPickerView alloc]initWithFrame:makeRect(0, 0, SSPickerViewW, SSPickerViewH)];
    _pickerView.delegate = self;
    _pickerView.centerY = SCREEN_Height*0.5;
    _pickerView.centerX = SCREEN_Width*0.5;
    _pickerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    _pickerView.title = self.titleString;
    _pickerView.datas = _datas;
    
    [self.view addSubview:_backView];
    [self.view addSubview:_pickerView];
    
}

-(void)setSSPickerViewAnimation{
    
    [UIView animateIn:_pickerView];
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _backView.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    
}


-(void)pickerViewClick{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        _backView.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        [_pickerView removeFromSuperview];
        [_backView removeFromSuperview];
        _pickerView = nil;
        _backView = nil;
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


#pragma SSDatePickerViewDelegate 返回10  确定11
-(void)SSPickerViewBtnDidSelectRow:(NSInteger)row inComponent:(NSInteger)component sender:(UIButton *)sender{
    [self pickerViewClick];
    if(sender.tag==11){
       
        NSString *string = @"";
        for(int i=0;i<_datas.count;++i){
            NSInteger row=[_pickerView.mPickerView selectedRowInComponent:i];
            NSString *str = _datas[i][row];
            if([self.titleString isEqualToString:@"充值金额"]){
                string = makeString(string, str);
            }else{
                if(i==0)string = str;
                else{
                    str = [str substringFromIndex:1];
                    string = makeString(string, str);
                }
            }
        }
        
        _pickerBlock(string);
    }
}



@end
