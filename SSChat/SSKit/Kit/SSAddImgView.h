//
//  SSAddImgView.h
//  DEShop
//
//  Created by soldoros on 2017/5/18.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSAddImage.h"

//视图宽度
#define AddImgWidth     [[UIScreen mainScreen] bounds].size.width

//左右留白
#define AddLRSpace     15
//顶部底部留白
#define AddTBSpace     15
//图片间左右留白
#define AddImgLRSpace  15
//图片间上下留白
#define AddImgTBSpace  15

//每一行4张图
#define AddImgNum       4
//最大图片数目
#define AddImgMaxNum    4

@protocol SSAddImgViewDelegate <NSObject>

//上传成功后的回调
-(void)SSAddImgViewImgPathdataChane:(NSArray *)imgPathDatas;


@end


@interface SSAddImgView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,assign)id<SSAddImgViewDelegate>delegate;

//获取图片
@property(nonatomic,strong)SSAddImage *mAddImage;

@property(nonatomic,strong)NSMutableArray *imgPathData;
@property(nonatomic,strong)NSMutableArray *imgIds;


@property(nonatomic,strong)UIButton *mAddBtn;
@property(nonatomic,strong)UIViewController *mController;
@property(nonatomic,assign)CGFloat imgheight;

//最大数量
@property(nonatomic,assign)NSInteger maxNumber;


@property(nonatomic,assign)CGFloat BtnSize;

@property(nonatomic,assign)CGFloat AddimgViewH;

@end
