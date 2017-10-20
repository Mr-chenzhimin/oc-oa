//
//  NewWorkFlowFIleosViewController.m
//  OA
//
//  Created by admin on 14-5-30.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "NewWorkFlowFIleosViewController.h"
#import "ASIHTTPRequest.h"
#import "Utils.h"
#import "FlowChartViewController.h"
#import "ShowDeptViewController.h"
#import "ShowUserViewController.h"
#import "SBJsonParser.h"


@interface NewWorkFlowFIleosViewController ()

@end

@implementation NewWorkFlowFIleosViewController

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
    
    UIImage *img1 = [Constant scaleToSize:[UIImage imageNamed:@"bt41_2"] size:CGSizeMake(57, 47)];
    UIImage *img1_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt41_2"] size:CGSizeMake(57, 47)];
    RKTabItem * workFlowListTabItem = [RKTabItem createUsualItemWithImageEnabled:img1_1 imageDisabled:img1];
    workFlowListTabItem.titleString = @"";
    
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
   // self.titledTabsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view背景.png"]];
    self.titledTabsView.delegate = self;
    self.titledTabsView.frame = CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48);
    self.titledTabsView.tabItems = @[workFlowListTabItem];//, flowChar];
   
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * tokenId = [Utils getCacheForKey:@"tokenId"];
    
    NSString * inboxId = [self.WorkflownewFiledata objectForKey:@"fileID"];
    
    NSString *userId=[Utils getCacheForKey:@"userId"];
    
    NSString * viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/workflowfileinbox_moble_newfileshow.jsp?flowId=%@&username=%@&tokenId=%@",serverAddress,inboxId,userId,tokenId];
    NSURL *url =[[NSURL alloc] initWithString:viewURL];
    NSLog(@"url_______%@",url);
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.filenewWebview loadRequest:request];
    
    
    self._progressProxy = [[NJKWebViewProgress alloc] init];
    self.filenewWebview.delegate =  self._progressProxy;
    
    self._progressProxy.webViewProxyDelegate = self;
    
    self._progressProxy.progressDelegate = self;
    
    NSString * notif_send_docexfile_dept = @"notif_send_docexfile_dept";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable1:) name:notif_send_docexfile_dept object:nil];
    
    NSString * notif_send_docexfile_user = @"notif_send_beat_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorUserView:) name:notif_send_docexfile_user object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        self._progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            self._progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - self._progressView.progress options:0 animations:^{
            self._progressView.alpha = 0.0;
        } completion:nil];
    }
    
    [self._progressView setProgress:progress animated:NO];
}



-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlstring=[[request URL]absoluteString];
    urlstring =[urlstring stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlstring=%@",urlstring);
    NSArray *urlComps=[urlstring componentsSeparatedByString:@"://"];
    if([urlComps count]&& [[urlComps objectAtIndex:0]isEqualToString:@"objc"]){
        NSArray *arrfuchnameandparameter=[(NSString *)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr=[arrfuchnameandparameter objectAtIndex:0];
        if(1==[arrfuchnameandparameter count])
        {
            if([funcStr isEqualToString:@"checkdept"])
            {
                [self photodeptWallAddAction];
            }else if([funcStr isEqualToString:@"checkUser"])
            {
                [self photoUserWallAddAction];
            }
        }
    }
    
    
    return TRUE;
    
}

-(void) reloadMonitorTable1:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_dept_array"];
    
    selectDeptArray = data;
    if([data count]>0){
        NSString *detpids=[[data objectAtIndex:0] objectForKey:@"id"];
        for(int k=1;k<[data count];k++){
            detpids=[NSString stringWithFormat:@"%@,%@",detpids,[[data objectAtIndex:k] objectForKey:@"id"]];
        }
        
        NSString *detpnames=[[data objectAtIndex:0] objectForKey:@"name"];
        for(int k=1;k<[data count];k++){
            detpnames=[NSString stringWithFormat:@"%@,%@",detpnames,[[data objectAtIndex:k] objectForKey:@"name"]];
        }
        NSString *js=[NSString stringWithFormat:@"choosevalidateMobileForm('%@','%@');",detpids,detpnames];
        [self.filenewWebview stringByEvaluatingJavaScriptFromString:js];
    }
    
    
    
}

-(void) reloadMonitorUserView:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_user_array"];
    
    selectUserArray = data;
    if([data count]>0){
        NSString *userids=[[data objectAtIndex:0] objectForKey:@"id"];
        for(int k=1;k<[data count];k++){
            userids=[NSString stringWithFormat:@"%@,%@",userids,[[data objectAtIndex:k] objectForKey:@"id"]];
        }
        
        NSString *usernames=[[data objectAtIndex:0] objectForKey:@"name"];
        for(int k=1;k<[data count];k++){
            usernames=[NSString stringWithFormat:@"%@,%@",usernames,[[data objectAtIndex:k] objectForKey:@"name"]];
        }
        NSString *js=[NSString stringWithFormat:@"choosevalidateMobileForm('%@','%@');",userids,usernames];
        [self.filenewWebview stringByEvaluatingJavaScriptFromString:js];
    }
    
}



