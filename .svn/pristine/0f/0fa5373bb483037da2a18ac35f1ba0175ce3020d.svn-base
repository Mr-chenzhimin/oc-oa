//
//  SendNewFileViewController.h
//  OA
//
//  Created by admin on 14-5-30.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendWorkFlowUserCell.h"
#import "Utils.h"
#import "HGPhotoWall.h"
#import "JSON.h"

@interface SendNewFileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    
    NSMutableArray * selectUserArray;
    NSString *iscanChoose;
    int  stepTypeId;
    int stepId;
    
    
}


@property (strong,nonatomic) NSString * inboxId;
@property (weak, nonatomic) IBOutlet UITextView *leaveword;
@property (weak, nonatomic) IBOutlet UIView *topmenuView;
@property (weak, nonatomic) IBOutlet UITableView *photoWallTableView;
- (IBAction)btnback:(id)sender;
- (IBAction)btnSend:(id)sender;
@end
