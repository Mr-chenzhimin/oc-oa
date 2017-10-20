//
//  DocexDetailViewController.h
//  hongdabaopo
//
//  Created by admin on 14-7-29.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "MLPAccessoryBadge.h"
#import "UIColor+MLPFlatColors.h"
#import "DocexContextViewController.h"
#import "DocexOptionViewController.h"
#import "JSBadgeView.h"


@interface DocexDetailViewController : UIViewController<RKTabViewDelegate>{
    
    NSString *caretory;
    RKTabItem *suggTabItem;
}

@property (nonatomic) int attachNum;
@property (nonatomic,strong) DocexContextViewController * docexContextVc;

@property (nonatomic,strong) DocexOptionViewController * docexOptionVc;




@property (nonatomic,strong) NSMutableDictionary * docexData;

@property (nonatomic, strong) IBOutlet RKTabView * titledTabsView;

@property (nonatomic, strong) IBOutlet RKTabView *titledTabsView1;

@property (nonatomic, strong) IBOutlet UIView * bodyContainer;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UIButton * attatchBtn;

@property (nonatomic,strong) IBOutlet UILabel * subjectlbl;

@property (nonatomic,strong) IBOutlet UILabel * usernamelbl;

@property (nonatomic,strong) IBOutlet UILabel * timelbl;

@property (nonatomic,strong) IBOutlet UIImageView * headImg;

@property (nonatomic,strong) IBOutlet  MLPAccessoryBadge * msgBadge;



- (IBAction) backBtnClick:(id)sender;

@end
