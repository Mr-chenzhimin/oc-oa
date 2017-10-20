//
//  BeatListViewController.h
//  OA
//
//  Created by admin on 15-7-13.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UzysSlideMenu.h"
#import "DocexListCell.h"
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"

@interface BeatListViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    
    NSMutableArray * dataArray;
    NSMutableDictionary  *beatdata;
    NSString * keyword;
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    
}


@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UILabel * myTitleLabel;

@property (nonatomic,strong) IBOutlet UIButton * topMenuBtn;

@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;

@property (nonatomic,strong) IBOutlet UITableView * theTableView;

@property (nonatomic,strong) IBOutlet UISearchBar * mySearchBar;

- (IBAction) menuBtnClick:(id)sender;


- (IBAction) createBeatClick:(id)sender;


-(void) loadData;

@end
