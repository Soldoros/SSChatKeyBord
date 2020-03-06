//
//  SSChatTextCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/10.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatTextCell.h"

@implementation SSChatTextCell

-(void)initSSChatCellUserInterface{
    [super initSSChatCellUserInterface];
    
    self.mTextView = [UITextView new];
    self.mTextView.backgroundColor = [UIColor clearColor];
    self.mTextView.editable = NO;
    self.mTextView.scrollEnabled = NO;
    self.mTextView.textContainer.lineFragmentPadding = 0;
    self.mTextView.layoutManager.allowsNonContiguousLayout = NO;
    self.mTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.mTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.mBackImgButton addSubview:self.mTextView];
}



@end
