//
//  SetupViewController.m
//  OA
//
//  Created by dengfan on 13-12-9.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "SetupViewController.h"
#import "Utils.h"
#import "LoginViewController.h"
@interface SetupViewController ()
@property (nonatomic,strong) LoginViewController * LoginVc;
@end

@implementation SetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    NSString * messageAlert = [Utils getCacheForKey:@"messageAlert"];
    
    if([messageAlert isEqualToString:@"0"]){
        [self.selectBtn setImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
        
    }else{
        [self.selectBtn setImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
    }
    
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
    
    [self.view bringSubviewToFront:self.selectBtn];
    
    NSString * deptName = [Utils getCacheForKey:@"deptName"];
    NSString * username = [Utils getCacheForKey:@"userName"];
    self.deptNameLabel.text = [NSString stringWithFormat:@"部门:%@",deptName];
    self.usernameLabel.text = [NSString stringWithFormat:@"姓名:%@",username];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickSelectBtn:(id)sender{
    if(self.selectBtn.tag == 1){
        [self.selectBtn setImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
        self.selectBtn.tag = 0;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)    {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];        [[UIApplication sharedApplication] registerForRemoteNotifications];
        }    else    {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        }

        
    }else{
        [self.selectBtn setImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
        self.selectBtn.tag = 1;
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
    
    [Utils cache:[[NSString alloc] initWithFormat:@"%d",self.selectBtn.tag] forKey:@"messageAlert"];

}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSendBtn:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]
                                 initWithTitle:@"确定退出？"
                                 message:nil
                                 delegate:self
                                 cancelButtonTitle:@"取消"
                                 otherButtonTitles:@"确定",nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
    }else if(buttonIndex == 1){
        
        self.LoginVc =[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:self.LoginVc animated:NO];
    }

}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIDeviceOrientationPortraitUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait); // 只支持向左横向, YES 表示支持所有方向
}


@end
