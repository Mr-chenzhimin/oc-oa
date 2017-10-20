//
//  NoticeDetailViewController.h
//  OA
//
//  Created by dengfan on 13-12-9.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttachmentListViewController.h"
#import "JSBadgeView.h"
@interface NoticeDetailViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UIButton * returnBtn;

-(IBAction)returnBtnClick:(id)sender;


@property (nonatomic,strong) NSMutableDictionary * noticeData;

@property (nonatomic,strong) IBOutlet UIWebView * detailWebView;

@property (nonatomic,strong) IBOutlet UIButton * attachmentBtn;
@property (nonatomic) int attachNum;

@end
