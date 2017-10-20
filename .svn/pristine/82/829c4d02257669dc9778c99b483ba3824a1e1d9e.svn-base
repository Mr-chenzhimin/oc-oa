//
//  ShowDeptViewController.h
//  OA
//
//  Created by admin on 15-3-21.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowUserCellViewController.h"

#import "TQMultistageTableView.h"

#import "Utils.h"

#import "JSON.h"

#import "ASIHTTPRequest.h"

#import "ShowDeptCell.h"

#import "SelectDeptViewController.h"


@interface ShowDeptViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray * dataArray;
    
    NSMutableArray * dataUserArray;
    
    NSMutableArray * rememberstep ;
    
    
    BOOL show_dept;
    
}

@property (nonatomic,strong) NSMutableArray * selectdeptArray;


@property (nonatomic,strong) NSString * noti_name;


@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic, strong) IBOutlet UITableView *mTableView;

@property (nonatomic, strong) IBOutlet UITextField * searchUserField;

-(IBAction)returnBtnClick:(id)sender;


-(IBAction)searchBtnClick:(id)sender;



-(IBAction) selectUserOkBtnClick:(id)sender;


- (IBAction)textFieldDoneEditing:(id)sender;

@end
