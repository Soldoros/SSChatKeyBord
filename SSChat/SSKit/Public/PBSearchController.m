//
//  PBSearchController.m
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "PBSearchController.h"
#import "MineViews.h"

@interface PBSearchController ()<PBSearchViewDelegate,UITextFieldDelegate>

@property(nonatomic,assign)BOOL frist;
@property(nonatomic,assign)BOOL searchFrist;

//搜索状态和历史记录 历史记录数据
@property(nonatomic,strong)PBSearchView *searchView;

@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UIImageView *mSearchImg;
@property(nonatomic,strong)UITextField *searchField;

@end

@implementation PBSearchController

-(instancetype)init{
    if(self = [super init]){
        _FirstResponder = YES;
        _frist = YES;
        _searchFrist = YES;
        
        _dataId = @"";
        self.isSearch = NO;
        _searchString = @"";
        self.user = [NSUserDefaults standardUserDefaults];
      
        self.page = 1;
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)setTextFPlaceHolder:(NSString *)string{
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : makeColorHex(@"#999999")}];
    _searchField.attributedPlaceholder = placeholderString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setRightOneBtnTitle:@"取消"];
    [self.rightBtn1 setTitle:@"搜索" forState:UIControlStateSelected];
    [self.rightBtn1 setTitleColor:makeColorHex(@"999999") forState:UIControlStateNormal];
    [self.rightBtn1 setTitleColor:makeColorHex(@"999999") forState:UIControlStateSelected];
    self.rightBtn1.selected = NO;
    self.navLine.hidden = YES;
    
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.bounds = CGRectMake(0, 0, SCREEN_Width-105, 32);
    _searchBtn.left = 45;
    _searchBtn.centerY = StatuBar_Height+NavBar_Height*0.5;
    [self.navtionBar addSubview:_searchBtn];
    _searchBtn.clipsToBounds = YES;
    _searchBtn.layer.cornerRadius = _searchBtn.height * 0.5;
    [_searchBtn setBackgroundImage:[UIImage imageWithColor:makeColorHex(@"#F6F6F6")] forState:UIControlStateNormal];
    
    
     _mSearchImg = [UIImageView new];
      _mSearchImg.bounds = makeRect(0, 0, 15, 15);
      _mSearchImg.image = [UIImage imageNamed:@"sousuo"];
      [_searchBtn addSubview:_mSearchImg];
      _mSearchImg.left = 10;
      _mSearchImg.centerY = _searchBtn.height * 0.5;
    _mSearchImg.userInteractionEnabled = YES;
    
      _searchField = [UITextField new];
      _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
      _searchField.frame = makeRect(40, 0, _searchBtn.width - 50, _searchBtn.height);
      [_searchBtn addSubview:_searchField];
      _searchField.delegate = self;
      _searchField.font = [UIFont systemFontOfSize:14];
      _searchField.textColor = makeColorHex(@"#333333");
      _searchField.tintColor = makeColorHex(@"#999999");
     [self setTextFPlaceHolder:@"输入商品或品牌名称..."];
      [_searchField addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventEditingChanged];
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    self.mTableView.backgroundColor = BackGroundColor;
    self.mTableView.backgroundView.backgroundColor = BackGroundColor;
    
    [self.mTableView registerClass:@"UITableViewCell" andCellId:@"cellId"];

    
    [self.view bringSubviewToFront:self.navtionBar];
    
    
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.backgroundColor = BackGroundColor;
    self.mTableView.backgroundView.backgroundColor = BackGroundColor;
    
    
    self.mTableView.tableHeaderView = [[UIView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, 10)];
    
    
    if(_FirstResponder){
        _FirstResponder = NO;
        [_searchField becomeFirstResponder];
    }

    
   self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self searchNetworkingDic];
    }];
    self.mTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self searchNetworkingDic];
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //藏品 + 圈子
    if(_searchType == PBSearchAllType1 ||
       _searchType == PBSearchAllType2){
        if(self.datas.count % 2 == 0){
            return self.datas.count/2;
        }else{
            return self.datas.count/2 + 1;
        }
    }
    //医院
    else if(_searchType == PBSearchAllType3){
        return self.datas.count;
    }
    //科室
    else {
        return self.datas.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = self.datas[indexPath.row][@"name"];
    return cell;
}

