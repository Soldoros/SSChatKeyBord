//
//  SSRequestLoadingStatus.m
//  htcm
//
//  Created by soldoros on 2018/7/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSRequestLoadingStatus.h"

@implementation SSRequestLoadingStatus

//通过 承载式图 网络状态值和回调代码块初始化
-(instancetype)initWithView:(UIView *)superView statusCode:(SSRequestStatusCode)statusCode loadingBlock:(LoadingBlock)loadingBlock{
    CGRect rect = makeRect(0, 0, superView.width, superView.height);
    return [self initWithFrame:rect superView:superView statusCode:statusCode loadingBlock:loadingBlock];
}

//通过frame 承载视图 网络状态值 和 回调代码块初始化
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView statusCode:(SSRequestStatusCode)statusCode loadingBlock:(LoadingBlock)loadingBlock{
    
    return [self initWithFrame:frame superView:superView imgString:@"queshengye_shoucang" btnString:@"刷新" labString:@"加载失败！" statusCode:statusCode loadingBlock:loadingBlock];
}

//通过frame 承载视图 图片名称 按钮名称  友情提示  网络状态值和回调代码块初始化
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView imgString:(NSString *)imgString btnString:(NSString *)btnString labString:(NSString *)labString statusCode:(SSRequestStatusCode)statusCode loadingBlock:(LoadingBlock)loadingBlock{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        _superView = superView;
        [_superView addSubview:self];
        
        
        //395 * 285
        _mImgView = [UIImageView new];
        _mImgView.bounds = makeRect(0, 0, 140, 140*285/395);
        _mImgView.centerX = self.width*0.5;
        _mImgView.bottom = self.height*0.5-35;
        [self addSubview:_mImgView];
        _mImgView.image = [UIImage imageNamed:@"kongshuju"];
        
        
        _mLabel = [UILabel new];
        _mLabel.bounds = makeRect(0, 0, self.width*0.7, 60);
        _mLabel.top = _mImgView.bottom + 20;
        _mLabel.centerX  = self.width*0.5;
        _mLabel.font = makeFont(12);
        _mLabel.textColor = makeColorHex(@"#999999");
        _mLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mLabel];
        _mLabel.userInteractionEnabled = YES;
        _mLabel.numberOfLines = 3;
       
        
//        _mActivity=[[UIActivityIndicatorView alloc]initWithFrame:makeRect(0, 0, 45, 45)];
//        _mActivity.right=self.width*0.5-10;
//        _mActivity.centerY = self.height*0.5-50;
//        [_mActivity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
//        _mActivity.color = TitleColor;
//        [_mActivity setBackgroundColor:[UIColor clearColor]];
//        [self addSubview:_mActivity];
//
        
        _mActivityImg = [[UIImageView alloc]init];
        _mActivityImg.bounds = makeRect(0, 0, 32, 32);
        _mActivityImg.centerX = self.width*0.5;
        _mActivityImg.centerY = self.height*0.5-10;
        _mActivityImg.image = [[UIImage imageNamed:@"loadingGroup"] imageWithColor:TitleColor];
        [self addSubview:_mActivityImg];
        
        [self startLoadingImageAnimation];
        
        _mLoadingLab = [UILabel new];
        _mLoadingLab.bounds = makeRect(0, 0, 32, 32);
        _mLoadingLab.centerX = self.width*0.5;
        _mLoadingLab.centerY = self.height*0.5-10;
        _mLoadingLab.font = makeFont(8);
        _mLoadingLab.textColor = TitleColor;
        _mLoadingLab.textAlignment = NSTextAlignmentCenter;
        _mLoadingLab.text = @"";
        [self addSubview:_mLoadingLab];
        
        
//        _mLoadingLab = [UILabel new];
//        _mLoadingLab.bounds = makeRect(0, 0, 100, 25);
//        _mLoadingLab.font = makeFont(8);
//        _mLoadingLab.textColor = TitleColor;
//        _mLoadingLab.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_mLoadingLab];
//        _mLoadingLab.text = @"Petun";
//        [_mLoadingLab sizeToFit];
//        _mLoadingLab.centerX = _mActivityImg.centerX;
//        _mLoadingLab.centerY = _mActivityImg.centerY;
        
        
        _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mButton.bounds = makeRect(0, 0, self.width/3, 25);
        _mButton.centerX = self.centerX;
        _mButton.top = _mImgView.bottom+80;
        [self addSubview:_mButton];
        [_mButton setTitleColor:TitleColor forState:UIControlStateNormal];
        _mButton.layer.borderColor = TitleColor.CGColor;
        _mButton.layer.borderWidth = 1;
        _mButton.clipsToBounds = YES;
        _mButton.layer.cornerRadius = _mButton.height*0.5;
        _mButton.titleLabel.font = makeFont(12);
        _mButton.hidden = YES;

        

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(self.statusCode == SSRequestStatusVaule11){
                return ;
            }else{
                loadingBlock(self.statusCode);
            }
        }];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
        self.imgString = imgString;
        self.btnString = btnString;
        self.labString = labString;
        self.statusCode = statusCode;
        
    }
    return self;
}

-(void)startLoadingImageAnimation{
        
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 1;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;
        [self.mActivityImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
    });
  
}

-(void)stopLoadingImageAnimation{
    [_mActivityImg.layer removeAllAnimations];
}


-(void)setImgString:(NSString *)imgString{
    _mImgView.image = [UIImage imageNamed:imgString];
}


-(void)setBtnString:(NSString *)btnString{
    [_mButton setTitle:btnString forState:UIControlStateNormal];
}


-(void)setLabString:(NSString *)labString{
    
//    NSString *string = makeString(labString, @" 点击屏幕刷新");
    
    _mLabel.text = labString;
    [_mLabel sizeToFit];
    _mLabel.width = self.width*0.7;
    _mLabel.centerX = self.width*0.5;
}


-(void)setStatusCode:(SSRequestStatusCode)statusCode {
    _statusCode = statusCode;
    self.imgString = @"queshengye_shoucang";
    
    NSString *message = [SSRequestStatus SSRequestMessageWithStatusCode:_statusCode];
    
    _mLabel.text = message;
    [_mLabel sizeToFit];
    _mLabel.width = self.width*0.7;
    _mLabel.centerX = self.width*0.5;
    
    switch (_statusCode) {
            
            //正在加载
        case SSRequestStatusVaule11:{
            [self startLoadingImageAnimation];
            _mActivityImg.hidden = NO;
            _mLoadingLab.hidden = NO;
            _mImgView.hidden = YES;
            _mButton.hidden = YES;
            _mLabel.hidden = YES;
            
        }
            
            break;
            
            //数据为空
        case SSRequestStatusVaule12:{
            [self stopLoadingImageAnimation];
            _mActivityImg.hidden = YES;
            _mLoadingLab.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
            
            _mImgView.image = [UIImage imageNamed:@"shujukong"];
        }
            
            break;
            
            //加载失败
        case SSRequestStatusVaule13:{
            [self stopLoadingImageAnimation];
            _mActivityImg.hidden = YES;
            _mLoadingLab.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
            
            _mImgView.image = [UIImage imageNamed:@"wangluowenti"];
        }
            break;
            
            //其他情况
        default:{
            [self stopLoadingImageAnimation];
            _mActivityImg.hidden = YES;
            _mLoadingLab.hidden = YES;
            _mImgView.hidden = NO;
            _mButton.hidden = NO;
            _mLabel.hidden = NO;
        }
            break;
    }
    
    self.mButton.hidden = YES;
//    _mLoadingLab.hidden = YES;
}



@end
