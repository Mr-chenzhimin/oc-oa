//
//  BeatDetailViewController.m
//  OA
//
//  Created by admin on 15-7-13.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import "BeatDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "BeatListViewController.h"
#import "ShowUserViewController.h"

@interface BeatDetailViewController ()

@end

@implementation BeatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * tokenId = [Utils getCacheForKey:@"tokenId"];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString *userId = [Utils getCacheForKey:@"userId"];
 
    NSString *viewURL = [NSString stringWithFormat:@"%@/plugins/mobile/catering_new_edit_enter.jsp?tokenId=%@&cType=ios&id=%@&userId=%@",serverAddress,tokenId,self.beatId,userId];
    
    NSURL *url =[[NSURL alloc] initWithString:viewURL];
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.detailWebView loadRequest:request];
    
    
    self._progressProxy = [[NJKWebViewProgress alloc] init];
    self.detailWebView.delegate =  self._progressProxy;
    
    self._progressProxy.webViewProxyDelegate = self;
    
    self._progressProxy.progressDelegate = self;
    
    NSString * notif_send_docexfile_dept = @"notif_send_beat_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorUserView:) name:notif_send_docexfile_dept object:nil];
    
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
            if([funcStr isEqualToString:@"checkUser"])
            {
                [self photoUserWallAddAction];
            }
        }
    }
    
    
    return TRUE;
    
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
        [self.detailWebView stringByEvaluatingJavaScriptFromString:js];
    }
    
}

- (void)photoUserWallAddAction
{
    
    ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    
    vc.noti_name = @"notif_send_beat_user";
    vc.selectUserArray = selectUserArray;
    
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    
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
    
    if(IS_IPAD()){
        self.detailWebView.frame = CGRectMake(0, 54, 768, self.view.bounds.size.height-54-48);
    }else if(iPhone5){
        self.detailWebView.frame = CGRectMake(0, 54, 320, 568-54-48);
    }else{
        
        self.detailWebView.frame = CGRectMake(0,54, 320, 480-54-48);
    }
    
    
    //[self performSelector:@selector(showButtonMenu) withObject:self afterDelay:.5];
}



#pragma mark - RKTabViewDelegate
- (IBAction) saveBtnClick:(id)sender {
        NSString * result =  [self.detailWebView stringByEvaluatingJavaScriptFromString:@"validateIos();"];
        NSLog(@"result=%@",result);
        NSMutableDictionary *resultdata = [[[SBJsonParser alloc] init] objectWithString:result];
        NSLog(@"resultdata.....%@......",resultdata);
        NSString *flag=[resultdata objectForKey:@"result"];
        NSLog(@"%@......",flag);
        if([flag intValue]==1){
            NSMutableDictionary *rspBody = [resultdata objectForKey:@"msg"];
            [self saveBeat:rspBody];
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



- (void)saveBeat:(NSMutableDictionary *)filedVOs {
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/catering/saveCatering?s=0&c=25&isAll=1&id=%@",serverAddress,_beatId];
    
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
    

    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void) GetErr2:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];
    
}


- (IBAction) backBtnClick:(id)sender{
    
    //    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