#pragma mark - Table view data source
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_frist){
        _frist = NO;
        return;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

//点击商品回调
-(void)HomeCell6BtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender goods:(NSDictionary *)goods{
    
}


-(void)textClick:(UITextField *)textField{
    _searchString = textField.text;
    self.rightBtn1.selected = YES;
}

//是否处于输入搜索词状态 是(yes)  否(no)
-(void)setIsSearch:(BOOL)isSearch{
    _isSearch = isSearch;
    if(!_isSearch){
        [self removeSearch];
        [_searchField endEditing:YES];
        self.rightBtn1.selected = NO;
    }else{
        [self addSearchView];
    }
}


//加载搜索历史
-(void)addSearchView{
    if(!_searchView){
        _searchView = [[PBSearchView alloc]initWithFrame:self.mTableView.frame];
    }
    _searchView.delegate = self;
    _searchView.searchType = _searchType;
    [self.view addSubview:_searchView];
}

//删除搜索历史
-(void)removeSearch{
    if(_searchView){
        [_searchField endEditing:YES];
        [_searchView removeFromSuperview];
        _searchView = nil;
    }
}


//保存搜索历史
-(void)historySave{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *arr = [self.user arrayForKey:USER_Serchhistory];
    if(arr==nil){
        [array addObject:_searchField.text];
        [self.user setObject:array forKey:USER_Serchhistory];
        return;
    }
    [array addObjectsFromArray:arr];
    
    BOOL bu = NO;
    for(NSString *str in arr){
        if([str isEqualToString:_searchField.text]){
            bu = YES;
            break;
        }
    }
    if(bu==NO){
        [array addObject:_searchField.text];
    }
    if(array.count<8){
        [self.user setObject:array forKey:USER_Serchhistory];
        return;
    }
    for(int i=0;i<array.count-8;++i){
        [array removeObjectAtIndex:i];
    }
    [self.user setObject:array forKey:USER_Serchhistory];

}


//开始输入
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.isSearch = YES;
    [self textClick:_searchField];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(_searchField.text.length>0){
        [self historySave];
    }
    _searchString = _searchField.text;
}

#pragma mark PBSearchViewDelegate 开始搜索
-(void)PBSearchCellClick:(NSIndexPath *)indexPath result:(NSString *)result{

    _searchFrist = NO;
    _searchString = result;
    _searchField.text = result;
    if(_searchField.text.length>0){
        [self historySave];
    }
    [self startSearch];
}


-(void)rightBtnClick{
    
    if(self.rightBtn1.selected){
        if(_searchField.text.length>0){
            [self historySave];
        }
        _searchString = _searchField.text;
        [self startSearch];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//回车判断
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        if(_searchField.text.length>0){
            [self historySave];
        }
        _searchString = _searchField.text;
        [self startSearch];
    }
    
    return YES;
}


-(void)startSearch{
    cout(@(self.navtionBar.userInteractionEnabled));
    cout(@(self.navtionImgView.userInteractionEnabled));
    
    cout(@"开始搜索");
    [self.datas removeAllObjects];
    self.isSearch = NO;
    _searchString = [_searchString stringByReplacingOccurrencesOfString:@" " withString:@""];

    [self setLoadingStatus];
}

-(void)setLoadingStatus{
    
    [self deleteLoadingStatus];
    [self searchNetworkingDic];
    self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height) superView:self.view statusCode:SSRequestStatusVaule11 loadingBlock:nil];
}

-(void)deleteLoadingStatus{
    
    [self.loadingStatus.mActivityImg.layer removeAllAnimations];
    [self.loadingStatus removeFromSuperview];
    self.loadingStatus = nil;
}


//搜索
-(void)searchNetworkingDic{
    
    NSString *urlString = URLCollectionLists;
    NSDictionary *dic = @{@"page":@(self.page),
                         @"limit":@"10",
                         @"uid":UserId,
                         @"stop":@"",
                         @"ifi_id":@"",
                         @"is_ifi":@"",
                         @"keyword":_searchString
    };
    
    //圈子
    if(_searchType == PBSearchAllType2){
        urlString = URLArticleLists;
        dic = @{@"page":@(self.page),
                              @"limit":@"10",
                              @"type":@(1),
                              @"uid":UserId,
                              @"keyword":_searchString,
                              @"tid":@""
        };
    }
    //医院
    if(_searchType == PBSearchAllType3){
        urlString = URLHospitalLists;
        dic = @{@"page":@(self.page),
                              @"limit":@"10",
                              @"uid":UserId,
                              @"lid":@""
        };
    }
    //科室
    if(_searchType == PBSearchAllType4){
        urlString = URLHospitalDepartment;
        dic = @{@"uid":UserId,
                @"lid":_dataId
        };
    }
    
    
    [self searchNetworking:dic urlString:urlString];
}

-(void)searchNetworking:(NSDictionary *)dic urlString:(NSString *)urlString{
       
       cout(dic);
       [SSAFRequest RequestNetWorking:SSRequestPost parameters:dic method:urlString requestCode:2 result:^(id object, NSError *error, NSURLSessionDataTask *task) {
           [self.mTableView.mj_header endRefreshing];
           [self.mTableView.mj_footer endRefreshing];
           [self deleteLoadingStatus];
           
           if(error){
               self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height) superView:self.view statusCode:SSRequestStatusVaule13 loadingBlock:^(SSRequestStatusCode statusCode) {
                   [self setLoadingStatus];
               }];
           }else{
               NSDictionary *dict = makeDicWithJsonStr(object);
               cout(dict);
               if([dict[@"code"] integerValue] != 0){
                   self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height) superView:self.view statusCode:SSRequestStatusVaule13 loadingBlock:^(SSRequestStatusCode statusCode) {
                       [self setLoadingStatus];
                   }];
               }
               else{
                   if(self.page == 1){
                       [self.datas removeAllObjects];
                   }
                   [self.datas addObjectsFromArray:dict[@"data"]];
                   [self.mTableView reloadData];
                   
                   if(self.datas.count == 0){
                       self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height) superView:self.view statusCode:SSRequestStatusVaule12 loadingBlock:^(SSRequestStatusCode statusCode) {
                           [self setLoadingStatus];
                       }];
                   }
                   
               }
           }
       }];
    
}


@end
