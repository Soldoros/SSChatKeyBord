//
//  SSChatVideoCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatVideoCell.h"


@implementation SSChatVideoCell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
   
    
    self.mImgView = [UIImageView new];
    self.mImgView.layer.cornerRadius = 5;
    self.mImgView.layer.masksToBounds  = YES;
    self.mImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.mImgView.backgroundColor = [UIColor whiteColor];
    [self.mBackImgButton addSubview:self.mImgView];
    self.mImgView.userInteractionEnabled = YES;
    
    
    self.mVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mImgView addSubview:self.mVideoBtn];
    [self.mVideoBtn addTarget:self action:@selector(videoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.mVideoBtn.backgroundColor = [UIColor blackColor];
    self.mVideoBtn.alpha = 0.5;
    
    
    self.mVideoImg = [UIImageView new];
    self.mVideoImg.bounds = CGRectMake(0, 0, 40, 40);
    [self.mImgView addSubview:self.mVideoImg];
    self.mVideoImg.image = [UIImage imageNamed:@"icon_bofang"];
    self.mVideoImg.userInteractionEnabled = NO;

}




-(void)videoButtonPressed:(UIButton *)sender{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatImageVideoCellClick:dict:)]){
        
        
    }
}




@end
