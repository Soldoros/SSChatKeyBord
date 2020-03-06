//
//  SSImageGroupView.m
//  SSChatView
//
//  Created by soldoros on 2018/10/17.
//  Copyright © 2018年 soldoros. All rights reserved.
//

/*
 CGRect rect = [self.view convertRect:_button.frame fromView:_button.superview];
 
 CGRect rect = [_button.superview convertRect:_button.frame toView:self.view];
 
 */

#import "SSImageGroupView.h"





@implementation SSImageGroupCell

-(instancetype)initWithItem:(SSImageGroupItem *)item{
    if(self = [super init]){
        self.delegate = self;
        self.bouncesZoom = YES;
        self.maximumZoomScale = 3;
        self.multipleTouchEnabled = YES;
        self.alwaysBounceVertical = NO;
        self.alwaysBounceHorizontal = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.frame = [UIScreen mainScreen].bounds;
        
        _item = item;
        
        _mImageView = [[UIImageView alloc]init];
        _mImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_mImageView];
        _mImageView.image = _item.fromImage; 
        _mImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureRecognizerPressed:)];
        gesture.numberOfTapsRequired = 1;
        gesture.numberOfTouchesRequired = 1;
        [_mImageView addGestureRecognizer:gesture];
        
    }
    return self;
}


//设置frame
-(void)setImageCellFrame:(CGRect)imageCellFrame{
    _imageCellFrame = imageCellFrame;
    self.frame = _imageCellFrame;
    _mImageView.frame = self.bounds;
}

//滚动触发
- (void)layoutSubviews {
    [super layoutSubviews];
}

//缩放
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    UIView *subView = _mImageView;
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _mImageView;
}

//点击回收 10+
-(void)GestureRecognizerPressed:(UITapGestureRecognizer *)sender{
    if(_imageCelldelegate && [_imageCelldelegate respondsToSelector:@selector(SSImageGroupCellImageClick:gesture:)]){
        [_imageCelldelegate SSImageGroupCellImageClick:_item.itemTag gesture:sender];
    }
}


@end




//图片展开视图
@implementation SSImageGroupView


-(instancetype)initWithGroupItems:(NSArray *)groupItems currentItem:(NSInteger)currentItem{
    if(self = [super init]){
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        _groupItems = groupItems;
        _currentItem = currentItem;
        _currentPage = currentItem;
        _deviceTransform = NO;
        _width = [UIScreen mainScreen].bounds.size.width;
        _height = [UIScreen mainScreen].bounds.size.height;
        _deviceOrientation = UIDeviceOrientationUnknown;
        
        
        //屏幕旋转监听
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = BackGroundColor;
        [self addSubview:_backView];
        _backView.alpha = 0.01;

        _mScrollView = UIScrollView.new;
        _mScrollView.frame = self.bounds;
        _mScrollView.delegate = self;
        _mScrollView.scrollsToTop = NO;
        _mScrollView.pagingEnabled = YES;
        _mScrollView.alwaysBounceHorizontal = _groupItems.count > 1;
        _mScrollView.showsHorizontalScrollIndicator = NO;
        _mScrollView.showsVerticalScrollIndicator = NO;
        _mScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mScrollView.delaysContentTouches = NO;
        _mScrollView.canCancelContentTouches = YES;
        _mScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_mScrollView];
        
        
        _mScrollView.contentSize = CGSizeMake(_mScrollView.width * self.groupItems.count, _mScrollView.height);
        _mScrollView.contentOffset = CGPointMake(_mScrollView.width * _currentItem, 0);

        for(int i=0;i<_groupItems.count;++i){
            SSImageGroupItem *item = _groupItems[i];

            SSImageGroupCell *imageCell = [[SSImageGroupCell alloc]initWithItem:item];
            imageCell.imageCelldelegate = self;
            [_mScrollView addSubview:imageCell];

            if(i==_currentItem){
                _fromImgView = item.fromImgView;
                _fristImgView = item.fromImgView;
                imageCell.imageCellFrame =  [_mScrollView convertRect:_fromImgView.frame fromView:_fromImgView.superview];
                _fromImgView.hidden = YES;
            }else{
                imageCell.imageCellFrame = CGRectMake(i*_mScrollView.width, 0, _mScrollView.width, _mScrollView.height);
            }
        }
        
    }
    return self;
}

- (void)layoutSubviews{
    
    SSImageGroupCell *imageCell = _mScrollView.subviews[_currentItem];
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 1;
        imageCell.imageCellFrame = self.mScrollView.bounds;
    } completion:nil];
}

#pragma SSImageGroupCellImageDelegate 点击图片回收 10+
-(void)SSImageGroupCellImageClick:(NSInteger)index gesture:(UITapGestureRecognizer *)gesture{
    
    SSImageGroupCell *imageCell = _mScrollView.subviews[index-10];
    CGRect fromRect1 = [_mScrollView convertRect:_fromImgView.frame fromView:_fromImgView.superview];
    CGRect fromRect2 = [_mScrollView convertRect:_fristImgView.frame fromView:_fristImgView.superview];

    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0.01;
        if(fromRect1.origin.y!=0){
            imageCell.imageCellFrame = fromRect1;
        }else{
            imageCell.imageCellFrame = fromRect2;
            imageCell.alpha = 0.01;
        }
        
    } completion:^(BOOL finished) {
        self.fromImgView.hidden = NO;
        self.dismissBlock();
    }];
}

