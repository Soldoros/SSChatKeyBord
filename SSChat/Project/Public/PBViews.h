//
//  PBViews.h
//  QuFound
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBDatas.h"

@protocol PBViewsDelegate <NSObject>

//搜索历史的cell点击回调
-(void)PBSearchCellClick:(NSIndexPath*)indexPath result:(NSString *)result;

//cell按钮点击回调
-(void)PBCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender;

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

@interface PBSearchCell2 : UICollectionViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)id<PBViewsDelegate>delegate;

@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)UIView  *mLine;

@property(nonatomic,strong)UIButton  *mDeleteBtn;

@end





/**
 UICollectionView
 */

@interface PBSearchView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,PBViewsDelegate>

@property(nonatomic,assign)id<PBViewsDelegate>delegate;



@property(nonatomic,assign)PBSearchAllType searchType;

@property(nonatomic,strong)UICollectionView *mCollectionView;
@property(nonatomic,strong)NSArray *datas;

@end
