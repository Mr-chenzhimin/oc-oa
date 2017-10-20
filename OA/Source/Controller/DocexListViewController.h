//
//  DocexListViewController.h
//  hongdabaopo
//
//  Created by admin on 14-7-29.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "UzysSlideMenu.h"
#import "DocexListCell.h"
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"

@interface DocexListViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,RKTabViewDelegate>{
    
     NSMutableArray * dataArray;
    NSMutableDictionary  *docexdata;
    NSString * keyword;
    EGORefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
    
}
@property (strong,nonatomic)UIButton * tmpBtn;

@property (strong, nonatomic) IBOutlet UIButton *repaly;


@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UILabel * myTitleLabel;

@property (nonatomic,strong) IBOutlet UIButton * topMenuBtn;

@property (nonatomic,strong) IBOutlet RKTabView *tabview;

@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;

@property (nonatomic,strong) IBOutlet UITableView * theTableView;

@property (nonatomic,strong) IBOutlet UISearchBar * mySearchBar;

- (IBAction) menuBtnClick:(id)sender;

- (IBAction)backBtn:(id)sender;

- (IBAction) refreshBtnClick:(id)sender;


-(void) loadData;

@end
