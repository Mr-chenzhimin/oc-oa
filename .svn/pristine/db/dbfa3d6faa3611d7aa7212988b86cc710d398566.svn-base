//
//  MeetMangListViewController.h
//  OA
//
//  Created by admin on 16/8/3.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"

@interface MeetMangListViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,RKTabViewDelegate>{
    
    UISegmentedControl *segmentedControl;
    UISegmentedControl *segmentedControl1;
    NSMutableArray * datacaretoryName;
    NSMutableArray * datacaretory;
    int titleIndex;
    int typekey;
    
    
    NSMutableArray * dataArray;
    
    NSString * keyword;
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    int caretoryindex;
    
}
@property (nonatomic,strong) UIView * topMenuView;

@property (nonatomic,strong)  UILabel * myTitleLabel;

@property (nonatomic,strong)  UIButton * topleftBtn;

@property (nonatomic,strong)  RKTabView *titledTabsView;


@property (nonatomic,strong)  UITableView * theTableView;

@property (nonatomic,strong) UISearchBar * mySearchBar;

-(void) loadData;
@end

