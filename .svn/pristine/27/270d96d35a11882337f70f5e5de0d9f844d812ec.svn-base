//
//  AddressViewController.h
//  OA
//
//  Created by admin on 14-6-3.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"


@interface AddressViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray * dataArray;
    
    NSMutableArray * dataUserArray;
    
    NSMutableArray * rememberdeptID ;
    
    int  show_user;

    
}


- (IBAction)textFieldDoneediting:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnbackname;
@property (weak, nonatomic) IBOutlet UILabel *mytitlelable;
@property (weak, nonatomic) IBOutlet UITextField *searchUserField;
@property (weak, nonatomic) IBOutlet UITableView *mstableView;
@property (weak, nonatomic) IBOutlet UIButton *btnback;
- (IBAction)searchBtnClick:(id)sender;
- (IBAction)btnback:(id)sender;

-(void) loadData;

@property (weak, nonatomic) IBOutlet UIView *topmeunview;

@end
