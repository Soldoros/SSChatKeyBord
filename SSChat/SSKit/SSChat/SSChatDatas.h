//
//  SSChatDatas.h
//  SSChat
//
//  Created by soldoros on 2020/3/4.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


//cell的一些设置
#define SSChatTextCellId        @"SSChatTextCellId"
#define SSChatImageCellId       @"SSChatImageCellId"
#define SSChatVoiceCellId       @"SSChatVoiceCellId"
#define SSChatMapCellId         @"SSChatMapCellId"
#define SSChatVideoCellId       @"SSChatVideoCellId"



#define SSChatCellTop           15           //顶部距离cell
#define SSChatCellBottom        15           //底部距离cell
#define SSChatIconWH            44           //原型头像尺寸
#define SSChatIconLeft          10           //头像与左边距离
#define SSChatIconRight         10           //头像与右边距离
#define SSChatDetailLeft        10           //详情与左边距离
#define SSChatDetailRight       10           //详情与右边距离
#define SSChatTextTop           12           //文本距离详情顶部
#define SSChatTextBottom        12           //文本距离详情底部
#define SSChatTextLRS           12           //文本左右短距离
#define SSChatTextLRB           20           //文本左右长距离

//显示时间
#define SSChatTimeWidth         250          //时间宽度
#define SSChatTimeHeight        20           //时间高度
#define SSChatTimeTop           15           //时间距离顶部
#define SSChatTimeBottom        20           //时间距离底部


#define SSChatAirTop            35           //气泡距离详情顶部
#define SSChatAirLRS            10           //气泡左右短距离
#define SSChatAirBottom         10           //气泡距离详情底部
#define SSChatAirLRB            22           //气泡左右长距离
#define SSChatTimeFont          12           //时间字体
#define SSChatTextFont          17           //内容字号

#define SSChatTextLineSpacing   5            //文本行高
#define SSChatTextRowSpacing    0            //文本间距


//聊天界面的颜色
#define SSChatCellColor  makeColorRgb(246, 246, 246)

//文本颜色
#define SSChatTextColor         [UIColor blackColor]

//右侧头像的X坐标
#define SSChatIcon_RX            SCREEN_Width-SSChatIconRight-SSChatIconWH

//文本自适应限制宽度
#define SSChatTextInitWidth    SCREEN_Width*0.7-SSChatTextLRS-SSChatTextLRB

//图片最大尺寸(正方形)
#define SSChatImageMaxSize    150

//音频的最小宽度  最大宽度   高度
#define SSChatVoiceMinWidth     100
#define SSChatVoiceMaxWidth        SCREEN_Width*2/3-SSChatTextLRS-SSChatTextLRB
#define SSChatVoiceHeight       45
//音频时间字体
#define SSChatVoiceTimeFont     14
//音频波浪图案尺寸
#define SSChatVoiceImgSize      20


//地图位置宽度 高度
#define SSChatMapWidth        240
#define SSChatMapHeight       150


//短视频位置宽度 高度
#define SSChatVideoWidth        200
#define SSChatVideoHeight       150



/**
 聊天类型
 
 - SSChatConversationTypeChat:      单聊
 - SSChatConversationTypeGroupChat: 群聊
 */
typedef NS_ENUM(NSInteger, SSChatConversationType) {
    SSChatConversationTypeChat    = 1,
    SSChatConversationTypeGroupChat = 2,
};


/**
 判断消息的发送者
 
 - SSChatMessageFromMe:     我发的
 - SSChatMessageFromOther:  对方发的(单聊群里同等对待)
 - SSChatMessageFromSystem: 系统消息(提示撤销删除、商品信息等)
 */
typedef NS_ENUM(NSInteger, SSChatMessageFrom) {
    SSChatMessageFromMe    = 1,
    SSChatMessageFromOther = 2,
    SSChatMessageFromSystem
};


/**
 判断发送消息所属的类型
 - SSChatMessageTypeText:        发送文本消息
 - SSChatMessageTypeImage:       发送图片消息
 - SSChatMessageTypeGif:         发送Gif图片消息
 - SSChatMessageTypeVoice:       发送语音消息
 - SSChatMessageTypeMap:         发送地图定位
 - SSChatMessageTypeVideo:       发送小视频
 - SSChatMessageTypeRedEnvelope: 发红包
 
 - SSChatMessageTypeUndo:        撤销的消息
 - SSChatMessageTypeDelete:      删除的消息
 */
typedef NS_ENUM(NSInteger, SSChatMessageType) {
    SSChatMessageTypeText = 1,
    SSChatMessageTypeImage = 2,
    SSChatMessageTypeGif = 3,
    SSChatMessageTypeVoice = 4,
    SSChatMessageTypeMap = 5,
    SSChatMessageTypeVideo = 6,
    SSChatMessageTypeRedEnvelope = 7,
    
    SSChatMessageTypeUndo = 50,
    SSChatMessageTypeDelete = 51,
};




@interface SSChatDatas : NSObject

@end



