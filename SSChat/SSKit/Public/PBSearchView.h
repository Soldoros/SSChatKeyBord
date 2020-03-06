//
//  PBSearchView.h
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBSearchData.h"

@protocol PBSearchViewDelegate <NSObject>

//圈子搜索的cell按钮点击回调
-(void)FoundSearchCircleBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sedner dic:(NSDictionary *)dic;

-(void)PBSearchCellClick:(NSIndexPath*)indexPath result:(NSString *)result;

@end

/**
 UICollectionReusableView
 */
@interface PBSearchReusableView : UICollectionReusableView

@property(nonatomic,assign)NSInteger section;
@property(nonatomic,strong)UILabel *mLab;

@end



/**
 UICollectionViewCell
 */
#define PBSearchCellId     @"PBSearchCellId"
#define PBSearchCellH      45

@interface PBSearchCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)NSString *searchString;

@end


/**
 UICollectionViewCell
 */
#define PBSearchCell2Id    @"PBSearchCell2Id"
#define PBSearchCell2H     45

@protocol PBSearchCell2Delegate <NSObject>

-(void)PBSearchCell2BtnClick:(NSIndexPath*)indexPath;

@end

@interface PBSearchCell2 : UICollectionViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)id<PBSearchCell2Delegate>delegate;

@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)UIView  *mLine;

@property(nonatomic,strong)UIButton  *mDeleteBtn;

@end





/**
 UICollectionView
 */

@interface PBSearchView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,PBSearchCell2Delegate>

@property(nonatomic,assign)id<PBSearchViewDelegate>delegate;



@property(nonatomic,assign)PBSearchAllType searchType;

@property(nonatomic,strong)UICollectionView *mCollectionView;
@property(nonatomic,strong)NSArray *datas;

@end





/**
 搜索结果的排序

 - SearchResultStateUp: 每个属性的升序
 - SearchResultStateDown: 每个属性的降序
 */
typedef NS_ENUM(NSInteger, SearchResultState){
    SearchResultStateUp,
    SearchResultStateDown,
};

/**
 搜索结果 header
 */
@protocol PBSearchHeaderBtnDelegate <NSObject>

-(void)PBSearchHeaderBtnClick:(UIButton *)sender currentBtn:(UIButton *)currentBtn state:(SearchResultState)state;

@end
@interface PBSearchHeader : UIView

@property(nonatomic,assign)id<PBSearchHeaderBtnDelegate>delegate;
@property(nonatomic,assign)SearchResultState searchState;

//分类 类型 销量  价格
@property(nonatomic,strong)UIButton *mButton1;
@property(nonatomic,strong)UIButton *mButton2;
@property(nonatomic,strong)UIButton *mButton3;
@property(nonatomic,strong)UIButton *mButton4;

//设置分类按钮的名称
@property(nonatomic,strong)NSString *keyString;
-(void)setbuttonDic:(NSDictionary *)dict;


@end



/**
 UICollectionView
 */
@protocol PBSearchClassTypeViewDelegate <NSObject>

-(void)PBSearchClassTypeViewCellBtnClick:(NSDictionary *)dic keyString:(NSString *)keyString;

@end
@interface PBSearchClassTypeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,assign)id<PBSearchClassTypeViewDelegate>delegate;
@property(nonatomic,strong)UICollectionView *mCollectionView;
@property(nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)NSString *keyString;

@end



/**
 UICollectionViewCell
 */
@interface PBSearchClassTypeCell : UICollectionViewCell


@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)NSString *keyString;
@property(nonatomic,strong)NSDictionary *searchDic;

@end




//搜索结果展示医生的cell
#define FoundSearchDoctorCellId  @"FoundSearchDoctorCellId"
#define FoundSearchDoctorCellH   100


@interface FoundSearchDoctorCell : UITableViewCell

@property(nonatomic,strong)UIImageView *mLeftImgView;
@property(nonatomic,strong)UILabel *mNameLab;
@property(nonatomic,strong)UILabel *mJobsLab;
@property(nonatomic,strong)UILabel *mDetailLab;
@property(nonatomic,strong)UIButton *mScoreBtn;
@property(nonatomic,strong)UIButton *mNumberBtn;


@end




//搜索结果展示圈子
#define FoundSearchCircleId  @"FoundSearchCircleId"

#define FoundSearchCircleW      (SCREEN_Width - 34)/2
#define FoundSearchCircleH      FoundSearchCircleW + 120

@interface FoundSearchCircle : UITableViewCell


@property(nonatomic,assign)id<PBSearchViewDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;



@property(nonatomic,strong)NSDictionary *dataDic1;

@property(nonatomic,strong)NSDictionary *dataDic2;

//设置收藏个数
-(void)setLikesNum:(NSString *)likes index:(NSInteger)idnex;



@end