- (void)photodeptWallAddAction
{
    
    ShowDeptViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowDeptViewController"];
    
    vc.noti_name = @"notif_send_docexfile_dept";
    vc.selectdeptArray = selectDeptArray;
    
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    
}

- (void)photoUserWallAddAction
{
    
    ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    
    vc.noti_name = @"notif_send_beat_user";
    vc.selectUserArray = selectUserArray;
    
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    
}


#pragma mark - RKTabViewDelegate
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    
    sFvc= [self.storyboard instantiateViewControllerWithIdentifier:@"SendWorkFlowViewController"];


        if (index == 0) {
            NSString * result =  [self.filenewWebview stringByEvaluatingJavaScriptFromString:@"validateMobile();"];
            NSLog(@"%@",result);
            NSMutableDictionary *resultdata = [[[SBJsonParser alloc] init] objectWithString:result];
            NSString *flag=[resultdata objectForKey:@"result"];
            NSLog(@"%@......",flag);
            if([flag intValue]==1){
                NSString *inboxid= [resultdata objectForKey:@"inboxId"];
                NSMutableDictionary *rspBody = [resultdata objectForKey:@"msg"];
                [self saveWorkflowFile:rspBody:inboxid];
                sFvc.inboxId = inboxid ;
            }else{
                NSString * msg = [resultdata objectForKey:@"msg"];
                if (msg ==nil) {
                    msg=@"错误";
                }
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:nil
                                      message:msg
                                      delegate:self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil,nil];
                [alert show];
                return ;

            }
            
        }else if (index == 1){
                 [self.navigationController popViewControllerAnimated:YES];
        }
    
//        }else if (index == 2){
//            [self showFlowChar:nil];
//            
//        }

}

- (void)saveWorkflowFile:(NSMutableDictionary *)filedVOs:(NSString *)indoxId {
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString * inboxId = indoxId;
    urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/saveWorkFlowFileInfo?s=0&c=25&isAll=1&boxId=%@",serverAddress,inboxId];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSString * message = [filedVOs JSONRepresentation];
    
    NSData * data =  [message dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult2:)];
    [request setDidFailSelector:@selector(GetErr2:)];
    [request startAsynchronous];
}
- (void)GetResult2:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableArray *rspBody = [result objectForKey:@"rspBody"];
    
    
    int status = [[rspHeader objectForKey:@"status"] integerValue];
    if(status == 1){
        [self presentViewController:sFvc animated:YES completion:^(void){}];
    }
    
    
}

- (void) GetErr2:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];

}


- (IBAction) showFlowChar:(id)sender{
     //流程图
    //plugins/mobile/workflowFileinbox_mobile_flowshow.jsp?inboxId=242&tokenId=53F378AFF9AF5D70F7C2F5D2CD428D77
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * inboxId = [self.WorkflownewFiledata objectForKey:@"fileID"];
    
    NSString * tokenId = [Utils getCacheForKey:@"tokenId"];
    
    // /plugins/mobile/workflowFileinbox_mobile_flowshow.jsp?inboxId="+inboxId+"&tokenId="+token
    
    
    NSString * viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/workflowFileinbox_mobile_newflowshow.jsp?flowId=%@&tokenId=%@",serverAddress,inboxId,tokenId];
    
    NSURL *url =[[NSURL alloc] initWithString:viewURL];
    
    //    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    //    [self.theWebView loadRequest:request];
    
    FlowChartViewController * flowChart = [self.storyboard instantiateViewControllerWithIdentifier:@"FlowChartViewController"];
    flowChart.url = viewURL;
    [self.navigationController pushViewController:flowChart animated:YES  ];
}


-(void)viewDidAppear:(BOOL)animated{
    
    if(IS_IPAD()){
        self.filenewWebview.frame = CGRectMake(0, 54, 768, self.view.bounds.size.height-54-48);
    }else if(iPhone5){
        self.filenewWebview.frame = CGRectMake(0, 54, 320, 568-54-48);
    }else{
        
        self.filenewWebview.frame = CGRectMake(0,54, 320, 480-54-48);
    }
    
    CGRect menuframe = self.titledTabsView.frame;
    menuframe.origin.y = self.view.frame.size.height-menuframe.size.height;
    self.titledTabsView.frame = menuframe;
    [self.view bringSubviewToFront:self.titledTabsView];
    
    [self performSelector:@selector(showButtonMenu) withObject:self afterDelay:.5];
}
-(void) showButtonMenu{
    CGRect menuframe = self.titledTabsView.frame;
    menuframe.origin.y = self.view.frame.size.height-menuframe.size.height;
    self.titledTabsView.frame = menuframe;
    [self.view bringSubviewToFront:self.titledTabsView];
    
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

- (IBAction)btnback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
