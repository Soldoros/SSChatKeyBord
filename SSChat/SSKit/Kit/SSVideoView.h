//
//  SSVideoView.h
//  SSChatView
//
//  Created by soldoros on 2018/10/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SSAdd.h"
#import <AVFoundation/AVFoundation.h>
#import "SSImageGroupData.h"



/**
 图片视图的cell 适用于 gif和普通图片
 */
@interface SSImageGroupItem : NSObject

//图类型
@property(nonatomic,assign)SSImageGroupType   imageType;

//需要展示的图片 图片视图
@property(nonatomic,strong)UIImage      *fromImage;
@property(nonatomic,strong)UIImageView  *fromImgView;


//短视频路径
@property(nonatomic,strong)NSString      *videoPath;

//标签
@property(nonatomic,assign)NSInteger  itemTag;


@end





@interface SSVideoView : UIView

//展示单位
@property(nonatomic,strong)SSImageGroupItem *item;
//展示图
@property(nonatomic,strong)UIImageView   *mImageView;

//最新的视频
@property(nonatomic,strong)AVPlayer      *player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
//播放路径
@property(nonatomic,strong)NSString *videoPath;


@end



