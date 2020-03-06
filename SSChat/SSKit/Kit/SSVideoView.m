//
//  SSVideoView.m
//  SSChatView
//
//  Created by soldoros on 2018/10/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSVideoView.h"


@implementation SSImageGroupItem


@end




//视频视图
@implementation SSVideoView


-(instancetype)init{
    if(self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        
        
        _mImageView = [UIImageView new];
        _mImageView.contentMode = UIViewContentModeScaleAspectFit;
        //        _mImageView.image = _superImageView.image;
        [self addSubview:_mImageView];
        
        //    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:_videoPath]];
        //    _player = [AVPlayer playerWithPlayerItem:playerItem];
        //    [_player play];
        //
        //    _playerLayer = [AVPlayerLayer new];
        //    _playerLayer.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
        //    [self.view.layer addSublayer:_playerLayer];
        //    _playerLayer.player = _player;
        
        
    }
    return self;
}


@end
