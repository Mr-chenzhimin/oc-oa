//
//  NoticeDetailViewController.m
//  OA
//
//  Created by dengfan on 13-12-9.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "Utils.h"

@interface NoticeDetailViewController ()

@end

@implementation NoticeDetailViewController

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
    
//    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];

    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * resourceId = [self.noticeData objectForKey:@"id"];
    
    NSString * noticeKind = [Utils getCacheForKey:@"noticeKind"];
    
    NSString * tokenId = [Utils getCacheForKey:@"tokenId"];
    
    NSString * viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/bulletins_enter.jsp?resourceId=%@&type=%@&tokenId=%@",serverAddress,resourceId,noticeKind,tokenId];
    
    NSURL *url =[[NSURL alloc] initWithString:viewURL];
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    //self.detailWebView.scalesPageToFit=YES;
    [self.detailWebView loadRequest:request];
    
    int attachCount = [[self.noticeData objectForKey:@"attachCount"] intValue];
    if (attachCount == 0) {
        self.attachmentBtn.hidden= YES;
    }else{
        self.attachmentBtn.hidden= NO;
        [self.attachmentBtn addTarget:self action:@selector(showAttachmentVc) forControlEvents:UIControlEventTouchUpInside];
    }
    self.attachNum = [[self.noticeData objectForKey:@"attachCount"] intValue];
    
    if(self.attachNum != 0){
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.attachmentBtn alignment:JSBadgeViewAlignmentTopRight];
        badgeView.badgeText = [NSString stringWithFormat:@"%d", self.attachNum];
    }

    
    if(IS_IPAD()){
        self.detailWebView.frame = CGRectMake(0, 54, 768, self.view.bounds.size.height);
    }

}

-(void)showAttachmentVc{
    
    AttachmentListViewController * attachmentList = [self.storyboard instantiateViewControllerWithIdentifier:@"AttachmentListViewController"];
    
    attachmentList.fileID =  [self.noticeData objectForKey:@"id"];
    attachmentList.attachType = 2;
    
    [self.navigationController pushViewController:attachmentList animated:YES];
    
//    [self presentViewController:attachmentList animated:YES completion:^(void){}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returnBtnClick:(id)sender{
//    [self dismissViewControllerAnimated:YES completion:^(void){}];
    [self.navigationController popViewControllerAnimated:YES];

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
