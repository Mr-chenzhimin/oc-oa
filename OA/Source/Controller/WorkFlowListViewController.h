//
//  WorkFlowListViewController.h
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "LoginViewController.h"
#import "UzysSlideMenu.h"
#import "RKTabView.h"
#import "WorkFlowCell.h"
#import "WorkFlowDetailViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "MainCenterViewController.h"
#import "UIColor+MLPFlatColors.h"
#import "MLPAccessoryBadge.h"
#import "EGORefreshTableFooterView.h"
@interface WorkFlowListViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    
    NSMutableArray * dataArray;
    NSMutableArray * datacaretoryName;
    NSMutableArray * datacaretory;
    int titleIndex;
    int typekey;
    NSString * keyword;
    EGORefreshTableFooterView * _refreshFooterView;
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _loading;
    BOOL _isAddFooter;
    BOOL _isAdvanceSearch;
    BOOL _reloading;
    int caretoryindex;
}


//@property (nonatomic, strong) IBOutlet RKTabView * titledTabsView;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UILabel * myTitleLabel;

@property (nonatomic,strong) IBOutlet UIButton * topMenuBtn;


@property (nonatomic,strong) IBOutlet UITableView * theTableView;

@property (nonatomic,strong) IBOutlet UISearchBar * mySearchBar;
@property (nonatomic,strong) IBOutlet  MLPAccessoryBadge * msgBadge;

- (IBAction)backBtn:(id)sender;


- (IBAction) refreshBtnClick:(id)sender;


-(void) loadData;

@end
