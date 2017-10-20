//
//  AttachmentListViewController.h
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SendWorkFlowViewController.h"

#import "AttachmentViewController.h"

@interface AttachmentListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
}

//0 workflow  1 消息 2公告  9会议管理
@property (nonatomic) int attachType;
@property (nonatomic ,strong)NSMutableArray *meetingAttachs;
@property (nonatomic,strong) NSArray * listData;
@property (nonatomic,strong) IBOutlet UIView * topMenuView;
@property (nonatomic,strong) NSString * fileID;
@property (nonatomic,strong) IBOutlet UITableView *dataTableView;

-(IBAction)returnBtnClick:(id)sender;

@end
