//
//  ShowUserViewController.h
//  OA
//
//  Created by APPLE on 13-12-22.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowUserCellViewController.h"

#import "TQMultistageTableView.h"

#import "Utils.h"

#import "JSON.h"

#import "ASIHTTPRequest.h"

#import "ShowUserCell.h"

#import "SelectDeptViewController.h"

@interface ShowUserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray * dataArray;
    
    NSMutableArray * dataUserArray;
    
    NSMutableArray * rememberstep ;

    
    BOOL show_user;
    
}

@property (nonatomic,strong) NSMutableArray * selectUserArray;


@property (nonatomic,strong) NSString * noti_name;
@property (nonatomic,strong) NSString * inboxid;
@property (nonatomic,strong) NSString * stepid;
@property (nonatomic,assign) int  worktag;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic, strong) IBOutlet UITableView *mTableView;

@property (nonatomic, strong) IBOutlet UITextField * searchUserField;



-(IBAction)returnBtnClick:(id)sender;


-(IBAction)searchBtnClick:(id)sender;



-(IBAction) selectUserOkBtnClick:(id)sender;


- (IBAction)textFieldDoneEditing:(id)sender;






@end
