//
//  FollowDetailViewController.h
//  OA
//
//  Created by Mac on 14-5-9.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowDetailViewController.h"
#import "FollowCurCell.h"


@interface FollowDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * dataCurArray;
    NSMutableArray * dataHistoryArray;
    NSMutableDictionary * dataDetailAllArray;

}
- (IBAction)btnback:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topMenuView;
@property (weak, nonatomic) IBOutlet UILabel *myTitlelable;

@property(nonatomic,strong) NSString * boxId;
@property (nonatomic,strong) IBOutlet UITableView * theFollowdetailView;


@end
