//
//  SSAddImgView.m
//  DEShop
//
//  Created by soldoros on 2017/5/18.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSAddImgView.h"



@implementation SSAddImgView{
    UIImageView *mImgView[100];
    UIButton *mImgBtn[100];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        //按钮、图片的尺寸
        _BtnSize =     (self.width-2*AddLRSpace-(AddImgNum-1)*AddImgLRSpace)/AddImgNum;
        _AddimgViewH = _BtnSize+2*AddTBSpace;
        
        _maxNumber = AddImgNum;
        _mAddImage = [[SSAddImage alloc]init];
        _imgPathData = [NSMutableArray new];
        _imgIds = [NSMutableArray new];

        _mAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mAddBtn.bounds = CGRectMake(0, 0, _BtnSize, _BtnSize);
        _mAddBtn.tag = 100;
        _mAddBtn.left = AddLRSpace;
        _mAddBtn.top = AddTBSpace;
        [self addSubview:_mAddBtn];
        [_mAddBtn setBackgroundImage:[UIImage imageNamed:@"addbtnimg"] forState:UIControlStateNormal];
        _mAddBtn.selected = NO;
        [_mAddBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


/// 回显
/// @param imgPathData 传入回显地址数组
-(void)setImgPathData:(NSMutableArray *)imgPathData{
    
    
    for(int i=0;i<imgPathData.count;++i){
        [_imgPathData addObject:imgPathData[i]];
        [self setImgUrl:[_imgPathData[i] imageString]];
    }
}

//图片tag从50开始
-(void)setImgUrl:(NSString *)imgUrl{
    
    NSInteger i = self.imgPathData.count-1;
    
    mImgView[i] = [UIImageView new];
    mImgView[i].frame = _mAddBtn.frame;
    [self addSubview:mImgView[i]];
    mImgView[i].userInteractionEnabled = YES;
    [mImgView[i] setImageWithURL:[NSURL URLWithString:imgUrl] placeholder:[UIImage imageWithColor:BackGroundColor]];

        
    mImgBtn[i]= [UIButton buttonWithType:UIButtonTypeCustom];
    mImgBtn[i].bounds = CGRectMake(0, 0, 20, 20);
    mImgBtn[i].top =  mImgView[i].top-8;
    mImgBtn[i].right = mImgView[i].right+8;
    mImgBtn[i].tag = i+50;
    [self addSubview:mImgBtn[i]];
    mImgBtn[i].clipsToBounds = YES;
    mImgBtn[i].layer.cornerRadius = mImgBtn[i].height*0.5;
    [mImgBtn[i] setTitle:@"-" forState:UIControlStateNormal];
    [mImgBtn[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mImgBtn[i].backgroundColor = [UIColor redColor];
//    [mImgBtn[i] setBackgroundImage:[UIImage imageNamed:@"shanchuimg"] forState:UIControlStateNormal];
    [mImgBtn[i] addTarget:self action:@selector(imgBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _mAddBtn.left = self.imgPathData.count%AddImgNum * (_BtnSize+AddImgLRSpace)+AddLRSpace;
    _mAddBtn.top  = self.imgPathData.count/AddImgNum * (_BtnSize+AddImgTBSpace)+AddTBSpace;
    
    [self setImgViwHeight];
}

//设置图片视图的高度
-(void)setImgViwHeight{
    if(_imgPathData.count<AddImgNum-1){
        self.height = _AddimgViewH ;
        self.imgheight = self.height;
        return;
    }
    
    NSInteger number = _imgPathData.count+1;
    if(_imgPathData.count == _maxNumber){
        number = _imgPathData.count;
        _mAddBtn.hidden = YES;
    }else{
        _mAddBtn.hidden = NO;
    }
    //计算图片数量加上按钮后占用的行数
    NSInteger mo = number%AddImgNum==0?0:1;
    NSInteger lines = number/AddImgNum + mo;
    self.height = AddTBSpace*2+(lines-1)*AddImgTBSpace+lines*_BtnSize;
    self.imgheight = self.height;
}

//图片按钮从50开始 红色的删除按钮
-(void)imgBtnPressed:(UIButton *)sender{
    NSInteger index = sender.tag-49;
    NSString *str = [NSString stringWithFormat:@"%@%ld%@",@"删除第",(long)index,@"张图片"];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil  message: nil  preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle:str  style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self delateImg:index];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [_mController presentViewController: alertController animated: YES completion: nil];
}

-(void)delateImg:(NSInteger)index{
    NSInteger k = _imgPathData.count-1;
    _mAddBtn.frame = mImgView[k].frame;
    [mImgView[k] removeFromSuperview];
    [mImgBtn[k] removeFromSuperview];
    mImgBtn[k] = nil;
    mImgView[k] = nil;
    
    [_imgPathData removeObjectAtIndex:index-1];
    [_imgIds removeObjectAtIndex:index-1];
    for(int i=0;i<_imgPathData.count;++i){
        [mImgView[i] setImageWithURL:_imgPathData[i] placeholder:[UIImage imageWithColor:[UIColor colorWithHexString:@"#999999"]]];
    }
    [self setImgViwHeight];
}


//添加按钮100
-(void)buttonPressed:(UIButton *)sender{
    
    if(_imgPathData.count== self.maxNumber){

        NSString *string = [NSString stringWithFormat:@"%@%d%@",@"最多上传", self.maxNumber,@"张照片"];
        
      UIAlertAction* defaultAction;
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:string preferredStyle:UIAlertControllerStyleAlert];
        
        defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        }];
        [alert addAction:defaultAction];
        
        [_mController presentViewController:alert animated:YES completion:nil];
        
        return;
    }
   
    [_mAddImage getImagePickerWithAlertController:_mController modelType:SSImagePickerModelImage pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
       

        NSData *data = [NSData dataWithContentsOfFile:(NSString *)object];
           
        UIImage * printerImg = [UIImage imageWithData:data];
        [self headerImgNetWorking:(UIImage *)printerImg];
    }];
    
}


//上传图片
-(void)headerImgNetWorking:(UIImage *)image{
    
    
    NSData *data = UIImageJPEGRepresentation(image, 0.03);
  
     NSString *url = makeString(URLContentString, URLUploadField);
       NSDictionary *dic = @{@"file":@"image"};
       
       [SSAFRequest PostWithFile:dic method:url imgData:data name:@"file" requestCode:RequestHTTP result:^(id object, NSError *error, NSURLSessionDataTask *task) {
           
           if(error){
               [self showTime:error.description];
           }else{
               NSDictionary *dd = makeDicWithJsonStr(object);
               cout(dd);
               if([dd[@"code"]integerValue] != 0){
                   [[AppDelegate sharedAppDelegate].window showTime:dd[@"msg"]];
               }else{
                   [[AppDelegate sharedAppDelegate].window showTime:dd[@"msg"]];
                   NSString *imgString = [dd[@"data"][@"src"] imageString];
                   [self.imgPathData addObject:imgString];
                   [self.imgIds addObject:dd[@"data"][@"id"]];
                   [self setImgUrl:imgString];
                   
                   if(self.delegate && [self.delegate respondsToSelector:@selector(SSAddImgViewImgPathdataChane:)]){
                       [self.delegate SSAddImgViewImgPathdataChane:self.imgIds];
                   }
               }
           }
       }];
    
}













@end
