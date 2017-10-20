//
//  WorkFlowDetailViewController.m
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "WorkFlowDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "BlockTextPromptAlertView.h"
#import "AttachmentListViewController.h"
#import "ShowDeptViewController.h"
#import "FollowDetailViewController.h"
#import "Constant.h"
@interface WorkFlowDetailViewController ()

@end

@implementation WorkFlowDetailViewController

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
    UIImage *imag1_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt41_2"] size:CGSizeMake(57, 47)];
    RKTabItem * workFlowListTabItem = [RKTabItem createUsualItemWithImageEnabled:imag1_1 imageDisabled:img1];
    workFlowListTabItem.titleString = @"";
    
    UIImage *img2 = [Constant scaleToSize:[UIImage imageNamed:@"bt42_1"] size:CGSizeMake(57, 47)];
    UIImage *imag2_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt42_1"] size:CGSizeMake(57, 47)];
    RKTabItem *paypalTabItem = [RKTabItem createUsualItemWithImageEnabled:imag2_1  imageDisabled:img2];
    paypalTabItem.titleString = @"";
    
    UIImage *img3 = [Constant scaleToSize:[UIImage imageNamed:@"bt43_1"] size:CGSizeMake(57, 47)];
    UIImage *imag3_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt43_1"] size:CGSizeMake(57, 47)];
    RKTabItem *visaTabItem = [RKTabItem createUsualItemWithImageEnabled:imag3_1  imageDisabled:img3];
    visaTabItem.titleString = @"";
    
    UIImage *img4 = [Constant scaleToSize:[UIImage imageNamed:@"bt45_1"] size:CGSizeMake(57, 47)];
    UIImage *imag4_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt45_1"] size:CGSizeMake(57, 47)];
    RKTabItem *processItem = [RKTabItem createUsualItemWithImageEnabled:imag4_1  imageDisabled:img4];
    processItem.titleString = @"";
    
    UIImage *img5 = [Constant scaleToSize:[UIImage imageNamed:@"bt46_1"] size:CGSizeMake(57, 47)];
    UIImage *imag5_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt46_1"] size:CGSizeMake(57, 47)];
    RKTabItem *flowItem = [RKTabItem createUsualItemWithImageEnabled:imag5_1  imageDisabled:img5];
    flowItem.titleString = @"";
    
    
    self.titledTabsView.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
   // self.titledTabsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view背景.png"]];
    self.titledTabsView.delegate = self;
    self.titledTabsView.frame = CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48);
    
    int  titleTag = [[self.workFlowData objectForKey:@"titleTag"] intValue];
    int status = [[_workFlowData objectForKey:@"status"] intValue];
    if (titleTag == 0) {
//        self.titledTabsView.tabItems = @[workFlowListTabItem, paypalTabItem, visaTabItem,processItem,flowItem];
        if (status == 0) {
            self.titledTabsView.tabItems = @[workFlowListTabItem, paypalTabItem, visaTabItem,processItem,flowItem];
        }else if (status ==1){ //协办给别人
            self.titledTabsView.tabItems = @[visaTabItem,processItem,flowItem];
        }else{ // 别人给自己的协办件
            self.titledTabsView.tabItems = @[workFlowListTabItem,processItem,flowItem];
        }

    }else{
        self.titledTabsView.tabItems = @[processItem,flowItem];
    }
    
    
    //  /plugins/mobile/workflowFileinbox_mobile_form_enter.jsp?boxId="+inboxId+"&tokenId="+token
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];

    int attatchCount = [[self.workFlowData objectForKey:@"attachCount"] intValue];
    
    if (attatchCount == 0) {
        [self.attatchBtn setImage:nil forState:UIControlStateNormal];
        self.attatchBtn.hidden = YES;
    }else{
        [self.attatchBtn setImage:[UIImage imageNamed:@"icon_附件图"] forState:UIControlStateNormal];
        self.attatchBtn.hidden = NO;
    }
    self.attachNum = [[self.workFlowData objectForKey:@"attachCount"] intValue];
    
    if(self.attachNum != 0){
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.attatchBtn alignment:JSBadgeViewAlignmentTopRight];
        badgeView.badgeText = [NSString stringWithFormat:@"%d", self.attachNum];
    }
   

    NSString * tokenId = [Utils getCacheForKey:@"tokenId"];
    
    NSString * viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/workflowFileinbox_mobile_form_enter.jsp?boxId=%@&tokenId=%@",serverAddress,inboxId,tokenId];
    
    if(self.workFlowTag == 0){
        viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/workflowFileinbox_mobile_form_enter.jsp?boxId=%@&tokenId=%@&type=0",serverAddress,inboxId,tokenId];
    }
    NSURL *url =[[NSURL alloc] initWithString:viewURL];
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.theWebView loadRequest:request];
    
    
    self._progressProxy = [[NJKWebViewProgress alloc] init];
    self.theWebView.delegate =  self._progressProxy;
    
     self._progressProxy.webViewProxyDelegate = self;
    
     self._progressProxy.progressDelegate = self;

    NSString * notif_send_docexfile_dept = @"notif_send_docexfile_dept";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable1:) name:notif_send_docexfile_dept object:nil];
    
    NSString * notif_send_docexfile_user = @"notif_send_beat_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorUserView:) name:notif_send_docexfile_user object:nil];
    
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

