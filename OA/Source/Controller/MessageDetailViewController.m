//
//  MessageDetailViewController.m
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "Utils.h"
#import "CreateMessageViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

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
	// Do any additional setup after loading the view.
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * resourceId = [self.messageData objectForKey:@"id"];
    
    NSString * messageKind = [Utils getCacheForKey:@"messageKind"];
    
    NSString * tokenId = [Utils getCacheForKey:@"tokenId"];
    
    NSString * viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/message_enter.jsp?resourceId=%@&type=%@&tokenId=%@",serverAddress,resourceId,messageKind,tokenId];
    
    NSURL *url =[[NSURL alloc] initWithString:viewURL];
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.detailWebView loadRequest:request];


    int attachCount = [[self.messageData objectForKey:@"attachCount"] intValue];
    
    if (attachCount == 0) {
        self.attachmentBtn.hidden= YES;
    }else{
        self.attachmentBtn.hidden= NO;
        [self.attachmentBtn addTarget:self action:@selector(showAttachmentVc) forControlEvents:UIControlEventTouchUpInside];
    }
    self.attachNum = [[self.messageData objectForKey:@"attachCount"] intValue];
    
    if(self.attachNum != 0){
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.attachmentBtn alignment:JSBadgeViewAlignmentTopRight];
        badgeView.badgeText = [NSString stringWithFormat:@"%d", self.attachNum];
    }
    self.createBtn.hidden = YES;
    self.zhuanfaBtn.hidden = YES;
   
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(initReplyBtn) withObject:self afterDelay:.5];
    
}

-(void) initReplyBtn{
    self.createBtn.frame = CGRectMake(20, self.view.frame.size.height - 50, 117, 40);
    self.createBtn.hidden = NO;
    
    self.zhuanfaBtn.frame = CGRectMake(175, self.view.frame.size.height - 50, 117, 40);
    self.zhuanfaBtn.hidden = NO;
    
}

-(void)showAttachmentVc{
    
    AttachmentListViewController * attachmentList = [self.storyboard instantiateViewControllerWithIdentifier:@"AttachmentListViewController"];
    
    attachmentList.fileID =  [self.messageData objectForKey:@"id"];
    attachmentList.attachType = 1;
    [self.navigationController pushViewController:attachmentList animated:YES];
    
//    [self presentViewController:attachmentList animated:YES completion:^(void){}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(IBAction)returnBtnClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) createBtnClick:(id)sender{
    
    CreateMessageViewController * vc  = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateMessageViewController"];
    NSString * publishID = [self.messageData objectForKey:@"publishID"];
    [Utils cache:publishID forKey:@"publishID"];
    
    NSString * publishName = [self.messageData objectForKey:@"publisher"];
    [Utils cache:publishName forKey:@"publishName"];
    
    [Utils cache:@"2" forKey:@"CreateKind"];
    vc.inboxId = [self.messageData objectForKey:@"id"];
    vc.typecode = @"1";
    [self.navigationController pushViewController:vc animated:YES];
   
//    [self performSegueWithIdentifier:@"returnMessage" sender:self];
}

- (IBAction) zhuanfaBtnClick:(id)sender{
    //    [Utils cache:@"3" forKey:@"CreateKind"];
    //    [self performSegueWithIdentifier:@"returnMessage" sender:self];
    
    CreateMessageViewController * vc  = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateMessageViewController"];
    [Utils cache:@"3" forKey:@"CreateKind"];
    vc.inboxId = [self.messageData objectForKey:@"id"];
    vc.typecode = @"2";
    [self.navigationController pushViewController:vc animated:YES];
    
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
