//
//  MeetDetailsViewController.m
//  OA
//
//  Created by admin on 16/7/27.
//  Copyright © 2016年 dengfan. All rights reserved.
//
#import <objc/runtime.h>
#import "MeetDetailsViewController.h"
#import "Utils.h"
#import "SBJsonParser.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "BlockTextPromptAlertView.h"
#import "AttachmentListViewController.h"
@interface MeetDetailsViewController (){
    RKTabItem * delete;
    RKTabItem * agree;
    NSString *auditStatus;
    NSString *status; //状态
    NSString *joinStatus;
    NSDictionary * MeetDetailData;
    NSMutableArray * MeetUserArray;
    NSMutableArray *meetingAttachsData;
}

@end

@implementation MeetDetailsViewController




-(void)viewDidLayoutSubviews{
//    self.MeetScrollView.backgroundColor=[UIColor whiteColor];
    self.MeetScrollView.contentSize =CGSizeMake(UIScreenWidth,UIScreenHeight*2-300);
    
}
- (void)setuptop{
    
    _mytitle.text=@"会议详情";
    
    [_topleftBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [_attachmentBtn addTarget:self action:@selector(attachmentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setuptop];
    
    UILabel *repaly = [[UILabel alloc]initWithFrame:CGRectMake(15, 540, 320, 20)];
    repaly.text = @"应答情况";
    [self.MeetScrollView addSubview:repaly];
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 565, 300, 200)];
    _theTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _theTableView.dataSource=self;
    _theTableView.delegate=self;
    _theTableView.backgroundColor=[UIColor clearColor];
    [self.MeetScrollView addSubview:_theTableView];
    
    
    UIImage *image1 =[Constant scaleToSize:[UIImage imageNamed:@"a5"] size:CGSizeMake(160, 47)];
    UIImage *image1_1 =[Constant scaleToSize:[UIImage imageNamed:@"a5 - 副本"] size:CGSizeMake(160, 47)];
    RKTabItem * joinItem =[RKTabItem createUsualItemWithImageEnabled:image1 imageDisabled:image1_1];
    joinItem.titleFontColor=[UIColor blackColor];
    joinItem.titleFont=[UIFont systemFontOfSize:20];
//    joinItem.titleString = @"确认参加";
    
    UIImage *image2 =[Constant scaleToSize:[UIImage imageNamed:@"a2"] size:CGSizeMake(300, 47)];
    UIImage *image2_1 =[Constant scaleToSize:[UIImage imageNamed:@"a2 - 副本"] size:CGSizeMake(300, 47)];
    RKTabItem * unjoinItem =[RKTabItem createUsualItemWithImageEnabled:image2 imageDisabled:image2_1];
    unjoinItem.titleFontColor=[UIColor blackColor];
    unjoinItem.titleFont=[UIFont systemFontOfSize:20];
//    unjoinItem.titleString = @"取消参加";
    
    UIImage *image3 =[Constant scaleToSize:[UIImage imageNamed:@"a3"] size:CGSizeMake(160, 47)];
    UIImage *image3_1 =[Constant scaleToSize:[UIImage imageNamed:@"a3 - 副本"] size:CGSizeMake(160, 47)];
    agree =[RKTabItem createUsualItemWithImageEnabled:image3 imageDisabled:image3_1];
    agree.titleFontColor=[UIColor blackColor];
    agree.titleFont=[UIFont systemFontOfSize:20];
//    agree.titleString = @"同意";
    
    UIImage *image4_1 =[Constant scaleToSize:[UIImage imageNamed:@"a4"] size:CGSizeMake(160, 47)];
    UIImage *image4 =[Constant scaleToSize:[UIImage imageNamed:@"a4 - 副本"] size:CGSizeMake(160, 47)];
    delete =[RKTabItem createUsualItemWithImageEnabled:image4 imageDisabled:image4_1];
    delete.titleFontColor=[UIColor blackColor];
    delete.titleFont=[UIFont systemFontOfSize:20];
//    delete.titleString = @"不同意";
    
    _titledTabsView =[[RKTabView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-50, UIScreenWidth, 50)];
    _titledTabsView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_titledTabsView];
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    self.titledTabsView.delegate = self;
//    [self.titledTabsView swtichTab:joinItem];
    

    
    status = [_meetData objectForKey:@"attendstatu"];
    if ([status isEqual:[NSNull null]]) {
        status = @"";
    }
    
    if (self.tag ==0) {
        self.titledTabsView.hidden=NO;
        if ([status isEqualToString:@"暂未定义"]) {
            self.titledTabsView.tabItems = @[joinItem,unjoinItem];
        }else if ([status isEqualToString:@"确定参加"]){
            self.titledTabsView.tabItems = @[unjoinItem];
        }else if([status isEqualToString:@"拒绝参与"]){
            self.titledTabsView.tabItems = @[joinItem];
        }else{
           self.titledTabsView.hidden = YES;
        }
    }else if (self.tag ==1){
        if (_aduitflag ==0) {
            self.titledTabsView.tabItems = @[agree,delete];
        }else{
            self.titledTabsView.hidden=YES;
        }
    
    }else if (self.tag ==2){
        self.titledTabsView.hidden=YES;
    }else{ // 我发起的会议
        self.titledTabsView.hidden = YES;
    }

    _MeetContact.editable=NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self loadData];
}
// 加载基础数据API
- (void)loadData{
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    int meetid = [[_meetData objectForKey:@"id"]intValue];
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/user_wait_meeting_detail?meetingId=%d",serverAddress,meetid];
   
    urlAddress =  [urlAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
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


- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    
    MeetDetailData = [rspBody objectForKey:@"meeting"];
    MeetUserArray = [MeetDetailData objectForKey:@"meetingUsers"];
    BOOL hasAttachs = [[MeetDetailData objectForKey:@"hasAttachs"]boolValue];
    if (hasAttachs) {
        self.attachmentBtn.hidden = NO;
    }else{
        self.attachmentBtn.hidden = YES;
    }
    
    meetingAttachsData =[MeetDetailData objectForKey:@"meetingAttachs"];
    
    
    [self loadMeetView];
    
    [self.theTableView reloadData];
    [SVProgressHUD dismissWithSuccess:@""];
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];
}


