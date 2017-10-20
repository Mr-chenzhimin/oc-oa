//
//  CreateMessageViewController.h
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

#import "HGPhotoWall.h"
#import "ShowUserViewController.h"

#import "SendWorkFlowUserCell.h"

#import "MessageViewController.h"


@interface CreateMessageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextViewDelegate>{
    
    NSString * issms;
    NSMutableArray * selectUserArray;
    
}

@property (nonatomic,strong) IBOutlet UILabel * myTitleLabel;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UIButton * returnBtn;

@property (nonatomic,strong) IBOutlet UIButton * sendBtn;

@property (nonatomic,strong) NSString * review;

@property (nonatomic,strong) IBOutlet UITextView * reviewText;

@property (strong, nonatomic) IBOutlet  UITableView * photoWallTableView;

-(IBAction)returnBtnClick:(id)sender;

-(IBAction)sendBtnClick:(id)sender;

@property (strong,nonatomic) NSString * inboxId;
@property (strong,nonatomic) NSString * typecode;
-(IBAction)backgroundClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *messagecheck;
- (IBAction)messagecheckBox:(id)sender;

@end
