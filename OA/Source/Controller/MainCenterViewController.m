//
//  MainCenterViewController.m
//  OA
//
//  Created by APPLE on 13-12-13.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "MainCenterViewController.h"

@interface MainCenterViewController (){
    float app_width;
    float app_height;
}

@end

@implementation MainCenterViewController

@synthesize msgBadge;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) toLoginView:(NSNotification * )notiData{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * notif_login = @"notif_login";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toLoginView:) name:notif_login object:nil];
    
    NSString * notif_getcount = @"notif_getcount";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCount) name:notif_getcount object:nil];
    
    self.navigationItem.title = @"首页";
    
    [self.navigationController setNavigationBarHidden:YES]; 

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0 ;
    
    msgBadge = [MLPAccessoryBadge new];
    [msgBadge setCornerRadius:10];
    [msgBadge setTextWithNumber:@1];
    [msgBadge setBackgroundColor:[UIColor flatDarkRedColor]];
    msgBadge.alpha = 1.;
    
    CGRect requireBtnBadgeFrame  = msgBadge.frame;
    requireBtnBadgeFrame.origin.x = 130;
    requireBtnBadgeFrame.origin.y = self.msgBadge.frame.size.height/5.0;
    msgBadge.frame = requireBtnBadgeFrame;
    
    [self.num1 setHidden:true];
    [self.num2 setHidden:true];
    [self.num3 setHidden:true];
    [self.num4 setHidden:true];

  // self.shouye.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head背景.png"]];
    
    
    

    
}

-(void)getCount{
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/message/getCount",serverAddress];
    NSLog(@"%@......",urlAddress);
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
#pragma mark -AFN网络请求
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
//    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
//    [headers setObject:@"application/json" forKey:@"Content-type"];
//
//    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
//    [headers setObject:tokenId forKey:@"token"];
//    NSDictionary *headerFieldValueDictionary = headers;
//    if (headerFieldValueDictionary != nil) {
//        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//            NSString *value = headerFieldValueDictionary[httpHeaderField];
//            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//        }
//    }
//    manager.requestSerializer = requestSerializer;
//    [manager GET:urlAddress parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        OALog(@"%@--%@",[responseObject class],responseObject);
//        NSMutableDictionary *rspHeader = [responseObject objectForKey:@"rspHeader"];
//        
//        NSMutableDictionary *rspBody = [responseObject objectForKey:@"rspBody"];
//        NSString *wfCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"workflowCount"]];
//        NSString *docexCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"docexCount"]];
//        NSString *messageCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"messageCount"]];
//        NSString *bulletinCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"bulletinCount"]];
//        
//        if([wfCount isEqualToString:@"0"]){
//            [self.num1 setHidden:true];
//        }else{
//            [self.num1 setHidden:NO];
//            [self.num1 setTitle:wfCount forState:UIControlStateNormal];
//        }
//        
//        if([docexCount isEqualToString:@"0"]){
//            [self.num2 setHidden:true];
//        }else{
//            [self.num2 setHidden:NO];
//            [self.num2 setTitle:docexCount forState:UIControlStateNormal];
//        }
//        
//        if([messageCount isEqualToString:@"0"]){
//            [self.num3 setHidden:true];
//        }else{
//            [self.num3 setHidden:NO];
//            [self.num3 setTitle:messageCount forState:UIControlStateNormal];
//        }
//        
//        if([bulletinCount isEqualToString:@"0"]){
//            [self.num4 setHidden:true];
//        }else{
//            [self.num4 setHidden:NO];
//            [self.num4 setTitle:bulletinCount forState:UIControlStateNormal];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        OALog(@"fai");
//    }];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
#pragma mark -ASI网络请求
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

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    NSString *wfCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"workflowCount"]];
    NSString *docexCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"docexCount"]];
    NSString *messageCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"messageCount"]];
    NSString *bulletinCount = [NSString stringWithFormat:@"%@", [rspBody objectForKey:@"bulletinCount"]];
    
    if([wfCount isEqualToString:@"0"]){
        [self.num1 setHidden:true];
    }else{
        [self.num1 setHidden:NO];
        [self.num1 setTitle:wfCount forState:UIControlStateNormal];
    }
    
    if([docexCount isEqualToString:@"0"]){
        [self.num2 setHidden:true];
    }else{
        [self.num2 setHidden:NO];
        [self.num2 setTitle:docexCount forState:UIControlStateNormal];
    }
    
    if([messageCount isEqualToString:@"0"]){
        [self.num3 setHidden:true];
    }else{
        [self.num3 setHidden:NO];
        [self.num3 setTitle:messageCount forState:UIControlStateNormal];
    }
    
    if([bulletinCount isEqualToString:@"0"]){
        [self.num4 setHidden:true];
    }else{
        [self.num4 setHidden:NO];
        [self.num4 setTitle:bulletinCount forState:UIControlStateNormal];
    }
    
    NSLog(@"success");
}

- (void) GetErr:(ASIHTTPRequest *)request{
    NSLog(@"error....");
}



-(void)viewDidAppear:(BOOL)animated{
    [self getCount];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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


- (IBAction)docexListBtn:(id)sender {

    self.docexVc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexListViewController"];
    [self.navigationController pushViewController:self.docexVc animated:YES];
    
}

- (IBAction)workFlowListBtn:(id)sender {

    self.workFlowListVc = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkFlowListViewController"];
    [self.navigationController pushViewController:self.workFlowListVc animated:YES];
}

- (IBAction)messageBtn:(id)sender {
    
    self.messageVc = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    [self.navigationController pushViewController:self.messageVc animated:YES];

}

- (IBAction)addressBtn:(id)sender {
    
    self.addressVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressViewController"];
     [self.navigationController pushViewController:self.addressVc animated:YES];
}

- (IBAction)noticeListBtn:(id)sender {

    [self.noticeListVc loadbtntitle];
    self.noticeListVc = [self.storyboard instantiateViewControllerWithIdentifier:@"NoticeListViewController"];
    [self.navigationController pushViewController:self.noticeListVc animated:YES];
}

- (IBAction)setupBtn:(id)sender {
    
    self.setupVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SetupViewController"];
    [self.navigationController pushViewController:self.setupVc animated:YES];
}

- (IBAction)applistBtn:(id)sender {
    
    AppListViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AppListViewController"];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)worklogBtn:(id)sender {
    
    _worklogVc = [[workLogViewController alloc]init];
    _worklogVc.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:_worklogVc animated:YES];
}

- (IBAction)meetlistBtn:(id)sender {
    
    self.meetVc = [[MeetMangListViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:self.meetVc  animated:YES];
}
@end
