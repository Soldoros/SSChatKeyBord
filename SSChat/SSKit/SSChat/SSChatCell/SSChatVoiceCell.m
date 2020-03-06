//
//  SSChatVoiceCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatVoiceCell.h"

@implementation SSChatVoiceCell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    
    _voiceBackView = [[UIView alloc]init];
    [self.mBackImgButton addSubview:self.voiceBackView];
    _voiceBackView.userInteractionEnabled = YES;
    _voiceBackView.backgroundColor = [UIColor clearColor];
    
    
    _mTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    _mTimeLab.textAlignment = NSTextAlignmentCenter;
    _mTimeLab.font = [UIFont systemFontOfSize:SSChatVoiceTimeFont];
    _mTimeLab.userInteractionEnabled = YES;
    _mTimeLab.backgroundColor = [UIColor clearColor];

    
    _mVoiceImg = [[UIImageView alloc]initWithFrame:CGRectMake(80, 5, 20, 20)];
    _mVoiceImg.userInteractionEnabled = YES;
    _mVoiceImg.animationDuration = 1;
    _mVoiceImg.animationRepeatCount = 0;
    _mVoiceImg.backgroundColor = [UIColor clearColor];
    
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicator.center=CGPointMake(80, 15);
    
    
    [_voiceBackView addSubview:_indicator];
    [_voiceBackView addSubview:_mVoiceImg];
    [_voiceBackView addSubview:_mTimeLab];
    
//
//    //整个列表只能有一个语音处于播放状态 通知其他正在播放的语音停止
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UUAVAudioPlayerDidFinishPlay) name:@"VoicePlayHasInterrupt" object:nil];
//    
//    //红外线感应监听
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(sensorStateChange:)
//                                                 name:UIDeviceProximityStateDidChangeNotification
//                                               object:nil];
}




//播放音频 暂停音频
-(void)buttonPressed:(UIButton *)sender{
   
    
}



@end
