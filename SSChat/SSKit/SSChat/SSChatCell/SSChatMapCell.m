//
//  SSChatMapCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatMapCell.h"

@implementation SSChatMapCell

-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
 
    _mTitleLab = [UILabel new];
    _mTitleLab.bounds = CGRectMake(0, 0, 120, 25);
    _mTitleLab.font = [UIFont systemFontOfSize:16];
    _mTitleLab.textColor = [UIColor blackColor];
    _mTitleLab.textAlignment = NSTextAlignmentLeft;
    [self.mBackImgButton addSubview:_mTitleLab];
    
    
    _mDetaiLLab = [UILabel new];
    _mDetaiLLab.bounds = CGRectMake(0, 0, 120, 25);
    _mDetaiLLab.font = [UIFont systemFontOfSize:12];
    _mDetaiLLab.textColor = [UIColor lightGrayColor];
    _mDetaiLLab.textAlignment = NSTextAlignmentLeft;
    [self.mBackImgButton addSubview:_mDetaiLLab];
    
    
    _mLine = [UIView new];
    _mLine.bounds = CGRectMake(0, 0, 200, 0.8);
    _mLine.backgroundColor = [UIColor colorWithRed:235 / 255.0f green: 235 / 255.0f blue:235 / 255.0f alpha:1];
     [self.mBackImgButton addSubview:_mLine];
    
    
    //初始化地图
    _mMapView = [MKMapView new];
    _mMapView.delegate = self;
    _mMapView.mapType = MKMapTypeStandard;
    _mMapView.showsUserLocation = YES;
    _mMapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.mBackImgButton addSubview:_mMapView];
    
    
    _mMapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mBackImgButton addSubview:_mMapButton];
    [_mMapButton addTarget:self action:@selector(mapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}



-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) {
        pinView = [[MKPinAnnotationView alloc]  initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    pinView.pinTintColor = [UIColor redColor];
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    [mapView.userLocation setTitle:@"欧陆经典"];
    [mapView.userLocation setSubtitle:@"vsp"];
    return pinView;
    
}


-(void)mapButtonPressed:(UIButton *)sendeer{
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatMapCellClick:dict:)]){
        
        
    }
}






@end
