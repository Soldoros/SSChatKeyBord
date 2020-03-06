//
//  SSChatBaseCell.h
//  SSChatView
//
//  Created by soldoros on 2018/10/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSChatDatas.h"

@class SSChatBaseCell;

@protocol SSChatBaseCellDelegate <NSObject>

//点击头像
-(void)SSChatHeaderImgCellClick:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

//点击文本cell
-(void)SSChatTextCellClick:(NSIndexPath*)indexPath index:(NSInteger)index dict:(NSDictionary *)dict;

//点击cell图片和短视频
-(void)SSChatImageVideoCellClick:(NSIndexPath *)indexPath dict:(NSDictionary *)dict;

//点击定位cell
-(void)SSChatMapCellClick:(NSIndexPath*)indexPath dict:(NSDictionary *)dict;

@end

@interface SSChatBaseCell : UITableViewCell


-(void)initSSChatCellUserInterface;

@property(nonatomic,assign)id<SSChatBaseCellDelegate>delegate;

@property(nonatomic, strong) NSIndexPath           *indexPath;

//头像  时间  背景按钮
@property(nonatomic, strong) UIButton *mHeaderImgBtn;
@property(nonatomic, strong) UILabel  *mMessageTimeLab;
@property(nonatomic, strong) UIButton  *mBackImgButton;

//消息按钮
-(void)buttonPressed:(UIButton *)sender;

//文本消息
@property(nonatomic, strong) UITextView     *mTextView;

//图片消息
@property(nonatomic,strong) UIImageView *mImgView;

//视频消息
@property(nonatomic,strong) UIButton *mVideoBtn;
@property(nonatomic,strong) UIImageView *mVideoImg;


@end