-(void)viewDidAppear:(BOOL)animated{
    
//    if(IS_IPAD()){
//         self.theWebView.frame = CGRectMake(0, 54, 768, self.view.bounds.size.height-54-48);
//    }else if(iPhone5){
//        self.theWebView.frame = CGRectMake(0, 54, 320, 568-54-48);
//    }else{
//        
//        self.theWebView.frame = CGRectMake(0,54, 320, 480-54-48);
//    }
//    
//    CGRect menuframe = self.titledTabsView.frame;
//    menuframe.origin.y = self.view.frame.size.height-menuframe.size.height;
//    self.titledTabsView.frame = menuframe;
//    [self.view bringSubviewToFront:self.titledTabsView];
//    
//    [self performSelector:@selector(showButtonMenu) withObject:self afterDelay:.5];
}

//-(void) showButtonMenu{
//    CGRect menuframe = self.titledTabsView.frame;
//    menuframe.origin.y = self.view.frame.size.height-menuframe.size.height;
//    self.titledTabsView.frame = menuframe;
//    [self.view bringSubviewToFront:self.titledTabsView];
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



- (IBAction) backBtnClick:(id)sender{
    
//    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
    [self.navigationController popViewControllerAnimated:YES];
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
        [self.theWebView stringByEvaluatingJavaScriptFromString:js];
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
        [self.theWebView stringByEvaluatingJavaScriptFromString:js];
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
    
    sFvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SendWorkFlowViewController"];
  
    sFvc.workFlowTag = self.workFlowTag;
    
    NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
    
    sFvc.inboxId = inboxId;
    
    int  titleTag = [[self.workFlowData objectForKey:@"titleTag"] intValue];
    int status = [[_workFlowData objectForKey:@"status"] intValue];
    if (titleTag == 0) {
        if (status == 0) {
            if (index == 0) {
                
                sFvc.review = @"同意";
                //清空webview
                //        [self.theWebView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
                //javascript:validateMobileForm
                NSString * result =  [self.theWebView stringByEvaluatingJavaScriptFromString:@"validateMobile();"];
                NSLog(@"result=%@",result);
                NSMutableDictionary *resultdata = [[[SBJsonParser alloc] init] objectWithString:result];
                NSLog(@"resultdata.....%@......",resultdata);
                NSString *flag=[resultdata objectForKey:@"result"];
                NSLog(@"%@......",flag);
                if([flag intValue]==1){
                    NSMutableDictionary *rspBody = [resultdata objectForKey:@"msg"];
                    [self saveWorkflowFile:rspBody];
                }else{
                    NSString * msg = [resultdata objectForKey:@"msg"];
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:nil
                                          message:msg
                                          delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
                    [alert show];
                    return ;
                    
                }
                
            }
            else if (index == 1){
                //  vc.review = @"不同意";
                [self showReturn:nil];
            }else if (index == 2){
                //协办
                SendWorkFlowViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SendWorkFlowViewController"];
                NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
                vc.workFlowTag = 1;
                vc.inboxId = inboxId;
                vc.review = @"协办";
                [self presentViewController:vc animated:YES completion:^(void){}];
                
            }else if(index == 3){
                [self showProcess:nil];
            }else if(index == 4){
                [self showFlowChar:nil];
            }
            
        }else if (status ==1){
            if (index ==0) {
                //协办
                SendWorkFlowViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SendWorkFlowViewController"];
                NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
                vc.workFlowTag = 1;
                vc.inboxId = inboxId;
                vc.review = @"协办";
                [self presentViewController:vc animated:YES completion:^(void){}];
            }
            if(index == 1){
                [self showProcess:nil];
            }else if(index == 2){
                [self showFlowChar:nil];
            }
            
        }else{
            if(index == 0){
                sFvc.review = @"同意";
                //清空webview
                // [self.theWebView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
                //javascript:validateMobileForm
                NSString * result =  [self.theWebView stringByEvaluatingJavaScriptFromString:@"validateMobile();"];
                NSLog(@"result=%@",result);
                NSMutableDictionary *resultdata = [[[SBJsonParser alloc] init] objectWithString:result];
                NSLog(@"resultdata.....%@......",resultdata);
                NSString *flag=[resultdata objectForKey:@"result"];
                NSLog(@"%@......",flag);
                if([flag intValue]==1){
                    NSMutableDictionary *rspBody = [resultdata objectForKey:@"msg"];
                    [self saveWorkflowFile:rspBody];
                }else{
                    NSString * msg = [resultdata objectForKey:@"msg"];
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:nil
                                          message:msg
                                          delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
                    [alert show];
                    return ;
                    
                }
                
            }else if(index == 1){
                [self showProcess:nil];
            }else{
                [self showFlowChar:nil];
            }
        }

    }else{
        if(index == 0){
            [self showProcess:nil];
        }else if(index == 1){
            [self showFlowChar:nil];
        }

    }
    
   
}

