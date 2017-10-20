//
//  WorkFlowDetailViewController.h
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysSlideMenu.h"

#import "RKTabView.h"
#import "SendWorkFlowViewController.h"
#import "FlowChartViewController.h"

#import "NJKWebViewProgress.h"
#import "JSBadgeView.h"
@interface WorkFlowDetailViewController : UIViewController<UITextFieldDelegate,RKTabViewDelegate,UIActionSheetDelegate,NJKWebViewProgressDelegate>{
    SendWorkFlowViewController * sFvc;
    NSMutableArray * selectDeptArray;
    NSMutableArray * selectUserArray;
   
}

@property (nonatomic,strong) NJKWebViewProgress *_progressProxy;

@property (nonatomic,strong) IBOutlet UIProgressView *_progressView;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;


@property (nonatomic,strong) UzysSlideMenu *uzysSMenu;

@property (nonatomic,strong) IBOutlet  UIWebView * theWebView;


- (IBAction) backBtnClick:(id)sender;


@property (nonatomic, strong) IBOutlet RKTabView *titledTabsView;


@property (nonatomic,strong) NSMutableDictionary * workFlowData;

@property (nonatomic,strong) IBOutlet UIButton * attatchBtn;


@property (nonatomic) int workFlowTag;

@property (nonatomic) int attachNum;

- (IBAction) showFlowChar:(id)sender;

- (IBAction) showCollect:(id)sender;

- (IBAction) showReturn:(id)sender;

@end
