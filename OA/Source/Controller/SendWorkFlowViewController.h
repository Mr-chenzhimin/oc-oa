//
//  SendWorkFlowViewController.h
//  OA
//  审批
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Utils.h"

#import "HGPhotoWall.h"
#import "ShowUserViewController.h"

#import "SendWorkFlowUserCell.h"

@interface SendWorkFlowViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>{
    
    
    NSMutableArray * selectUserArray;
    NSString *iscanChoose;
    int  stepTypeId;
    NSString *stepId;
    UIScrollView *_scrollview;
}
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UILabel *stepMainname;

@property (weak, nonatomic) IBOutlet UILabel *stepbodyname;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UIScrollView * userScrollView;

@property (nonatomic,strong) NSString * review;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontroller;

@property (nonatomic,strong) IBOutlet UITextView * reviewText;

@property (strong, nonatomic) IBOutlet  UITableView * photoWallTableView;


@property (strong, nonatomic) IBOutlet  UIButton * selectDeptBtn;


@property (strong,nonatomic) NSString * inboxId;


@property (nonatomic) int workFlowTag;


-(IBAction)returnBtnClick:(id)sender;


-(IBAction) sendBtnClick:(id)sender;


-(IBAction)chooseDeptName:(id)sender;




@end
