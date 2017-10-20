//
//  DocexCreateViewController.h
//  OA
//
//  Created by admin on 15-3-20.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"

@interface DocexCreateViewController : UIViewController<RKTabViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *docex_title;

- (IBAction)additional:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *itional;
- (IBAction)conrem:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *conrem;
- (IBAction)share:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *share;

@property (weak, nonatomic) IBOutlet UITextView *docex_content;
@property (nonatomic, strong) IBOutlet RKTabView * titledTabsView;

- (IBAction)backgroundclick:(id)sender;
- (IBAction)returnbtnclick:(id)sender;

@end
