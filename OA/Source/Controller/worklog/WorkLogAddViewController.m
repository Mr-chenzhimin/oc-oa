//
//  WorkLogAddViewController.m
//  OA
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import "WorkLogAddViewController.h"
#import "ASIHTTPRequest.h"
#import "Utils.h"
#import "SBJsonParser.h"
#import "JSON.h"
#import "ShowUserViewController.h"
#import "UIAlertView+NTESBlock.h"
#import "UIActionSheet+NTESBlock.h"
@interface WorkLogAddViewController (){

    // 手动选择状态    0暂存  1发布
    int status;
    //共享范围  1公开  2共享 3个人
    NSString *shareRang;
   
    //共享人员
    NSMutableArray * shareData;
    // 设置为默认共享人员   1 勾选  0不勾选
    int seleshareuser;

}


@end

@implementation WorkLogAddViewController
@synthesize shareRange;

- (void)shareuserimgClick:(UIButton *)btn{
    
    btn.selected=!btn.selected;//每次点击都改变按钮的状态
    
    if(btn.selected){
        seleshareuser =1;
        [_shareuserimg setBackgroundImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
    }else{
        seleshareuser =0;
        [_shareuserimg setBackgroundImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
        //在此实现打勾时的方法
        
    }
    


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString * notif_send_work_flow_user = @"notif_send_work_log_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:notif_send_work_flow_user object:nil];
    
    [self.shareUserCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"shareUserCollectionViewCell"];
    
//    self.shareUserCollectView.backgroundColor=[UIColor whiteColor];
    self.shareUserCollectView.delegate = self;
    self.shareUserCollectView.dataSource=self;
    
    [_shareuserimg setBackgroundImage:[UIImage imageNamed:@"icon_未打勾"] forState:UIControlStateNormal];
    _shareuserimg.selected=NO;
    seleshareuser =0;
    [_shareuserimg addTarget:self action:@selector(shareuserimgClick:) forControlEvents:UIControlEventTouchUpInside];

    
    self.shareRange.layer.cornerRadius = 4.0;
    self.shareRange.layer.masksToBounds = YES;
//    shareRange.layer.borderWidth = 1;
    shareRange.layer.borderColor = [[UIColor blackColor] CGColor];
//    [self.shareRange addTarget:self action:@selector(shareRangeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //本地读取共享人员
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//     NSArray *myArray = [userDefaultes arrayForKey:@"shareUserArry"];
//    _shareUserArry = [myArray mutableCopy];
//    if (_shareUserArry.count) {
//        [self.shareUserCollectView reloadData];
//    }
    // 本地读取共享范围
    int sharerang =[[userDefaultes stringForKey:@"shareRang"]intValue];
    if (sharerang == 1) {
        shareRang = @"1";
        [self.shareRange setTitle:@"公开" forState:UIControlStateNormal];
    }else if (sharerang == 3){
        shareRang = @"3";
        [self.shareRange setTitle:@"个人" forState:UIControlStateNormal];
    }else{
        shareRang = @"2";
        [self.shareRange setTitle:@"共享" forState:UIControlStateNormal];
    }
    
    int share = [[self.worklogData objectForKey:@"share"]intValue];
    NSString *content = [self.worklogData objectForKey:@"content"];
    NSString *workTime = [[self.worklogData objectForKey:@"workHour"]stringValue];
    NSString *pace = [[self.worklogData objectForKey:@"finish"]stringValue];
    NSString *keepUser = [self.worklogData objectForKey:@"assistUser"];
    NSString *logday = [_worklogData objectForKey:@"logDay"];
    if ([keepUser isEqual:[NSNull null]]) {
        keepUser =@"";
    }
    if (self.worklogTag == 0) {
        
        //获取默认的共享人员
        [self getdeflutshareuser];
        //新建
        if (logday ==nil) {
            NSString* logDay;
            NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            logDay = [formatter stringFromDate:[NSDate date]];
            _logday = logDay;
        }else{
            _logday = logday;
        }
        NSString *username = [Utils getCacheForKey:@"userName"];
        NSString *title = [NSString stringWithFormat:@"%@--%@--工作日志",_logday,username];
        _titletText.text = title;
        
        
    }else{
        // 修改
        if (share == 1) {
            shareRang = @"1";
            [self.shareRange setTitle:@"公开" forState:UIControlStateNormal];
        }else if (share == 2){
            shareRang = @"2";
            [self.shareRange setTitle:@"共享" forState:UIControlStateNormal];
        }else{
            shareRang = @"3";
            [self.shareRange setTitle:@"个人" forState:UIControlStateNormal];
        }
        self.workHour.text = workTime;
        self.titletText.text = self.titleStr;
        self.content.text = content;
        self.pace.text = pace;
        self.keepUser.text = keepUser;
    }
    
    self.right1.hidden =YES;
    self.right2.hidden =YES;
    self.titile.text = @"我的日志";
    
    UIImage *savesele =[Constant scaleToSize:[UIImage imageNamed:@"a8"] size:CGSizeMake(160, 47)];
    UIImage *save =[Constant scaleToSize:[UIImage imageNamed:@"a8 - 副本"] size:CGSizeMake(160, 47)];
    RKTabItem * saveItem =[RKTabItem createUsualItemWithImageEnabled:save imageDisabled:save];
    saveItem.titleFontColor=[UIColor blackColor];
    saveItem.titleFont=[UIFont systemFontOfSize:20];
//    saveItem.titleString = @"暂存";
    
    UIImage *issuesele =[Constant scaleToSize:[UIImage imageNamed:@"a7"] size:CGSizeMake(160, 47)];
    UIImage *issue =[Constant scaleToSize:[UIImage imageNamed:@"a7 - 副本"] size:CGSizeMake(160, 47)];
    RKTabItem * issueItem =[RKTabItem createUsualItemWithImageEnabled:issuesele imageDisabled:issuesele];
    issueItem.titleFontColor=[UIColor blackColor];
    issueItem.titleFont=[UIFont systemFontOfSize:20];
//    issueItem.titleString = @"发布";
    
    UIImage *deletesele =[Constant scaleToSize:[UIImage imageNamed:@"a20"] size:CGSizeMake(160, 47)];
    UIImage *delete =[Constant scaleToSize:[UIImage imageNamed:@"a20"] size:CGSizeMake(160, 47)];
    RKTabItem * deleteItem =[RKTabItem createUsualItemWithImageEnabled:delete imageDisabled:delete];
    deleteItem.titleFontColor=[UIColor blackColor];
    deleteItem.titleFont=[UIFont systemFontOfSize:20];
//    deleteItem.titleString = @"删除";
    
    _titledTabsView =[[RKTabView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-45, UIScreenWidth, 45)];
    _titledTabsView.backgroundColor=[UIColor whiteColor];
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    self.titledTabsView.delegate = self;
    
    [self.view addSubview:_titledTabsView];
    
    NSString *user = [Utils getCacheForKey:@"userName"];
    if ([user isEqualToString:@"admin"]) {
        user = @"超级用户";
    }
//    if ([_name isEqualToString:user] &&_name !=nil &&[user isEqualToString:@"admin"]) {
//        self.bodyView.userInteractionEnabled=YES;
//        _titledTabsView.hidden=NO;
//    }else{
//        self.bodyView.userInteractionEnabled=YES;
//        _titledTabsView.hidden=NO;
//    }
    
    if ([_name isEqualToString:user]|| _name == nil) {
        self.bodyView.userInteractionEnabled=YES;
        _titledTabsView.hidden=NO;
    }else{
    
        self.bodyView.userInteractionEnabled=NO;
        _titledTabsView.hidden=YES;
    }
   
    if (_status ==1) {// 发布
            
        if (self.worklogTag == 0) {  //增加内容
            self.titledTabsView.tabItems =@[issueItem];
        }
        else{
            self.titledTabsView.tabItems =@[issueItem,deleteItem];
        }
    }else if(_status ==0){  // 暂存
        if (self.worklogTag == 0) {
            self.titledTabsView.tabItems =@[issueItem,saveItem];
        }
        else{
            self.titledTabsView.tabItems =@[saveItem,issueItem,deleteItem];
        }
        
    }else{   // 新建状态
    
        self.titledTabsView.tabItems =@[issueItem,saveItem];
    }
    
    
//    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BgClick:)];
//    [oneFingerTwoTaps setNumberOfTapsRequired:1];
//    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
//    [self.bodyView addGestureRecognizer:oneFingerTwoTaps];
    
    
    
}
- (IBAction)bgClick:(id)sender {
    [_titletText resignFirstResponder];
    [_content resignFirstResponder];
    [_workHour resignFirstResponder];
    [_pace resignFirstResponder];
    [_keepUser resignFirstResponder];
}

- (void)BgClick:(UITapGestureRecognizer *)sender{
    [_titletText resignFirstResponder];
    [_content resignFirstResponder];
    [_workHour resignFirstResponder];
    [_pace resignFirstResponder];
    [_keepUser resignFirstResponder];
    
    
}


- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    // 发布   日志为发布状态时，新增内容或修改内容时 状态只能是发布
    if (_status ==1) {
        
        if (self.worklogTag == 0) {  //增加内容
            if (index == 0) {
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"发布");
                    self.worklogTag = 1;
                    status =1;
                    [self loadData];
                }];
            }
        }
        else{   //修改内容
            if (index == 0) {
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"发布");
                    status =1;
                    self.worklogTag =1;
                    [self loadData];
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"删除");
                    [self loadData1];
                }];
            }
        }
    }
    // 暂存  日志为暂存状态时，新增内容或修改内容时 状态可以是发布或暂存
    else if(_status == 0){
        if (self.worklogTag == 0) {
            
            if (index == 0) {
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"发布");
                    status =1;
                    self.worklogTag =1;
                    [self loadData];
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"暂存");
                    status = 0;
                    self.worklogTag =1;
                    [self loadData];
                }];
            }

        }
        else{
            if (index == 0) {
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"暂存");
                    status = 0;
                    self.worklogTag =1;
                    [self loadData];
                }];
            }else if(index == 1){
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"发布");
                    status =1;
                    self.worklogTag =1;
                    [self loadData];
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    OALog(@"删除");
                    [self loadData1];
                }];
            }
        }
        
    }
    else{
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                OALog(@"发布");
                status =1;
                self.worklogTag =0;
                [self loadData];
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                OALog(@"暂存");
                status = 0;
                self.worklogTag=0;
                [self loadData];
            }];
        }

    }
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)getdeflutshareuser{
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/get_worklog_default_shareuser",serverAddress];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSLog(@"======>url:%@",url);
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult2:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];
}

