//
//  LoginViewController.h
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "Harpy.h"
@class WorkFlowListViewController;

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)  IBOutlet UITextField * serverAddressField;

@property (nonatomic,strong)  IBOutlet UITextField * usernameField;

@property (nonatomic,strong)  IBOutlet UITextField * passwordField;

@property (nonatomic,strong)  IBOutlet UIButton * loginBtn;
 
- (IBAction)clickLoginBtn:(id)sender;

-(void) GetErr:(ASIHTTPRequest *)request;

-(void) GetResult:(ASIHTTPRequest *)request;

-(void) sendDataPacket:(NSMutableDictionary *)params;

@end