- (void )loadMeetView{

    for (NSString *key in MeetDetailData.allKeys) {
        if ([[MeetDetailData objectForKey:key] isEqual:[NSNull null]]) {
            [MeetDetailData setValue:@"" forKey:key];
        }
    }
    
    
    NSString *startDay = [MeetDetailData objectForKey:@"startDay"]; //开始时间
    NSString *endDay = [MeetDetailData objectForKey:@"endDay"];  //结束时间
    NSString *meetName = [MeetDetailData objectForKey:@"name"];  // 会议名称
    NSString *userBySummaryuser = [MeetDetailData objectForKey:@"userBySummaryuser"]; //纪要人
    NSString *contact = [MeetDetailData objectForKey:@"content"];  // 会议内容
    NSString *hoster = [MeetDetailData objectForKey:@"emceeUser"];  // 支持人
    NSString *company =[MeetDetailData objectForKey:@"deptByTransactdept"];  // 主办部门
    NSString *meetingtype=[MeetDetailData objectForKey:@"meetingtype"];   // 会议类型
    NSString *roomName =[MeetDetailData objectForKey:@"rooms"];  //会议室
    NSString *userNum = [MeetDetailData objectForKey:@"atCount"];  //会议人数
    int aduitflag =[[MeetDetailData objectForKey:@"aduitflag"]intValue];
    NSMutableArray *meetingAttachs = [MeetDetailData objectForKey:@"meetingAttachs"];
    NSMutableArray *meetSerArray = [MeetDetailData objectForKey:@"meetingServer"];  // 会议服务
    NSDictionary *meetSerDict;
    NSString *meetServe;
    NSMutableArray *names = [[NSMutableArray alloc]init];
    for (meetSerDict in meetSerArray) {
        NSString *meetServe = [meetSerDict objectForKey:@"name"];
        [names addObject:meetServe];
    }
    if (names.count!=0) {
        meetServe = [names componentsJoinedByString:@","];
    }
    
    
    
  
    _startTime.text = startDay;
    _endTime.text = endDay;
    _meetName.text = meetName;
    _summaryPerson.text =userBySummaryuser;
    _meetType.text =meetingtype;
    _MeetContact.text= contact;
    _MeetRoom.text =roomName;
    _meetServe.text =meetServe;
    _meetUserNum.text =userNum;
    _company.text =company;
    _hoster.text =hoster;
}



- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    
    if([status isEqualToString:@"暂未定义"]){
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                joinStatus = @"1";
//                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData1];
             
            }];
        }else if (index == 1){
            [UIView animateWithDuration:0.2 animations:^{
                joinStatus = @"0";
//                [SVProgressHUD showWithStatus:@"加载中..."];
                [self cancelJoin];
            }];
        }
    }
    else if ([status isEqualToString:@"确定参加"]){
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                joinStatus = @"0";
//                [SVProgressHUD showWithStatus:@"加载中..."];
                [self cancelJoin];
                
            }];
        }
    }
    else if([status isEqualToString:@"拒绝参与"]){
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                joinStatus = @"1";
//                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData1];
                
            }];
        }
    
    }
    else if (_aduitflag ==0){
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                auditStatus = @"pass";
//                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData2];
                
            }];
        }else{
            if (index == 1) {
                [UIView animateWithDuration:0.2 animations:^{
                    auditStatus = @"reject";
//                    [SVProgressHUD showWithStatus:@"加载中..."];
                    [self unAgree];
                    
                }];
            }
        }
    }
    
}

- (void)unAgree{
    UITextField *textField;
    BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:@"备注原因" message:nil textField:&textField block:^(BlockTextPromptAlertView *alert){
        [alert.textField resignFirstResponder];
        return YES;
    }];
    
    
    [alert setCancelButtonWithTitle:@"取消" block:nil];
    [alert addButtonWithTitle:@"确定" block:^{
        
        //post方式退回
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        [headers setObject:@"application/json" forKey:@"Content-type"];
        
        NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
        
        [parameter setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:@"memo"];
        
        [self sendDataPacket1:parameter];
        
    }];
    [alert show];
    
}

- (void)cancelJoin{
    UITextField *textField;
//    BlockTextPromptAlertView *alert = [BlockTextPromptAlertView promptWithTitle:@"拒绝原因" message:nil textField:&textField block:^(BlockTextPromptAlertView *alert){
//        [alert.textField resignFirstResponder];
//        return YES;
//    }];
//    
//    
//    [alert setCancelButtonWithTitle:@"取消" block:nil];
//    [alert addButtonWithTitle:@"确定" block:^{
//        if (textField.text.length<=0) {
//            
//        }else{ //post方式退回
//            NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
//            [headers setObject:@"application/json" forKey:@"Content-type"];
//            
//            NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
//            
//            [parameter setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:@"reason"];
//            
//            [self sendDataPacket:parameter];}
//       
//        
//    }];
//    [alert show];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拒绝原因" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
        
    }];
    
    UIAlertAction *ok =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
            [headers setObject:@"application/json" forKey:@"Content-type"];

            NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];

            [parameter setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:@"reason"];

            [self sendDataPacket:parameter];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    ok.enabled=NO;
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:NO completion:nil];
}
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        OALog(@"xxxxxx:%@",login.text);
        UIAlertAction *okAction = alertController.actions.firstObject;
        okAction.enabled = login.text.length > 0;
    }
}
//拒绝参与API
-(void) sendDataPacket:(NSMutableDictionary *)param{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString  *meetid = [_meetData objectForKey:@"id"];
    
    
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/wait_meeting_responsion",serverAddress];
    
    urlAddress =  [urlAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
//    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:meetid forKey:@"meetingId"];
    [param setObject:joinStatus forKey:@"responsionstatu"];
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];




}

