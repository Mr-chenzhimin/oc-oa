//
//  BeatDetailViewController.h
//  OA
//
//  Created by admin on 15-7-13.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysSlideMenu.h"

#import "RKTabView.h"
#import "SendWorkFlowViewController.h"
#import "FlowChartViewController.h"

#import "NJKWebViewProgress.h"
#import "JSBadgeView.h"

@interface BeatDetailViewController : UIViewController<UITextFieldDelegate,RKTabViewDelegate,UIActionSheetDelegate,NJKWebViewProgressDelegate>{
    NSMutableArray * selectUserArray;

    
}

@property (nonatomic,strong) NJKWebViewProgress *_progressProxy;

@property (nonatomic,strong) IBOutlet UIProgressView *_progressView;

@property (nonatomic) NSString *beatId;

@property (nonatomic,strong) NSMutableDictionary * beatData;

@property (nonatomic,strong) IBOutlet UIWebView * detailWebView;

@property (nonatomic,strong) IBOutlet UIButton *saveBtn;

@property (nonatomic,strong) IBOutlet UIButton *backBtn;

- (IBAction) saveBtnClick:(id)sender;

- (IBAction) backBtnClick:(id)sender;




@end
