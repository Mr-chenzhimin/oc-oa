//
//  NoticeListViewController.h
//  OA
//
//  Created by dengfan on 13-12-9.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UzysSlideMenu.h"
#import "NoticeListCell.h"
#import "NoticeDetailViewController.h"


@interface NoticeListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UISearchBarDelegate>{
    NSString * keyword;
    NSMutableArray * BtnTitleList;
}

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) UISearchBar * mySearchBar;
@property (nonatomic,strong) IBOutlet UILabel * myTitleLabel;

@property (nonatomic,strong) NSString *selectTitleLabel;

@property (nonatomic,strong) NSArray * listData;

@property (nonatomic,strong) IBOutlet UIButton * topMenuBtn;

@property (nonatomic,strong) IBOutlet UIButton * refreshBtn;

@property (nonatomic,strong) IBOutlet UITableView *dataTableView;

@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;

- (IBAction) menuBtnClick:(id)sender;

- (IBAction) refreshBtnClick:(id)sender;

-(void) loadbtntitle;
- (IBAction)backBtn:(id)sender;

@end