//同意参与API
- (void)loadData1{
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString  *meetid = [_meetData objectForKey:@"id"];
    
   
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/wait_meeting_responsion",serverAddress];
    
    urlAddress =  [urlAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:meetid forKey:@"meetingId"];
    [param setObject:joinStatus forKey:@"responsionstatu"];
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    [postbody appendData:data];
    [request setPostBody:postbody];

    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];

    

}

//审核同意API
- (void)loadData2{
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString  *meetid = [_meetData objectForKey:@"id"];
    
    
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/aduit_meeting_responsion",serverAddress];
    
    urlAddress =  [urlAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:meetid forKey:@"meetingId"];
    [param setObject:auditStatus forKey:@"auditStatus"];
    [param setObject:@"" forKey:@"memo"];
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    [postbody appendData:data];
    [request setPostBody:postbody];
    
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];
    
    
    
}

//审核不同意API
-(void) sendDataPacket1:(NSMutableDictionary *)param{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString  *meetid = [_meetData objectForKey:@"id"];
    
    
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/aduit_meeting_responsion",serverAddress];
    
    urlAddress =  [urlAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    //    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:meetid forKey:@"meetingId"];
    [param setObject:auditStatus forKey:@"auditStatus"];
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];
    
    
    
    
}

- (void)GetResult1:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) GetErr1:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MeetUserArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 85;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *newfilecell = @"newfilecaretorycell";
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:newfilecell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newfilecell];
        NSDictionary * data = [MeetUserArray objectAtIndex:indexPath.row];
        
        NSString *user = [data objectForKey:@"user"];
        NSString *responsionstatu = [data objectForKey:@"responsionstatu"];
        NSString *timedata =[data objectForKey:@"responsionsdate"];
        NSString *reason = [data objectForKey:@"reason"];
        if ([reason isEqual:[NSNull null]]) {
            reason =@"";
        }
        
        UILabel *joinUser = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
        joinUser.font = [UIFont systemFontOfSize:13];
        joinUser.text = @"与会人员:";
        [cell.contentView addSubview:joinUser];
        
        UILabel *usertxt = [[UILabel alloc]initWithFrame:CGRectMake(75, 10, 60, 20)];
        usertxt.font = [UIFont systemFontOfSize:13];
        usertxt.text =user;
        [cell.contentView addSubview:usertxt];
        
        UILabel *repaly = [[UILabel alloc]initWithFrame:CGRectMake(170, 10, 60, 20)];
        repaly.font = [UIFont systemFontOfSize:13];
        repaly.text = @"应答情况:";
        [cell.contentView addSubview:repaly];
        
        UILabel *repalytxt = [[UILabel alloc]initWithFrame:CGRectMake(230, 10, 60, 20)];
        repalytxt.font = [UIFont systemFontOfSize:13];
        repalytxt.text = responsionstatu;
        [cell.contentView addSubview:repalytxt];
        
        UILabel *time =[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 60, 20)];
        time.font =[UIFont systemFontOfSize:13];
        time.text = @"应答时间:";
        [cell.contentView addSubview:time];
        
        UILabel *timetxt = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 150, 20)];
        timetxt.font =[UIFont systemFontOfSize:13];
        timetxt.text = timedata;
        [cell.contentView addSubview:timetxt];
        
        UILabel *remarks = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 40, 20)];
        remarks.font = [UIFont systemFontOfSize:13];
        remarks.text = @"备注:";
        [cell.contentView addSubview:remarks];
        
        UILabel *remarkstxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 60, 220, 20)];
        remarkstxt.font = [UIFont systemFontOfSize:13];
        remarkstxt.text = reason;
        [cell.contentView addSubview:remarkstxt];
        
//        cell.alpha= 0.5;
//        cell.backgroundColor=[UIColor grayColor];
        
    }
    return  cell;
}


- (void)backBtn {
    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)attachmentClick:(id)sender {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AttachmentListViewController * vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"AttachmentListViewController"];
    vc.attachType = 9;
    vc.listData = meetingAttachsData;
    [self.navigationController pushViewController:vc animated:NO];
//    [self presentViewController:vc animated:NO completion:nil];
}
@end