//滚动判断当前视图 屏幕旋转引起的位移要禁止
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(_deviceTransform==YES){
        NSLog(@"正在旋转");
        return;
    }
    CGPoint offset = scrollView.contentOffset;
    CGFloat sizeWidth = (scrollView.contentSize.width/_groupItems.count);
    _currentPage = offset.x / sizeWidth;
    NSLog(@"_currentPage = %ld",_currentPage);
}

//处理翻页
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(_currentPage!=_currentItem){
        SSImageGroupCell *imageCell = _mScrollView.subviews[_currentItem];
        if (imageCell.zoomScale>1)[imageCell setZoomScale:1 animated:YES];
        _currentItem = _currentPage;
        _fromImgView.hidden = NO;
        _fromImgView = [_groupItems[_currentItem] fromImgView];
        _fromImgView.hidden = YES;
        NSLog(@"_currentItem = %ld",_currentItem);
    }
}


//监听屏幕旋转 重新设计尺寸 支持三个方向
- (void)deviceOrientationDidChange{
    
    _deviceTransform = YES;
    UIDevice *device = [UIDevice currentDevice];
    switch (device.orientation) {
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            if(_deviceOrientation==UIDeviceOrientationPortrait||
               _deviceOrientation==UIDeviceOrientationLandscapeRight||
               _deviceOrientation==UIDeviceOrientationUnknown){
                [self landscapeLeft];
            }
            _deviceOrientation = UIDeviceOrientationLandscapeLeft;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            if(_deviceOrientation==UIDeviceOrientationLandscapeLeft||
               _deviceOrientation==UIDeviceOrientationPortrait||
               _deviceOrientation==UIDeviceOrientationUnknown){
                [self landscapeRight];
            }
            _deviceOrientation = UIDeviceOrientationLandscapeRight;
            break;
            
        case UIDeviceOrientationPortrait:
            NSLog(@"屏幕直立");
            if(_deviceOrientation==UIDeviceOrientationLandscapeLeft||
               _deviceOrientation==UIDeviceOrientationLandscapeRight){
                [self portrait];
            }
            _deviceOrientation = UIDeviceOrientationPortrait;
            break;
        default:
            _deviceTransform = NO;
            break;
    }
    
}


//屏幕左转
-(void)landscapeLeft{

    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;

    SSImageGroupCell *imageCell = self.mScrollView.subviews[self.currentItem];
    [UIView animateWithDuration:0.2f animations:^{
        
        self.mScrollView.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.mScrollView.frame = self.bounds;
        [self setScrollerViewLandscape];
        if (imageCell.zoomScale>1)[imageCell setZoomScale:1 animated:NO];
        
    } completion:^(BOOL finished) {
        self.deviceTransform = NO;
    }];
}

//屏幕右转
-(void)landscapeRight{
    
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
    
    SSImageGroupCell *imageCell = self.mScrollView.subviews[self.currentItem];
    [UIView animateWithDuration:0.2f animations:^{
        self.mScrollView.transform = CGAffineTransformMakeRotation(- M_PI_2);
        self.mScrollView.frame = CGRectMake(0, 0, self.width, self.height);
        [self setScrollerViewLandscape];
        if (imageCell.zoomScale>1)[imageCell setZoomScale:1 animated:NO];
        
    } completion:^(BOOL finished) {
        self.deviceTransform = NO;
    }];
}

//屏幕正向直立
-(void)portrait{
    
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
    
    SSImageGroupCell *imageCell = self.mScrollView.subviews[self.currentItem];
    [UIView animateWithDuration:0.2f animations:^{
        self.mScrollView.transform = CGAffineTransformMakeRotation(0);
        self.mScrollView.frame = self.bounds;
        [self setScrollerViewRestore];
        if (imageCell.zoomScale>1)[imageCell setZoomScale:1 animated:NO];
        
    } completion:^(BOOL finished) {
        self.deviceTransform = NO;
    }];
}

//横屏 设置滚动视图的内容部分和图片
-(void)setScrollerViewLandscape{
    
    _mScrollView.contentSize = CGSizeMake(_mScrollView.height*_groupItems.count, 0);
    _mScrollView.contentOffset = CGPointMake(_mScrollView.height * _currentItem, 0);
    for(int i=0;i<_mScrollView.subviews.count;++i){
        SSImageGroupCell *imageCell = _mScrollView.subviews[i];
        imageCell.imageCellFrame = CGRectMake(i*_mScrollView.height, 0, _mScrollView.height, _mScrollView.width);
    }
}

//屏幕直立恢复frame
-(void)setScrollerViewRestore{
  
    _mScrollView.contentSize = CGSizeMake(_mScrollView.width*_groupItems.count, _mScrollView.height);
    _mScrollView.contentOffset = CGPointMake(_mScrollView.width * _currentItem, 0);
    for(int i=0;i<_mScrollView.subviews.count;++i){
        SSImageGroupCell *imageCell = _mScrollView.subviews[i];
        imageCell.imageCellFrame = CGRectMake(i*_mScrollView.width, 0, _mScrollView.width, _mScrollView.height);
    }
}


@end
