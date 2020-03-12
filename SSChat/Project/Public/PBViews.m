//
//  PBViews.m
//  QuFound
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "PBViews.h"


@implementation PBSearchReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        _mLab = [UILabel new];
        _mLab.frame = makeRect(15, 0, self.width-15, self.height);
        [self addSubview:_mLab];
        _mLab.font = makeFont(16);
        _mLab.textAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

- (void)setSection:(NSInteger)section{
    if(section==0){
        _mLab.text = @"热门搜索";
    }else{
        _mLab.text = @"最近搜索";
    }
}

@end

/**
 cell
 */
@implementation PBSearchCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mLab = [UILabel new];
        _mLab.frame = self.bounds;
        [self.contentView addSubview:_mLab];
        _mLab.backgroundColor = [UIColor whiteColor];
        _mLab.clipsToBounds = YES;
        _mLab.layer.cornerRadius = self.height*0.5;
        _mLab.layer.borderColor = makeColorHex(@"999999").CGColor;
        _mLab.layer.borderWidth = 1;
        _mLab.textAlignment = NSTextAlignmentCenter;
        _mLab.font = makeFont(14);
        _mLab.textColor = makeColorHex(@"999999");
        
    }
    return self;
}

-(void)setSearchString:(NSString *)searchString{
    _searchString = searchString;
    _mLab.text = _searchString;
}

@end



/**
 cell2
 */
@implementation PBSearchCell2

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mLab = [UILabel new];
        _mLab.frame = makeRect(15, 0, SCREEN_Width-50, PBSearchCell2H);
        [self.contentView addSubview:_mLab];
        _mLab.textAlignment = NSTextAlignmentLeft;
        _mLab.font = makeFont(14);
        _mLab.textColor = makeColorHex(@"666666");
        
        _mLine = [UIView new];
        _mLine.bounds = makeRect(0, 0, SCREEN_Width-15, 0.5);
        _mLine.bottom = PBSearchCell2H;
        _mLine.left = 15;
        _mLine.backgroundColor = CellLineColor;
        [self.contentView addSubview:_mLine];
        
        UIImage *img = [UIImage imageNamed:@"guanbi"];
        _mDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mDeleteBtn.bounds = makeRect(0, 0, 15, 15);
        _mDeleteBtn.right = SCREEN_Width-20;
        _mDeleteBtn.centerY = self.height*0.5;
        [self.contentView addSubview:_mDeleteBtn];
        [_mDeleteBtn setImage:[img imageWithColor:makeColorHex(@"999999")]  forState:UIControlStateNormal];
        [_mDeleteBtn addTarget:self action:@selector(buttonPressed:)  forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)setString:(NSString *)string{
    _mLab.text = string;
}

-(void)buttonPressed:(UIButton *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(PublicCellBtnClick:sender:)]){
        [_delegate PBCellBtnClick:self.indexPath sender:sender];
    }
}


@end



@implementation PBSearchView{
    NSArray *remenDatas;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        remenDatas = @[@"邮票",@"翡翠",@"陶瓷",@"珠宝",@"乾隆工艺品"];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _mCollectionView = [[UICollectionView alloc]initWithFrame:makeRect(0, 0, self.width,self.height) collectionViewLayout:flowLayout];
        _mCollectionView.showsVerticalScrollIndicator = TRUE;
        _mCollectionView.showsHorizontalScrollIndicator = TRUE;
        _mCollectionView.dataSource = self;
        _mCollectionView.delegate = self;
        _mCollectionView.alwaysBounceVertical = YES;
        _mCollectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_mCollectionView];
        
        
        [_mCollectionView registerClass:[PBSearchCell class] forCellWithReuseIdentifier:PBSearchCellId];
        [_mCollectionView registerClass:[PBSearchCell2 class] forCellWithReuseIdentifier:PBSearchCell2Id];
        [_mCollectionView registerClass:[PBSearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        _datas = [PBDatas getSearchHistory];
        [_mCollectionView reloadData];
    }
    return self;
    
}


-(void)setSearchType:(PBSearchAllType)searchType{
    _searchType = searchType;
    
    
    switch (_searchType) {
            //藏品
        case PBSearchAllType1:
            remenDatas = @[@"邮票",@"翡翠",@"陶瓷",@"珠宝",@"乾隆工艺品"];
            break;
            //圈子
        case PBSearchAllType2:
            remenDatas = @[@"冬天",@"成都",@"旅行",@"好去处",@"古玩"];
            break;
            //医院
        case PBSearchAllType3:
            remenDatas = @[@"健康",@"内科",@"中医",@"人民医院",@"盛世",@"华西"];
            break;
            //科室
        case PBSearchAllType4:
        remenDatas = @[@"肿瘤",@"内科",@"心脏病",@"饮食",@"医生",@"外科"];
        break;
        default:
            break;
    }
    
    [self.mCollectionView reloadData];
}


#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0)return remenDatas.count;
    else return _datas.count;
}

//段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PBSearchReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.section = indexPath.section;
    return header;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
       
        PBSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier :PBSearchCellId forIndexPath :indexPath];
        cell.backgroundColor = makeColorRgb(200, 200, 200);
        cell.searchString = remenDatas[indexPath.row];
        return cell;
    }else{
        PBSearchCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier :PBSearchCell2Id forIndexPath :indexPath];
        cell.delegate = self;
        cell.string = _datas[indexPath.row];
        return cell;
    }
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    
    NSString *string = @"";
    if(indexPath.section==0)string = remenDatas[indexPath.row];
    else string = _datas[indexPath.row];
    
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchCellClick:result:)]){
        [_delegate PBSearchCellClick:indexPath result:string];
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout
//header尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){self.width,60};
}

//item的尺寸
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return CGSizeMake ((self.width-60)/3,30);
    }else{
        return CGSizeMake (SCREEN_Width, PBSearchCell2H);
    }
}

//边界距离（上 左 下 右）
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    if(section==0){
        return UIEdgeInsetsMake ( 0 , 15 , 10 , 15 );
    }else{
        return UIEdgeInsetsMake ( 0 , 0 , 0 , 0);
    }
}

//左右间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if(section==0) return 15;
    else return 0;
}

//上下间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section==0) return 15;
    else return 0;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[self getViewController].view endEditing:YES];
}


#pragma PBSearchCell2Delegate 删除最近搜索
-(void)PublicCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender{
    
    [PBDatas deleteSearchHistory:_datas[indexPath.row]];
    _datas = [PBDatas getSearchHistory];
    
    NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
    _datas = reversedArray;
    
    [self.mCollectionView reloadData];
}



@end
