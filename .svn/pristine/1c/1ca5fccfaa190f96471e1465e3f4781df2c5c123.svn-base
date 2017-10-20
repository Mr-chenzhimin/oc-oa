//
//  MessageViewController.h
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysSlideMenu.h"
#import "MessageListCell.h"
#import "MessageDetailViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "RKTabView.h"

@interface MessageViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,RKTabViewDelegate>{
    NSString * keyword;
    
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _loading;
    BOOL _isAddFooter;
    BOOL _isAdvanceSearch;
    BOOL _reloading;
    
}

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (strong, nonatomic) IBOutlet RKTabView *titledTabsView;

@property (nonatomic,strong) IBOutlet UILabel * myTitleLabel;

@property (nonatomic,strong) IBOutlet UIButton * backBtn;

@property (nonatomic,strong) IBOutlet UIButton * createBtn;

@property (nonatomic,strong) NSArray * listData;

@property (nonatomic,strong) IBOutlet UITableView *dataTableView;




@property (nonatomic,strong) UISearchBar * mySearchBar;


- (IBAction) menuBtnClick:(id)sender;

- (IBAction) createBtnClick:(id)sender;



-(void) loadData;

@end
