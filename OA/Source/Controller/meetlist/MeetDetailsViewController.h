//
//  MeetDetailsViewController.h
//  OA
//
//  Created by admin on 16/7/27.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"

@interface MeetDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RKTabViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *attachmentBtn;
@property (strong, nonatomic) IBOutlet UIButton *topleftBtn;
@property (strong, nonatomic) IBOutlet UIView *topMenuView;
@property (strong, nonatomic) IBOutlet UILabel *mytitle;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *meetName;
@property (strong, nonatomic) IBOutlet UILabel *summaryPerson;
@property (strong, nonatomic) IBOutlet UILabel *meetType;

@property (strong, nonatomic) IBOutlet UITextView *MeetContact;
@property (strong, nonatomic) IBOutlet UILabel *MeetRoom;

@property (strong, nonatomic) IBOutlet UILabel *meetServe;
@property (strong, nonatomic) IBOutlet UILabel *meetUserNum;
@property (strong, nonatomic) IBOutlet UILabel *company;

@property (strong, nonatomic) IBOutlet UILabel *hoster;
@property (strong, nonatomic) IBOutlet UIScrollView *MeetScrollView;
@property (nonatomic,strong)  UITableView * theTableView;
@property (nonatomic,strong)  RKTabView *titledTabsView;


@property (nonatomic,strong) NSMutableDictionary * meetData;

@property (nonatomic,strong) NSString *meetid;
@property (nonatomic,assign) int tag;
@property (nonatomic,assign) int aduitflag;
- (IBAction)back:(id)sender;
- (IBAction)attachmentClick:(id)sender;

@end
