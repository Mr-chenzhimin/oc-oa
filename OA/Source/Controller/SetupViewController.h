//
//  SetupViewController.h
//  OA
//
//  Created by dengfan on 13-12-9.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SetupViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong)  IBOutlet UIButton * selectBtn;

@property (nonatomic,strong)  IBOutlet UIView * bgView;

@property (nonatomic,strong) IBOutlet UILabel * deptNameLabel;

@property (nonatomic,strong) IBOutlet UILabel * usernameLabel;


- (IBAction)clickSelectBtn:(id)sender;
- (IBAction)backBtn:(id)sender;


- (IBAction)clickSendBtn:(id)sender;


@end