- (void)GetResult2:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rsBoby = [result objectForKey:@"rspBody"];
    
    _shareUserArry = [rsBoby objectForKey:@"list"];
    [self.shareUserCollectView reloadData];
    
    
    
}

- (void) GetErr1:(ASIHTTPRequest *)request{
    
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

//- (void)shareRangeClick:(id)sender{
//    NSArray * arr = [[NSArray alloc] init];
//    arr = [NSArray arrayWithObjects:@"共享", @"公开", @"个人",nil];
//    NSArray * arrImage = [[NSArray alloc] init];
//    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], nil];
//    if(dropDown == nil) {
//        CGFloat f = shareRange.frame.size.height*4;
//        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
//        dropDown.delegate = self;
//    }
//    else {
//        [dropDown hideDropDown:sender];
//        [self rel];
//    }
//
//
//}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    NSLog(@"%@", sender.text);
    
    shareRang = sender.text;
    NSLog(@"%d", shareRange.tag);
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}


- (void)dealloc{

    shareRange = nil;
    [self setShareRange:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)addBtn:(id)sender {
}




- (void)loadData{
    if (seleshareuser ==1) {
        [self setdeflutshareuser];
    }
    
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    // 0新增  1修改
    int isNew = self.worklogTag;
    NSString *isnew = [NSString stringWithFormat:@"%d",isNew];
    //日志id
    NSString *workID = self.workLogId;
    //内容id
    NSString *LogID = [[self.worklogData objectForKey:@"id"]stringValue];
    if (!LogID) {
        LogID =@"";
    }
    //标题
    NSString *title = self.titletText.text;
    //内容
    NSString *content = self.content.text;
    //工时
    NSString *Houer = self.workHour.text;
    // 进度
    NSString *pace = self.pace.text;
    // 配合人员
    NSString *keepUser = self.keepUser.text;
    
    // 共享人员
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in _shareUserArry) {
        NSString *uid = [dict objectForKey:@"id"];
        [arry addObject:uid];
    }
    NSString *shareUser=[arry componentsJoinedByString:@","];
    if (arry.count ==0) {
        shareUser =@"";
    }
    if (!self.titletText.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }
    
    if (!self.content.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入工作内容"];
        return;
    }
    //共享范围  1公开  2共享 3个人    
    if ([shareRang isEqualToString:@"公开"]) {
        shareRang = @"1";
    }else if ([shareRang isEqualToString:@"共享"]){
        shareRang = @"2";
    }else if ([shareRang isEqualToString:@"个人"]){
        shareRang = @"3";
    }    

    // 状态
    NSString *statustr = [NSString stringWithFormat:@"%d",status];
    
    //日志时期
    if(_logday ==nil){
        _logday =@"";
    }
    
    NSString* logDay;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    logDay = [formatter stringFromDate:[NSDate date]];
    
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/user_worklog_save",serverAddress];
    
    //    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    
    if (isNew ==1) {  //修改
        
        [param setObject:workID forKey:@"id"];
    }
    

    [param setObject:title forKey:@"title"];
    [param setObject:isnew forKey:@"isNew"];

    
    [param setValue:shareRang forKey:@"share"];
    [param setObject:statustr forKey:@"status"];
    [param setObject:content forKey:@"content"];
    
    if (_status ==3) {
       [param setObject:_logday forKey:@"logDay"];
    }else{
        [param setObject:logDay forKey:@"logDay"];
    }
    if (![LogID isEqualToString:@""]) {
        [param setObject:LogID forKey:@"mxid"];
    }
    
    if (![Houer isEqualToString:@""]) {
        [param setObject:Houer forKey:@"workHour"];
    }
    if (![pace isEqualToString:@""]) {
        [param setObject:pace forKey:@"finish"];
    }
    if (![shareUser isEqualToString:@""]) {
        [param setObject:shareUser forKey:@"userids"];
    }
    if (![keepUser isEqualToString:@""]) {
        [param setObject:keepUser forKey:@"assistUser"];
    }
    
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
    
}

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    //    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
//    // 1、写入共享范围
//    [UserDefaults setObject:_shareUserArry forKey:@"shareUserArry"];
    [UserDefaults setObject:shareRang forKey:@"shareRang"];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];
}



