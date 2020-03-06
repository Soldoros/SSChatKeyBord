//
//  SSTableSwitchView.m
//  htcm
//
//  Created by soldoros on 2018/4/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSTableSwitchView.h"

@implementation SSTableSwitchView{
    UIButton *button[100];
    CGFloat width,height;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.buttonArr = @[];
        self.btnFont = makeFont(16);
        self.btnDefaultColor = [UIColor grayColor];
        self.btnSelectedColor = makeColorRgb(208, 167, 108);
        self.lineColor = makeColorRgb(208, 167, 108);
        width = self.width/3;
        height = self.height;
        self.buttons = [NSMutableArray new];
    }
    return self;
}

//设置线条颜色
-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _line.backgroundColor = _lineColor;
}

//设置按钮
-(void)setButtonArr:(NSArray *)buttonArr{
    
    _buttonArr = buttonArr;
    if(_buttonArr.count<=0)return;
    
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    width = self.width/_buttonArr.count;
    
    for(int i=0;i<_buttonArr.count;++i){
        button[i] = [self setButton:i];
        if(i==0){
            _currentBtn = button[i];
            _currentBtn.titleLabel.font = makeFont(16);
        }
        [_buttons addObject:button[i]];
    }
    
    _mBottomLine = [UIView new];
    _mBottomLine.bounds = makeRect(0, 0, self.width, 1);
    _mBottomLine.bottom = self.height;
    _mBottomLine.left = 0;
    _mBottomLine.backgroundColor = makeColorHex(@"F0F0F0");
    [self addSubview:_mBottomLine];
    
    
    NSString *string = _currentBtn.titleLabel.text;
    CGRect rect = [NSObject getRectWith:string width:200 font:_currentBtn.titleLabel.font spacing:0 Row:0];
    
    _line = [UIView new];
    _line.backgroundColor = _lineColor;
    _line.bounds = makeRect(0, 0, rect.size.width, 2);
    _line.centerX = width * 0.5;
    _line.bottom = height;
    [self addSubview:_line];
    
}

-(UIButton *)setButton:(NSInteger)index{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = makeRect(index*width, 0, width , height);
    [btn setTitle:_buttonArr[index] forState:UIControlStateNormal];
    [btn setTitleColor:_btnDefaultColor forState:UIControlStateNormal];
    [btn setTitleColor:_btnSelectedColor forState:UIControlStateSelected];
    btn.titleLabel.font = _btnFont;
    btn.selected = NO;
    if(index==0)btn.selected = YES;
    btn.tag = 10+index;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}

-(void)setBtnDefaultColor:(UIColor *)btnDefaultColor{
    _btnDefaultColor = btnDefaultColor;
    for(UIButton *btn in self.buttons){
        [btn setTitleColor:btnDefaultColor forState:UIControlStateNormal];
    }
}
      
-(void)setBtnSelectedColor:(UIColor *)btnSelectedColor{
    _btnSelectedColor = btnSelectedColor;
    for(UIButton *btn in self.buttons){
        [btn setTitleColor:_btnSelectedColor forState:UIControlStateSelected];
    }
}
         

//按钮点击回调10+
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender==_currentBtn)return;
    else{
        [self setIndexTableScrollSwitchView:sender];
        if(_delegate && [_delegate respondsToSelector:@selector(SSTableSwitchViewBtnClick:)]){
            [_delegate SSTableSwitchViewBtnClick:sender];
        }
    }
}


-(void)setIndexTableScrollSwitchView:(UIButton *)sender{
    
    if(sender==_currentBtn)return;
    
    else{
        
        __block __weak SSTableSwitchView *weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.currentBtn.selected = NO;
            weakSelf.currentBtn.titleLabel.font = weakSelf.btnFont;
            
            weakSelf.currentBtn = sender;
            weakSelf.currentBtn.selected = YES;
            weakSelf.currentBtn.titleLabel.font = makeFont(16);
            
            
            NSString *string = weakSelf.currentBtn.titleLabel.text;
            CGRect rect = [NSObject getRectWith:string width:200 font:weakSelf.currentBtn.titleLabel.font spacing:0 Row:0];
            weakSelf.line.width = rect.size.width;
            
            weakSelf.line.centerX = self->width*(sender.tag-10) + self->width*0.5;
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
}




@end









//我的收藏头部视图 体检套餐 文章资讯 常见疾病
@implementation SSTableScrollSwitchView{
    CGFloat itemWidth;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        itemWidth = self.width/4.5;
        
        _mScrollView = [UIScrollView new];
        _mScrollView.frame = self.bounds;
        _mScrollView.backgroundColor = [UIColor whiteColor];
        _mScrollView.pagingEnabled = NO;
        _mScrollView.delegate = self;
        [self addSubview:_mScrollView];
        _mScrollView.maximumZoomScale = 2.0;
        _mScrollView.minimumZoomScale = 0.5;
        _mScrollView.canCancelContentTouches = NO;
        _mScrollView.delaysContentTouches = YES;
        _mScrollView.showsVerticalScrollIndicator = FALSE;
        _mScrollView.showsHorizontalScrollIndicator = FALSE;
        
        
        _mSitchView = [[SSTableSwitchView alloc]initWithFrame:_mScrollView.bounds];
        _mSitchView.delegate = self;
        [_mScrollView addSubview:_mSitchView];
        _mSitchView.mBottomLine.hidden = YES;
        
        
        //        _mBottomLine = [UIView new];
        //        _mBottomLine.bounds = makeRect(0, 0, self.width, 0.5);
        //        _mBottomLine.top = self.height;
        //        _mBottomLine.left = 0;
        //        _mBottomLine.backgroundColor = makeColorHex(@"E6E6E6");
        //        [self addSubview:_mBottomLine];
        
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    
    CGFloat width  = array.count *  itemWidth;
    if(width<self.width)width = self.width;
    
    _mScrollView.contentSize=CGSizeMake(width,_mScrollView.height);
    
    _mSitchView.frame = makeRect(0, 0, _mScrollView.contentSize.width, _mScrollView.contentSize.height);
    
    _mSitchView.buttonArr = array;
    
}


-(void)SSTableSwitchViewBtnClick:(UIButton *)sender{
    
    NSInteger index = sender.tag-11;
    if(index<0)index=0;
    
    CGPoint point = CGPointMake(index*itemWidth, 0);
    if(point.x>_mScrollView.contentSize.width-_mScrollView.width){
        point.x = _mScrollView.contentSize.width-_mScrollView.width;
    }
    [_mScrollView setContentOffset:point animated:YES];
    
    
    if(_delegate && [_delegate respondsToSelector:@selector(SSTableScrollSwitchViewBtnClick:)]){
        [_delegate SSTableScrollSwitchViewBtnClick:sender];
    }
    
}


-(void)setIndexTableScrollSwitchView:(UIButton *)sender{
    [_mSitchView setIndexTableScrollSwitchView:sender];
    [self SSTableSwitchViewBtnClick:sender];
}

@end




