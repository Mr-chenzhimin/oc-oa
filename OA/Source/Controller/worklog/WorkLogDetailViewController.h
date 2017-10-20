//
//  WorkLogDetailViewController.h
//  OA
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"
@interface WorkLogDetailViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,RKTabViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) NSMutableDictionary * worklogData;

@property (nonatomic) int worklogTag;

@property (nonatomic) int DetailId;

@property (nonatomic,strong) UIView * topMenuView;
@property (nonatomic,strong)  UILabel * myTitleLabel;

@property (nonatomic,strong)  UIButton * topleftBtn;

@property (nonatomic,strong)  RKTabView *titledTabsView;

@property (nonatomic,strong) IBOutlet UISearchBar * mySearchBar;

@property (nonatomic,strong)  UITableView * theTableView;
@end
