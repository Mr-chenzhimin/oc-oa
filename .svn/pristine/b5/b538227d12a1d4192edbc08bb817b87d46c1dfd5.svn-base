//
//  NewWorkFlowFIleosViewController.h
//  OA
//
//  Created by admin on 14-5-30.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"
#import "NJKWebViewProgress.h"
#import "SendWorkFlowViewController.h"

@interface NewWorkFlowFIleosViewController : UIViewController<RKTabViewDelegate,NJKWebViewProgressDelegate>
{
    NSString * inboxidtest;
    SendWorkFlowViewController * sFvc;
    NSMutableArray * selectDeptArray;
    NSMutableArray * selectUserArray;
    
    
}
@property (nonatomic,strong) NSMutableDictionary * WorkflownewFiledata;

@property (weak, nonatomic) IBOutlet UIWebView *filenewWebview;

@property (weak, nonatomic) IBOutlet UIView *topMenuView;

@property (nonatomic,strong) NJKWebViewProgress *_progressProxy;

- (IBAction)btnback:(id)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *_progressView;

@property (weak, nonatomic) IBOutlet RKTabView *titledTabsView;

@end
