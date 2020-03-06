//
//  PBSearchView.m
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "PBSearchView.h"


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
    
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchCell2BtnClick:)]){
        [_delegate PBSearchCell2BtnClick:self.indexPath];
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
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if([user arrayForKey:USER_Serchhistory]){
            _datas = [user arrayForKey:USER_Serchhistory];
            NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
            _datas = reversedArray;
        }
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
-(void)PBSearchCell2BtnClick:(NSIndexPath *)indexPath{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:[user objectForKey:USER_Serchhistory]];
    [array removeObject:_datas[indexPath.row]];
    [user setObject:array forKey:USER_Serchhistory];
    
    _datas = [user arrayForKey:USER_Serchhistory];
    NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
    _datas = reversedArray;
    
    [self.mCollectionView reloadData];
}



@end



//搜索结果header
@implementation PBSearchHeader
{
    UIButton *button1,*button2,*button3,*button4,*currentBtn;
    SearchResultState state;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        //价格升序
        state = SearchResultStateUp;
        
        UIButton *btn[4];
        NSArray *titles = @[@"分类",@"类型",@"销量",@"价格"];
        NSArray *images1 = @[@"下-hui",@"下-hui",@"",@"组-22"];
        NSArray *images2 = @[@"上",@"上",@"",@"priceshang"];
        
        for(int i=0;i<titles.count;++i){
            btn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            btn[i].bounds = makeRect(0, 0, 70, self.height-1);
            btn[i].centerX = self.width/titles.count*0.5 + i*(self.width/titles.count);
            btn[i].top = 0;
            btn[i].titleLabel.font = makeFont(16);
            [btn[i] setTitle:titles[i] forState:UIControlStateNormal];
            [btn[i] setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn[i] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self addSubview:btn[i]];
            btn[i].selected = NO;
            btn[i].tag = 10+i;
            [btn[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn[i] setImage:[UIImage imageNamed:images1[i]] forState:UIControlStateNormal];
            [btn[i] setImage:[UIImage imageNamed:images2[i]] forState:UIControlStateSelected];
            
            if(i!=2){
                [self textImage:btn[i]];
            }
            
        }
        
        button1 = btn[0];
        button2 = btn[1];
        button3 = btn[2];
        button4 = btn[3];
        
        UIView *line = [UIView new];
        line.backgroundColor = CellLineColor;
        line.bounds = makeRect(0, 0, self.width, 0.5);
        line.left = 0;
        line.bottom = self.bottom;
        [self addSubview:line];
        
    }
    return self;
}


//设置按钮的名称 并置灰
-(void)setbuttonDic:(NSDictionary *)dict{
    NSString *title = dict[_keyString];
    [currentBtn setTitle:title forState:UIControlStateNormal];
    [self textImage:currentBtn];
    if(currentBtn == button1) {
       [button2 setTitle:@"类型" forState:UIControlStateNormal];
        [self textImage:button2];
    }else{
        [button1 setTitle:@"分类" forState:UIControlStateNormal];
        [self textImage:button1];
    }
    currentBtn.selected = NO;
    currentBtn = nil;
}


//文字居左 图片居右
-(void)textImage:(UIButton *)button{
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.size.width, 0, button.imageView.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width+5, 0, -button.titleLabel.bounds.size.width)];
}


