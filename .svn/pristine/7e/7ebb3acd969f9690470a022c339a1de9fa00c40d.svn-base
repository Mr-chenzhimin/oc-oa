//
//  DocexDetailViewController.m
//  hongdabaopo
//
//  Created by admin on 14-7-29.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexDetailViewController.h"
#import "AttachmentListViewController.h"
#import "DocexReplyViewController.h"
#import "DocexSignViewController.h"


@interface DocexDetailViewController ()
{
    float app_width;
    float app_height;
}

@end

@implementation DocexDetailViewController
@synthesize msgBadge;


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
    
//    if(iPhone5){
//        app_width = 320;
//        app_height = 568;
//    }else{
//        app_width = 320;
//        app_height = 480;
//        
//        CGRect bodyFrame = self.bodyContainer.frame;
//        bodyFrame.size.height = app_height-216;
//        self.bodyContainer.frame = bodyFrame;
//    }

    
    self.subjectlbl.text=[self.docexData objectForKey:@"title"];
    self.usernamelbl.text=[self.docexData objectForKey:@"sender"];
    self.timelbl.text=[self.docexData objectForKey:@"createdate"];
    if([[self.docexData objectForKey:@"senderSex"] intValue]==1){
        [self.headImg setImage:[UIImage imageNamed:@"peoheadman"]];
    }
    else{
        [self.headImg setImage:[UIImage imageNamed:@"peoheadwoman"]];
    }
    
    int attatchCount = [[self.docexData objectForKey:@"attachCount"] intValue];
    
    if (attatchCount == 0) {
        [self.attatchBtn setImage:nil forState:UIControlStateNormal];
        self.attatchBtn.hidden = YES;
    }else{
        [self.attatchBtn addTarget:self action:@selector(showAttachmentVc) forControlEvents:UIControlEventTouchUpInside];
        //[self.attatchBtn setImage:[UIImage imageNamed:@"icon_附件"] forState:UIControlStateNormal];
        self.attatchBtn.hidden = NO;
    }
    
    self.attachNum = [[self.docexData objectForKey:@"attachCount"] intValue];
    
    if(self.attachNum != 0){
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.attatchBtn alignment:JSBadgeViewAlignmentTopRight];
        badgeView.badgeText = [NSString stringWithFormat:@"%d", self.attachNum];
    }
    
    
    
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    RKTabItem * ContextTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"内容-天蓝"] imageDisabled:[UIImage imageNamed:@"内容-白"]];
    ContextTabItem.titleString = @"";
    
    RKTabItem *suggtionTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"处理意见-天蓝"]  imageDisabled:[UIImage imageNamed:@"处理意见-白"]];
    suggtionTabItem.titleString = @"";
    suggTabItem=suggtionTabItem;
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    //self.titledTabsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_底部.png"]];
    
    self.titledTabsView.delegate = self;
    self.titledTabsView.tabItems = @[ContextTabItem, suggtionTabItem];
//    self.titledTabsView.frame = CGRectMake(0, 120, self.view.frame.size.width, 48);
    
    [ self.titledTabsView swtichTab:ContextTabItem];
    [self.view bringSubviewToFront:self.bodyContainer];
    
    UIImage *reply = [Constant scaleToSize:[UIImage imageNamed:@"bt53_1"] size:CGSizeMake(107, 47)];
    UIImage *reply_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt53_2"] size:CGSizeMake(107, 47)];
    RKTabItem * replyTabItem = [RKTabItem createUsualItemWithImageEnabled:reply_1 imageDisabled:reply];
    replyTabItem.titleString = @"";
    
    UIImage *readimg = [Constant scaleToSize:[UIImage imageNamed:@"bt54_1"] size:CGSizeMake(107, 47)];
    UIImage *read_1img = [Constant scaleToSize:[UIImage imageNamed:@"bt54_2"] size:CGSizeMake(107, 47)];
    RKTabItem * read = [RKTabItem createUsualItemWithImageEnabled:read_1img imageDisabled:readimg];
    read.titleString = @"";
    
    UIImage *signimg = [Constant scaleToSize:[UIImage imageNamed:@"bt55_1"] size:CGSizeMake(107, 47)];
    UIImage *sign_1img = [Constant scaleToSize:[UIImage imageNamed:@"bt55_2"] size:CGSizeMake(107, 47)];
    RKTabItem *signTabItem = [RKTabItem createUsualItemWithImageEnabled:sign_1img  imageDisabled:signimg];
    signTabItem.titleString = @"";
    
    UIImage *endimg = [Constant scaleToSize:[UIImage imageNamed:@"bt41_1"] size:CGSizeMake(107, 47)];
    UIImage *end_1img = [Constant scaleToSize:[UIImage imageNamed:@"bt41_2"] size:CGSizeMake(107, 47)];
    RKTabItem *endTabItem = [RKTabItem createUsualItemWithImageEnabled:end_1img  imageDisabled:endimg];
    endTabItem.titleString = @"";
    
    self.titledTabsView1.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView1.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView1.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
