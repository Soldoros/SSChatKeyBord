//
//  MessageController.m
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "MessageController.h"
#import "SSChatController.h"

@interface MessageController ()

@end

@implementation MessageController

-(instancetype)initWithRoot:(BOOL)root{
    if(self = [super initWithRoot:root]){
        self.datas = [NSMutableArray new];
        [self.datas addObjectsFromArray:@[@{@"image":@"touxiang1",
                                        @"title":@"神经萝卜",
                                        @"detail":@"王医生你好，我最近老感觉头晕乏力，是什么原因造成的呢？",
                                        @"sectionId":@"13540033103",
                                        @"type":@"1"
                                        },
                                      @{@"image":@"touxaing2",
                                        @"title":@"王医生",
                                        @"detail":@"您好，可以给我发送一份你的体检报告吗？便于我了解情况，谁是给我打电话13540033104",
                                        @"sectionId":@"13540033104",
                                        @"type":@"1"
                                        }]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"消息"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    cell.imageView.image = [UIImage imageNamed:self.datas[indexPath.row][@"image"]];
    cell.textLabel.text = self.datas[indexPath.row][@"title"];
    cell.detailTextLabel.text = self.datas[indexPath.row][@"detail"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SSChatController *vc = [SSChatController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