//分类10 类型11 销量12 价格13
-(void)buttonPressed:(UIButton *)sender{
    UIButton *crBtn = currentBtn;
    UIButton *sdBtn = sender;
    state = SearchResultStateUp;
    
    if(currentBtn==sender && sender==button3)return;
    
    if(sender == button1 || sender==button2){
        if(currentBtn == sender){
            currentBtn.selected = !currentBtn.selected;
        }else if(currentBtn==button4){
            currentBtn.selected = NO;
            [currentBtn setImage:[UIImage imageNamed:@"组-22"] forState:UIControlStateNormal];
            [currentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            currentBtn = sender;
            currentBtn.selected = YES;
        }else{
            currentBtn.selected = NO;
            currentBtn = sender;
            currentBtn.selected = YES;
        }
    }
    if(sender == button3){
        if(currentBtn==button4){
            currentBtn.selected = NO;
            [currentBtn setImage:[UIImage imageNamed:@"组-22"] forState:UIControlStateNormal];
            [currentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            currentBtn = sender;
            currentBtn.selected = YES;
        }
        else{
            currentBtn.selected = NO;
            currentBtn = sender;
            currentBtn.selected = YES;
        }
    }
    if(sender == button4){
        if(currentBtn==sender){
            currentBtn.selected = !currentBtn.selected;
        }else{
            currentBtn.selected = NO;
            currentBtn = sender;
            currentBtn.selected = YES;
        }
        [currentBtn setImage:[UIImage imageNamed:@"pricexia"] forState:UIControlStateNormal];
        [currentBtn setImage:[UIImage imageNamed:@"priceshang"] forState:UIControlStateSelected];
        [currentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if(currentBtn.selected == YES)state = SearchResultStateUp;
        if(currentBtn.selected == NO) state = SearchResultStateDown;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchHeaderBtnClick:currentBtn:state:)]){
        [_delegate PBSearchHeaderBtnClick:sdBtn currentBtn:crBtn state:state];
    }
}



@end








//分类 类型弹出视图
@implementation PBSearchClassTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
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
        [_mCollectionView registerClass:[PBSearchClassTypeCell class] forCellWithReuseIdentifier:@"cell"];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if([user arrayForKey:USER_Serchhistory]){
            _datas = [user arrayForKey:USER_Serchhistory];
        }
        [_mCollectionView reloadData];
    }
    return self;
    
}

-(void)setDatas:(NSArray *)datas{
    _datas =datas;
    [_mCollectionView reloadData];
    
}


#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PBSearchClassTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"cell" forIndexPath :indexPath];
    cell.backgroundColor = makeColorRgb(200, 200, 200);
    cell.keyString = _keyString;
    cell.searchDic = _datas[indexPath.row];
    return cell;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchClassTypeViewCellBtnClick:keyString:)]){
        [_delegate PBSearchClassTypeViewCellBtnClick:_datas[indexPath.row] keyString:_keyString];
    }
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

//item的尺寸
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath{
    return CGSizeMake (self.width/2,45);
}

//边界距离（上 左 下 右）
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    return UIEdgeInsetsMake ( 0 , 0 , 0 , 0 );
}

//左右间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//上下间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end





/**
 cell
 */
@implementation PBSearchClassTypeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mLab = [UILabel new];
        _mLab.frame = self.bounds;
        [self.contentView addSubview:_mLab];
        _mLab.textAlignment = NSTextAlignmentCenter;
        _mLab.font = makeFont(14);
        
    }
    return self;
}

-(void)setSearchDic:(NSDictionary *)searchDic{
    _mLab.text = searchDic[_keyString];
}


@end







//搜索医生结果cell
@implementation FoundSearchDoctorCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}






@end







