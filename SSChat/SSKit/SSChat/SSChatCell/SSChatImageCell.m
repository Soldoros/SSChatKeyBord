//
//  SSChatImageCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/12.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatImageCell.h"

@implementation SSChatImageCell

-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    self.mImgView = [UIImageView new];
    self.mImgView.layer.cornerRadius = 5;
    self.mImgView.layer.masksToBounds  = YES;
    self.mImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.mImgView.backgroundColor = [UIColor whiteColor];
    [self.mBackImgButton addSubview:self.mImgView];
    
}




//点击展开图片
-(void)buttonPressed:(UIButton *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatImageVideoCellClick:dict:)]){
        
    }
}

@end