- (void)loadData1{
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
//    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_READ_LINE] forKey:@"ec_p"];
//    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_RETURN_COUNT] forKey:@"ec_crd"];
//    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString *LogID = [[self.worklogData objectForKey:@"id"]stringValue];
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/user_worklog_detail_delete?mx_ids=%@",serverAddress,LogID];
    
    //    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:LogID forKey:@"mx_ids"];
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];
    
    
}

- (void)GetResult1:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    //    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
}






- (void)shareUserClick:(id)sender{

}

// 工作内容限制为500字
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=500)
    {
         [SVProgressHUD showErrorWithStatus:@"工作内容最多为500字符"];
        return  NO;
    }
    else
    {
        return YES;
    }
}


- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shareUserArry.count +1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = indexPath.row;
    int count = self.shareUserArry.count;
    
    static NSString *collectionCellID = @"shareUserCollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    if (index==self.shareUserArry.count||self.shareUserArry.count==0) {
        UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 40, 40)];
        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.contentView addSubview:addBtn];
    }
    else{
    
        
        NSDictionary *dict = [self.shareUserArry objectAtIndex:index];
        NSString *name = [dict objectForKey:@"name"];
        
        
        UIImageView *AppImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 40)];
        AppImage.image=[UIImage imageNamed:@"icon_user_del"];
        
        UILabel *AppName = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, cell.contentView.frame.size.width, 20)];
        AppName.textAlignment = NSTextAlignmentCenter;
        AppName.font = [UIFont systemFontOfSize:12];
        AppName.text = name;
        
        [cell.contentView addSubview:AppName];
        [cell.contentView addSubview:AppImage];
    
    }
        

    
    return cell;
    
};


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"是否移除用户" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:@"移除" otherButtonTitles:nil,nil];
    [sheet showInView:self.view completionHandler:^(NSInteger index) {
        switch (index) {
            case 0:{
//                 [collectionView deselectItemAtIndexPath:indexPath animated:NO];
                [self.shareUserArry removeObjectAtIndex:indexPath.row];
                
                [self.shareUserCollectView reloadData];
                break;
            }
            default:
                break;
        }

    }];
    
  
}