- (void)saveWorkflowFile:(NSMutableDictionary *)filedVOs {

    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
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


//UIActionSheetDelegate
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    //
}
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        NSLog(@"=========>%d",buttonIndex);
        //协办
        
        SendWorkFlowViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SendWorkFlowViewController"];
  
        
        NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
         vc.workFlowTag = self.workFlowTag;
        vc.inboxId = inboxId;
    
        vc.review = @"协办";
        
        [self presentViewController:vc animated:YES completion:^(void){}];
        
        
        
    }else if(buttonIndex == 1){
        //退回
        [self showReturn:nil];
    }else if(buttonIndex == 2){
        //收藏
        [self showCollect:nil];
    }else if(buttonIndex == 3){
        //流程图
        [self showFlowChar:nil];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    int status = [[rspHeader objectForKey:@"status"] integerValue];
    if (status == 1) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"收藏成功"
                              message:nil
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定",nil];
        [alert show];

    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"收藏失败"
                              message:nil
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定",nil];
        [alert show];

    }
    
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];

    
}

- (void)GetBackResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    int status = [[rspHeader objectForKey:@"status"] integerValue];
    NSString * msg = [rspHeader objectForKey:@"msg"];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:msg
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


- (void) GetBackErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    
}


-(void) sendDataPacket:(NSMutableDictionary *)params{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/fileBack?boxId=%@",serverAddress,inboxId];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    //    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    NSString * message = [params JSONRepresentation];
    
    NSData * data =
    [[NSString stringWithFormat:message] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetBackResult:)];
    [request setDidFailSelector:@selector(GetBackErr:)];
    [request startAsynchronous];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"AttachmentList"])
	{
        
        // Get destination view
        id vc = [segue destinationViewController];
        
        AttachmentListViewController * attachmentList = (AttachmentListViewController *) vc;
        attachmentList.attachType = 0;
        
        attachmentList.fileID =  [self.workFlowData objectForKey:@"inboxId"];
        
    }
}

-(void) showProcess:(id)sender{
    FollowDetailViewController * flowFollw = [self.storyboard instantiateViewControllerWithIdentifier:@"FollowDetailViewController"];
    NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
    flowFollw.boxId=inboxId;
    [self.navigationController pushViewController:flowFollw animated:YES  ];
}

- (void) showFlowChar:(id)sender{
    //流程图
    //plugins/mobile/workflowFileinbox_mobile_flowshow.jsp?inboxId=242&tokenId=53F378AFF9AF5D70F7C2F5D2CD428D77
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
    
    NSString * tokenId = [Utils getCacheForKey:@"tokenId"];
    
    // /plugins/mobile/workflowFileinbox_mobile_flowshow.jsp?inboxId="+inboxId+"&tokenId="+token

    
    NSString * viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/workflowFileinbox_mobile_flowshow.jsp?inboxId=%@&tokenId=%@",serverAddress,inboxId,tokenId];
    
    NSURL *url =[[NSURL alloc] initWithString:viewURL];
    
//    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
//    [self.theWebView loadRequest:request];

    FlowChartViewController * flowChart = [self.storyboard instantiateViewControllerWithIdentifier:@"FlowChartViewController"];
    flowChart.url = viewURL;
    [self.navigationController pushViewController:flowChart animated:YES  ];
}

- (void) showCollect:(id)sender{
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * inboxId = [self.workFlowData objectForKey:@"inboxId"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/attention?boxId=%@",serverAddress,inboxId];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
}

- (void) showReturn:(id)sender{
    UITextField *textField;
    BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:@"退回原因" message:nil textField:&textField block:^(BlockTextPromptAlertView *alert){
        [alert.textField resignFirstResponder];
        return YES;
    }];
    
    
    [alert setCancelButtonWithTitle:@"取消" block:nil];
    [alert addButtonWithTitle:@"退回" block:^{
        //post方式退回
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        [headers setObject:@"application/json" forKey:@"Content-type"];
        
        NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
        
        [parameter setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:@"remark"];
        
        [self sendDataPacket:parameter];
        
    }];
    [alert show];
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