//    self.titledTabsView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view背景.png"]];
    self.titledTabsView1.delegate = self;
    self.titledTabsView1.frame = CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48);
    
    int titleTag = [[self.docexData objectForKey:@"titleTag"] intValue];
    if (titleTag == 1) {
        caretory=@"inbox";
        self.titledTabsView1.tabItems = @[replyTabItem, read, signTabItem];
    }else if(titleTag==2){
        caretory=@"inbox";
        self.titledTabsView1.tabItems = @[signTabItem];
    }else if(titleTag==3){
        caretory=@"draft";
        self.titledTabsView1.tabItems = @[signTabItem];
    }
    
    
    
}

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
     [tabView swtichTab:tabItem];
    if(tabView==self.titledTabsView){
        if (index == 0) {
            CATransition * animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.15 ;  // 动画持续时间(秒)
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionFade;//淡入淡出效果
            
            
            if(self.docexContextVc == nil){
                self.docexContextVc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexContextViewController"];
                
                NSString * content=[self.docexData objectForKey:@"context"];
                if(content==(NSString *)[NSNull null]||content==nil||[content isEqualToString:@""]){
                    self.docexContextVc.docexContext=@" ";
                }else{
                    NSString *html=[self.docexData objectForKey:@"context"];
                    self.docexContextVc.docexContext=html;
                }
                
                
                [self addChildViewController:self.docexContextVc];
                 self.docexContextVc.view.frame = CGRectMake(0,0, self.bodyContainer.frame.size.width,self.bodyContainer.frame.size.height);
               // self.docexContextVc.view.backgroundColor=[UIColor redColor];
            }
            [self.bodyContainer addSubview:self.docexContextVc.view];
            
            [self.bodyContainer bringSubviewToFront:self.docexContextVc.view];
            [self.view bringSubviewToFront:self.titledTabsView];
            
            [[self.bodyContainer layer] addAnimation:animation forKey:@"animation"];
            
        }else if ( index == 1){
            
            CATransition * animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.15 ;  // 动画持续时间(秒)
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionFade;//淡入淡出效果
            
            
            if(self.docexOptionVc == nil){
                self.docexOptionVc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexOptionViewController"];
                self.docexOptionVc.docexId=[self.docexData objectForKey:@"id"];
                self.docexOptionVc.docexcaretory=caretory;
                [self addChildViewController:self.docexOptionVc];
                self.docexOptionVc.view.frame = CGRectMake(0,0, self.bodyContainer.frame.size.width,self.bodyContainer.frame.size.height);
            }
            [self.docexOptionVc loadData];
            
            [self.bodyContainer addSubview:self.docexOptionVc.view];
            
            [self.bodyContainer bringSubviewToFront:self.docexOptionVc.view];
            [self.view bringSubviewToFront:self.titledTabsView];
            
            [[self.bodyContainer layer] addAnimation:animation forKey:@"animation"];
            
        }
        
    }else{
        int titleTag = [[self.docexData objectForKey:@"titleTag"] intValue];
        if (titleTag == 1) {
         if (index == 0) {//回复
            DocexReplyViewController * docexreply = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexReplyViewController"];
            docexreply.Replyid = [self.docexData objectForKey:@"id"];
            [self.navigationController pushViewController:docexreply animated:YES  ];

            
         }else if(index==1){//已阅
             
             [self read];
             
             
         }else if(index==2){//加签
            
            DocexSignViewController  * docexsign = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexSignViewController"];
            docexsign.docexData=self.docexData;
            [self.navigationController pushViewController:docexsign animated:YES  ];
          }
        }else if(titleTag==2){
            if (index == 0) {//加签
                DocexSignViewController  * docexsign = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexSignViewController"];
                docexsign.docexData=self.docexData;
                [self.navigationController pushViewController:docexsign animated:YES  ];
                
            }
        }else if(titleTag==3){
            if (index == 0) {//加签
                DocexSignViewController  * docexsign = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexSignViewController"];
                docexsign.docexData=self.docexData;
                [self.navigationController pushViewController:docexsign animated:YES  ];
                
                
            }else if(index==1){//结束
                [self enddocex];
                
            }
        }
    }
}

-(void)read{
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/saveOption",serverAddress];
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString *userId = [Utils getCacheForKey:@"userId"];
    [param setObject:[self.docexData objectForKey:@"id"] forKey:@"detailId"];
    [param setObject: userId  forKey:@"uid"];
    [param setObject:@"0" forKey:@"isReply"];
    [param setObject:@"已阅读" forKey:@"content"];
    
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    [postbody appendData:data];
    
    [request setPostBody:postbody ];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
}

- (void)GetResult1:(ASIHTTPRequest *)request{
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableArray *rspBody = [result objectForKey:@"rspBody"];
    
    [ self.titledTabsView swtichTab:suggTabItem];
    
    
}



- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became disabled on tab view", index);
}

-(void)showAttachmentVc{
    
    AttachmentListViewController * attachmentList = [self.storyboard instantiateViewControllerWithIdentifier:@"AttachmentListViewController"];
    
    attachmentList.listData =  [self.docexData objectForKey:@"attachList"];
    attachmentList.attachType = 3;
    [self.navigationController pushViewController:attachmentList animated:YES];
}

-(void) enddocex{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString * docexid=[self.docexData objectForKey:@"id"];
    NSString *  urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/docexFileEnd?id=%@",serverAddress,docexid];
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:urlAddress];


    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];

    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];

     NSMutableDictionary * param = [[NSMutableDictionary alloc] init];


     NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];

     NSMutableData * postbody = [[NSMutableData alloc] init];
     [postbody appendData:data];

     [request setPostBody:postbody ];

     [request setDelegate:self];
     [request setDidFinishSelector:@selector(GetResult:)];
     [request setDidFailSelector:@selector(GetErr:)];
     [request startAsynchronous];


}

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:aStr
                          message:nil
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定",nil];
    [alert show];
    alert.tag = 100;
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}



- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    
    NSLog(@"服务器连接不上！");
    
}


- (IBAction) backBtnClick:(id)sender{
    
    //    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
