//
//  SelectDeptViewController.h
//  OA
//
//  Created by APPLE on 13-12-28.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowUserCell.h"


@interface SelectDeptViewController : UIViewController{
    
    
    NSMutableArray * selectUserArray;
    
    
    
}


@property (nonatomic,strong) NSMutableArray * selectUserArray;


@property (nonatomic,strong) NSMutableDictionary  * selectDeptDic;


@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic, strong) IBOutlet UITableView *mTableView;


-(IBAction)returnBtnClick:(id)sender;




@end