@implementation FoundSearchCircle{
    UIView *_mBackView[2];
    UIImageView *_mImgView[2];
    UILabel *_mTitleLab[2];
    UIImageView *_mIcon[2];
    UILabel *_mNameLab[2];
    UIButton *_mButton[2];
    UIButton *_mLeftBtn[2];
    
    UIButton *mBtn[2];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = BackGroundColor;
        self.contentView.backgroundColor = BackGroundColor;
        
        for(int i=0;i<2;++i){
            _mBackView[i] = [UIView new];
             [self.contentView addSubview:_mBackView[i]];
             _mBackView[i].backgroundColor = [UIColor whiteColor];
             _mBackView[i].clipsToBounds = YES;
             _mBackView[i].layer.cornerRadius = 8;
             _mBackView[i].bounds = makeRect(0, 0, FoundSearchCircleW, FoundSearchCircleH-10);
             _mBackView[i].top = 0;
            
            if(i==0)_mBackView[0].left = 10;
            else _mBackView[1].right = SCREEN_Width - 10;
            

            _mImgView[i] = [UIImageView new];
               [_mBackView[i] addSubview:_mImgView[i]];
               _mImgView[i].frame = makeRect(0, 0, _mBackView[i].width, _mBackView[i].width);
               _mImgView[i].image = [UIImage imageNamed:@"yichui56"];
            _mImgView[i].userInteractionEnabled = YES;
               
            _mTitleLab[i] = [UILabel new];
               _mTitleLab[i].bounds = makeRect(0, 0, _mBackView[i].width - 16 , 20);
               [_mBackView[i] addSubview:_mTitleLab[i]];
               _mTitleLab[i].numberOfLines = 2;
               _mTitleLab[i].textColor = makeColorHex(@"#0A1117");
               _mTitleLab[i].textAlignment = NSTextAlignmentLeft;
               _mTitleLab[i].font = makeFont(13);
            _mTitleLab[i].userInteractionEnabled = YES;
               _mTitleLab[i].text = @"纽约佳士得呈献“中国古董教父”安思远珍贵藏...";
               [_mTitleLab[i] sizeToFit];
               _mTitleLab[i].top = _mImgView[i].bottom + 15;
               _mTitleLab[i].left = 8;
                  

            _mIcon[i] = [UIImageView new];
            [_mBackView[i] addSubview:_mIcon[i]];
            _mIcon[i].bounds = makeRect(0, 0, 20, 20);
            _mIcon[i].clipsToBounds = YES;
            _mIcon[i].layer.cornerRadius = 10;
            _mIcon[i].image = [UIImage imageNamed:@"headerImg"];
            _mIcon[i].left = 8;
            _mIcon[i].top = _mImgView[i].bottom + 66;
            _mIcon[i].userInteractionEnabled = YES;
            
            _mNameLab[i] = [UILabel new];
            _mNameLab[i].bounds = makeRect(0, 0, _mBackView[i].width - 16 , 20);
            [_mBackView[i] addSubview:_mNameLab[i]];
            _mNameLab[i].textColor = makeColorHex(@"#777777");
            _mNameLab[i].textAlignment = NSTextAlignmentLeft;
            _mNameLab[i].font = makeFont(11);
            _mNameLab[i].text = @"Emman";
            [_mNameLab[i] sizeToFit];
            _mNameLab[i].centerY = _mIcon[i].centerY;
            _mNameLab[i].left = _mIcon[i].right + 8;
            _mNameLab[i].userInteractionEnabled = YES;
            
            

            
            mBtn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            mBtn[i].frame = _mBackView[i].bounds;
            [_mBackView[i] addSubview:mBtn[i]];
            mBtn[i].tag = 200+i;
            [mBtn[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            
            _mButton[i] = [UIButton buttonWithType:UIButtonTypeCustom];
               [_mBackView[i] addSubview:_mButton[i]];
                _mButton[i].tag = 12+i;
                _mButton[i].bounds = makeRect(0, 0, 70, 18);
                [_mButton[i] setTitleColor:makeColorHex(@"#777777") forState:UIControlStateNormal];
                [_mButton[i] setTitle:@"直播中" forState:UIControlStateNormal];
                _mButton[i].titleLabel.font = makeFont(13);
                [_mButton[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
               _mButton[i].right = _mBackView[i].width - 10;
               _mButton[i].centerY = _mNameLab[i].centerY;
            
        }
        
        
    }
    return self;
}

//喜欢12   cell 200+
-(void)buttonPressed:(UIButton *)sender{
    
    NSDictionary *dic = _dataDic1;
    if(sender.tag == 201){
        dic = _dataDic2;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(FoundSearchCircleBtnClick:sender:dic:)]){
        [_delegate FoundSearchCircleBtnClick:_indexPath sender:sender dic:dic];
    }
}

-(void)setDataDic1:(NSDictionary *)dataDic1{
    if(dataDic1 == nil || dataDic1.count == 0){
        _mBackView[0].hidden = YES;
        return;
    }
    _mBackView[0].hidden = NO;
    _dataDic1 = dataDic1;
    
   NSString *imgString1 = [dataDic1[@"headPortrait"] imageString];
   [_mIcon[0] setImageWithURL:[NSURL URLWithString:imgString1] placeholder:[UIImage imageNamed:@"headerImg"]];
       
       
       NSString *imgString = [dataDic1[@"photo"][0] imageString];
       [_mImgView[0] setImageWithURL:[NSURL URLWithString:imgString] placeholder:[UIImage imageFromColor:BackGroundColor]];
       
       
       _mTitleLab[0].text = dataDic1[@"title"];
       [_mTitleLab[0] sizeToFit];
       _mTitleLab[0].width = _mBackView[0].width - 16;
       _mTitleLab[0].top = _mImgView[0].bottom + 15;
       _mTitleLab[0].left = 8;
       
       _mNameLab[0].text = dataDic1[@"nicname"];
       [_mNameLab[0] sizeToFit];
       _mNameLab[0].centerY = _mIcon[0].centerY;
       _mNameLab[0].left = _mIcon[0].right + 8;
       
       
       //未收藏0 已收藏1
       NSInteger  is_collection = [dataDic1[@"is_collection"]integerValue];
       NSString *likes = [dataDic1[@"likes"]description];
       [_mButton[0] setImage:[UIImage imageNamed:@"yichui209"] forState:UIControlStateNormal];
       [_mButton[0] setImage:[UIImage imageNamed:@"yichui210"] forState:UIControlStateSelected];
       [_mButton[0] setTitleColor:makeColorHex(@"#111111") forState:UIControlStateNormal];
    [self setLikesNum:likes index:0];
       
       if(is_collection == 0){
           _mButton[0].selected = NO;
       }else{
           _mButton[0].selected = YES;
       }
}

-(void)setDataDic2:(NSDictionary *)dataDic2{
    if(dataDic2 == nil || dataDic2.count == 0){
        _mBackView[1].hidden = YES;
        return;
    }
    _mBackView[1].hidden = NO;
    _dataDic2 = dataDic2;
    
    
    NSString *imgString1 = [dataDic2[@"headPortrait"] imageString];
      [_mIcon[1] setImageWithURL:[NSURL URLWithString:imgString1] placeholder:[UIImage imageNamed:@"headerImg"]];
          
          
          NSString *imgString = [dataDic2[@"photo"][0] imageString];
          [_mImgView[1] setImageWithURL:[NSURL URLWithString:imgString] placeholder:[UIImage imageNamed:@"headerImg"]];
          
          
          _mTitleLab[1].text = dataDic2[@"title"];
          [_mTitleLab[1] sizeToFit];
          _mTitleLab[1].width = _mBackView[1].width - 16;
          _mTitleLab[1].top = _mImgView[1].bottom + 15;
          _mTitleLab[1].left = 8;
          
          _mNameLab[1].text = dataDic2[@"nicname"];
          [_mNameLab[1] sizeToFit];
          _mNameLab[1].centerY = _mIcon[1].centerY;
          _mNameLab[1].left = _mIcon[1].right + 8;
          
          
          //未收藏0 已收藏1
          NSInteger  is_collection = [dataDic2[@"is_collection"]integerValue];
          NSString *likes = [dataDic2[@"likes"]description];
          [_mButton[1] setImage:[UIImage imageNamed:@"yichui209"] forState:UIControlStateNormal];
          [_mButton[1] setImage:[UIImage imageNamed:@"yichui210"] forState:UIControlStateSelected];
          [_mButton[1] setTitleColor:makeColorHex(@"#111111") forState:UIControlStateNormal];
    [self setLikesNum:likes index:1];
          
          if(is_collection == 1){
              _mButton[1].selected = NO;
          }else{
              _mButton[1].selected = YES;
          }
}

//设置收藏个数
-(void)setLikesNum:(NSString *)likes index:(NSInteger)idnex{
    
     [_mButton[idnex] setTitle:likes forState:UIControlStateNormal];
    _mButton[idnex].titleEdgeInsets = UIEdgeInsetsMake(-2, 4, 0, -4);
    _mButton[idnex].imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
    [_mButton[idnex] sizeToFit];
    _mButton[idnex].right = _mBackView[idnex].width - 15;
    _mButton[idnex].centerY = _mNameLab[idnex].centerY;
}

@end