-(void) reloadMonitorTable:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    _shareUserArry = [dataDic objectForKey:@"select_user_array"];
    
    [self.shareUserCollectView reloadData];

}

- (void)addClick:(UIButton *)sender{

    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowUserViewController * vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    vc.noti_name = @"notif_send_work_log_user";
    vc.selectUserArray = self.shareUserArry;
    [self presentViewController:vc animated:YES completion:^(void){}];

}
// 设置默认共享人员
- (void)setdeflutshareuser{
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in _shareUserArry) {
        NSString *uid = [dict objectForKey:@"id"];
        [arry addObject:uid];
    }
    NSString *shareUser=[arry componentsJoinedByString:@","];
    if (arry.count ==0) {
        shareUser =@"";
    }
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/save_worklog_default_shareuser?userids=%@",serverAddress,shareUser];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSLog(@"======>url:%@",url);
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
   
    NSMutableData * postbody = [[NSMutableData alloc] init];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:shareUser forKey:@"userids"];

    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [postbody appendData:data];
    
    [request setPostBody:postbody ];
    
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult3:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];

}

- (void)GetResult3:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    //    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    
}

//- (IBAction)defalutshareuser:(id)sender {
//    //设置默认的共享人员
//    [self setdeflutshareuser];
//}

- (IBAction)shareRangeClick:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"共享", @"公开", @"个人",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], nil];
    if(dropDown == nil) {
        CGFloat f = shareRange.frame.size.height*4;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
@end
