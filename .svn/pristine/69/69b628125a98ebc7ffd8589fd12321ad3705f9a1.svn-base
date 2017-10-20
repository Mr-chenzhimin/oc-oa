//
//  MeetCreateViewController.m
//  OA
//
//  Created by admin on 16/7/29.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import "MeetCreateViewController.h"
#import "Constant.h"
#import "SBJsonParser.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ShowUserViewController.h"
#import "UIActionSheet+NTESBlock.h"
#import "CollectviewChooseCell.h"
#import "YUDatePicker.h"
#define Height 520
@interface MeetCreateViewController (){
    NIDropDown *meetRoomType;
    NIDropDown *meetRoomDown;
    NSMutableArray *dataArray;
    NSMutableArray *meetingRoomsArray;
    NSMutableArray *meetingTypesArray;
    NSDictionary *meetingSersDict;
    NSString *roomid;
    NSString *attendsUserIds;
    NSString *summarid;
    NSString *hosterid;
    
//    XFDaterView *Timedater;
    NSArray *meetSerArry;
    NSMutableArray *chooseArr;
    
    // 是否发送短信   1 发送  0不发送
    NSString *sendSMS;
    
}
@property (strong, nonatomic) UIDatePicker *datePicker;
@end

@implementation MeetCreateViewController


-(YUDatePicker*)datePicker{
    YUDatePicker *datePicker = [ [ YUDatePicker alloc] init];
    datePicker.datePickerMode = UIYUDatePickerModeDateYYYYMMDDHHmm;
    
    NSDate* minDate = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate* maxDate = [NSDate date];
    datePicker.minimumDate = maxDate;
    datePicker.maximumDate = maxDate;
    datePicker.date = maxDate;
    
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    return datePicker;
}

-(void)viewDidLayoutSubviews{
    
    self.CreateScrollView.contentSize =CGSizeMake(UIScreenWidth,UIScreenHeight*2-250);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     chooseArr =[[NSMutableArray alloc]init];
    
    NSString * notif_send_meet_user = @"notif_create_meet_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:notif_send_meet_user object:nil];
    
    NSString * notif_send_hoster_user = @"notif_create_hoster_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable1:) name:notif_send_hoster_user object:nil];
    
    NSString * notif_send_summary_user = @"notif_create_summary_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable2:) name:notif_send_summary_user object:nil];
    
    self.applicant.text = [Utils getCacheForKey:@"username"];
    
    _meetName.delegate =self;
    _meetName.tag = 33;
    _contact.delegate = self;
    //会议服务
    
    UIView *meetserbg =[[UIView alloc]initWithFrame:CGRectMake(23, Height-1, 282, 77)];
    meetserbg.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.CreateScrollView addSubview:meetserbg];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    self.meetserCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(24, Height, 280, 75) collectionViewLayout:layout1];
    [self.meetserCollectView registerClass:[CollectviewChooseCell class] forCellWithReuseIdentifier:@"CollectviewChooseCell"];
    self.meetserCollectView.backgroundColor=[UIColor whiteColor];
    self.meetserCollectView.tag = 99;
    self.meetserCollectView.delegate = self;
    self.meetserCollectView.dataSource=self;
    [self.CreateScrollView addSubview:self.meetserCollectView];
    
    //与会人员
    UILabel *joinUsers = [[UILabel alloc]initWithFrame:CGRectMake(24, Height+100, 320, 20)];
    joinUsers.text = @"与会人员";
    [self.CreateScrollView addSubview:joinUsers];
       //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
//    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
//    layout.itemSize =CGSizeMake(70, 70);
    
    UIView *joinUserbg =[[UIView alloc]initWithFrame:CGRectMake(19, 654, 282, 152)];
    joinUserbg.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.CreateScrollView addSubview:joinUserbg];
    
    self.joinUserCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 655, 280, 150) collectionViewLayout:layout];
    [self.joinUserCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"joinUserCollectionViewCell"];
    self.joinUserCollectView.backgroundColor=[UIColor whiteColor];
    self.joinUserCollectView.delegate = self;
    self.joinUserCollectView.dataSource=self;
    [self.CreateScrollView addSubview:self.joinUserCollectView];
    
    [self.meetRoom addTarget:self action:@selector(meetRoomClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //是否发送短信
    float y = CGRectGetMaxY(_joinUserCollectView.frame)+2;
    
    UILabel *smslablel = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth-130, y, 120, 30)];
    smslablel.font =[UIFont fontWithName:@"Arial" size:14];
    smslablel.text = @"是否发送短信";
    [self.CreateScrollView addSubview:smslablel];
    
    _sendsms = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth-40, y, 30, 30)];
    [_sendsms setBackgroundImage:[UIImage imageNamed:@"icon_打勾"] forState:UIControlStateNormal];
    _sendsms.selected=NO;
    sendSMS =@"1";
    [_sendsms addTarget:self action:@selector(sendsmsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.CreateScrollView addSubview:_sendsms];
    
    
//    [self.startDay addTarget:self action:@selector(startDayClick:) forControlEvents:UIControlEventTouchUpInside];
    self.startDay.delegate=self;
    self.startDay.tag =99;
    
//    [self.endDay addTarget:self action:@selector(endDayClick:) forControlEvents:UIControlEventTouchUpInside];
    self.endDay.delegate=self;
    
    
    [self.hoster addTarget:self action:@selector(hosterClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.meetType addTarget:self action:@selector(meetTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.summaryUser addTarget:self action:@selector(summaryUserClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
     RKTabItem * saveItem =[RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:nil];
    saveItem.titleFontColor=[UIColor blackColor];
    saveItem.titleFont=[UIFont systemFontOfSize:20];
    saveItem.titleString = @"暂存";
    
    
    UIImage *image1 =[Constant scaleToSize:[UIImage imageNamed:@"a1"] size:CGSizeMake(320, 47)];
    UIImage *image1_1 =[Constant scaleToSize:[UIImage imageNamed:@"a1 - 副本"] size:CGSizeMake(320, 47)];
    RKTabItem * issueItem =[RKTabItem createUsualItemWithImageEnabled:image1 imageDisabled:image1_1];
    issueItem.titleFontColor=[UIColor blackColor];
    issueItem.titleFont=[UIFont systemFontOfSize:20];
//    issueItem.titleString = @"发布";
    
    
    _titledTabsView =[[RKTabView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-50, UIScreenWidth, 50)];
    _titledTabsView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_titledTabsView];
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    self.titledTabsView.delegate = self;
    
    self.titledTabsView.tabItems = @[issueItem];
    
    
//    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BgClick:)];
//    [oneFingerTwoTaps setNumberOfTapsRequired:1];
//    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
//    [self.CreateScrollView addGestureRecognizer:oneFingerTwoTaps];

}
- (void)sendsmsClick:(UIButton *)btn{
    
    btn.selected=!btn.selected;//每次点击都改变按钮的状态
    
    if(btn.selected){
        sendSMS =@"1";
        [_sendsms setBackgroundImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
    }else{
        sendSMS =@"0";
        [_sendsms setBackgroundImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
        //在此实现打勾时的方法
        
    }
    
    
    
}

- (IBAction)bgClick:(id)sender {
    [_meetName resignFirstResponder];
    [_startDay resignFirstResponder];
    [_endDay resignFirstResponder];
    [_contact resignFirstResponder];
    [_company resignFirstResponder];
    [_userNum resignFirstResponder];
}
- (void)BgClick:(UITapGestureRecognizer *)sender{
    [_meetName resignFirstResponder];
    [_startDay resignFirstResponder];
    [_endDay resignFirstResponder];
    [_contact resignFirstResponder];
    [_company resignFirstResponder];
    [_userNum resignFirstResponder];

}

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    if (index == 0) {
        [UIView animateWithDuration:0.2 animations:^{
    
//            [SVProgressHUD showWithStatus:@"加载中..."];
            [self savaloadData];
            
        }];
        
    }

}



-(void)viewWillAppear:(BOOL)animated{
    
    [self loadData];
}

#pragma mark - 基础api
-(void) loadData{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/user_meeting_room_application",serverAddress];
 
    
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
    
    
    
    meetingRoomsArray =[[NSMutableArray alloc]init];
    dataArray = [rspBody objectForKey:@"meetingRooms"];
    for (NSDictionary *dict in dataArray) {
        NSString *ids = [dict objectForKey:@"id"];
        NSString *roomName = [dict objectForKey:@"name"];
        [meetingRoomsArray addObject:roomName];
    }
    
    meetingTypesArray = [rspBody objectForKey:@"meetingCategory"];
    meetingSersDict =[rspBody objectForKey:@"roomSer"];
    
    //会议室
    NSString *name =_meetRoom.titleLabel.text;
    NSDictionary *meetRoomDict = [[NSDictionary alloc]init];
    if (name) {
        _meetRoom.titleLabel.text = name;
    }else{
        meetRoomDict = [dataArray objectAtIndex:0];
        name =[meetRoomDict objectForKey:@"name"];
        _meetRoom.titleLabel.text = name;
        [self.meetRoom setTitle:name forState:UIControlStateNormal] ;
    }
    
    
    for (NSDictionary *dict in dataArray) {
        NSString *roomName = [dict objectForKey:@"name"];
        if ([name isEqualToString:roomName]) {
            roomid = [[dict objectForKey:@"id"]stringValue];
            NSLog(@"%@", roomid);
        }
        
    }
    //会议服务
    meetSerArry  =[[NSArray alloc]init];
    meetSerArry =[meetingSersDict objectForKey:roomid];
    [self.meetserCollectView reloadData];
    
    
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




#pragma mark - 发布api
-(void) savaloadData{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString *chooseser =@"";
    if (chooseArr.count!=0) {
        chooseser = [chooseArr componentsJoinedByString:@","];
    }
    
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/user_meeting_save",serverAddress];
    
    
    urlAddress =  [urlAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    
    if ([_meetType.titleLabel.text isEqualToString:@"请选择会议类型"]) {
        _meetType.titleLabel.text =@"<无>";
    }
    NSString *meetTypestr =_meetType.titleLabel.text;
    if (!self.meetName.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入会议名称"];
        return;
    }
    if (!self.startDay.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入开始时间"];
        return;
    }
    if (!self.endDay.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入结束时间"];
        return;
    }
    if (!hosterid) {
        hosterid=@"";
    }
    if (!summarid) {
        [SVProgressHUD showErrorWithStatus:@"请选择纪要人"];
        return;
    }
    if (!attendsUserIds.length) {
        [SVProgressHUD showErrorWithStatus:@"请选择与会人员"];
        return;
    }
    

    
//    请求参数
//    |name|string|会议名称|必填|
//    |meetingtype|string|会议类型|选填|
//    |startDay|string|起始时间 例:2016-07-21 11:06|必填|
//    |endDay|string|结束时间 例:2016-07-21 11:06|必填|
//    |atCount|string|会议人数|选填|
//    |roomid|string|会议室ID|必填|
//    |attendsUserIds|string|参与人员id数组 例:1,2,3|必填|
//    |userByEmceeuserId|string|主持人id|选填|
//    |userBySummaryuserId|string|纪要人id|必填|
//    |content|string|会议内容|选填|
//    |isSMS|string|是否短信发送通知 0不发送 1发送|选填|
//    |servercode|string|会议服务id字符串数组 例如:"4,5"|选填|
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:_meetName.text forKey:@"name"];
    [param setObject:roomid forKey:@"roomid"];
    [param setObject:self.startDay.text forKey:@"startDay"];
    [param setObject:self.endDay.text forKey:@"endDay"];
    [param setObject:self.contact.text forKey:@"content"];
    [param setObject:hosterid forKey:@"userByEmceeuserId"];
    [param setObject:self.meetType.titleLabel.text forKey:@"meetingtype"];
    [param setObject:summarid forKey:@"userBySummaryuserId"];
    [param setObject:self.userNum.text forKey:@"atCount"];
    [param setObject:attendsUserIds forKey:@"attendsUserIds"];
    [param setObject:chooseser forKey:@"servercode"];
    [param setObject:sendSMS forKey:@"isSMS"];
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    [postbody appendData:data];
    [request setPostBody:postbody];
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
}

- (void)GetResult1:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    NSString *msg = [rspHeader objectForKey:@"msg"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {

        if ([msg isEqualToString:@"通知参与者参加会议成功"]||[msg isEqualToString:@"申请会议室,请等待管理员审核"]) {
            [self.navigationController popViewControllerAnimated:NO];
//            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
//    [self dismissViewControllerAnimated:NO completion:nil];
    
    
    
}

- (void)GetResult2:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    
    [SVProgressHUD dismissWithSuccess:@""];
}





- (IBAction)roomClick:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithArray:meetingRoomsArray];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], nil];
    if(meetRoomDown == nil) {
        CGFloat f = _meetRoom.frame.size.height*(meetingRoomsArray.count+1);
        meetRoomDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        meetRoomDown.delegate = self;
    }
    else {
        [meetRoomDown hideDropDown:sender];
        [self rel];
    }
}

- (void)startDayClick:(id *)sender{
    
//    dater=[[XFDaterView alloc]initWithFrame:CGRectZero];
//    dater.delegate=self;
//    dater.tag =1;
//    [dater showInView:self.view animated:YES];
    



//    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
//    datePicker.minimumDate = [NSDate date];
//    datePicker.maximumDate = [NSDate dateWithTimeInterval:(24*60*60*2) sinceDate:datePicker.minimumDate];
//    datePicker.minuteInterval = 10;
//    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alert.view addSubview:datePicker];
//    
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//        //实例化一个NSDateFormatter对象
//        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];//设定时间格式
//        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
//        //求出当天的时间字符串
//        NSLog(@"%@",dateString);
//        self.startDay.titleLabel.text=dateString;
//        [self.startDay setTitle:dateString forState:UIControlStateNormal];
//    }];
////    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
////    }];
//    
//    [alert addAction:ok];
////    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:^{ }];
    

}

- (void)endDayClick:(id *)sender{
    
    
//    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
//    datePicker.minimumDate = [NSDate date];
//    datePicker.maximumDate = [NSDate dateWithTimeInterval:(24*60*60*2) sinceDate:datePicker.minimumDate];
//    datePicker.minuteInterval = 10;
//    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alert.view addSubview:datePicker];
//    
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//        //实例化一个NSDateFormatter对象
//        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];//设定时间格式
//        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
//        //求出当天的时间字符串
//        NSLog(@"%@",dateString);
//        self.endDay.titleLabel.text=dateString;
//        [self.endDay setTitle:dateString forState:UIControlStateNormal];
//    }];
//    //    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//    //    }];
//    
//    [alert addAction:ok];
//    //    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:^{ }];
    


}

- (void)hosterClick:(id *)sender{
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowUserViewController * vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    vc.noti_name = @"notif_create_hoster_user";
    [self presentViewController:vc animated:YES completion:^(void){}];
    
}

- (void)meetTypeClick:(id)sender{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithArray:meetingTypesArray];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], nil];
    if(meetRoomType == nil) {
        CGFloat f = 130;
        meetRoomType = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        meetRoomType.tag=1111;
        meetRoomType.delegate = self;
    }
    else {
        [meetRoomType hideDropDown:sender];
        [self rel];
    }
    
}

- (void)summaryUserClick:(id *)sender{
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowUserViewController * vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    vc.noti_name = @"notif_create_summary_user";
    [self presentViewController:vc animated:YES completion:^(void){}];
    
}

- (void)meetRoomClick: (id)sender{


    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithArray:meetingRoomsArray];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], nil];
    if(meetRoomDown == nil) {
        CGFloat f = _meetRoom.frame.size.height*(meetingRoomsArray.count+1);
        meetRoomDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
         meetRoomDown.tag=2222;
        meetRoomDown.delegate = self;
    }
    else {
        [meetRoomDown hideDropDown:sender];
        [self rel];
    }

}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    OALog(@"%@", sender.text);
    
    if (sender.tag ==1111) {
        
         _meetType.titleLabel.text = sender.text;
        
    }else if (sender.tag ==2222){
        
        _meetRoom.titleLabel.text = sender.text;
        NSString *name =_meetRoom.titleLabel.text;
        for (NSDictionary *dict in dataArray) {
            NSString *roomName = [dict objectForKey:@"name"];
            if ([name isEqualToString:roomName]) {
                roomid = [[dict objectForKey:@"id"]stringValue];
                NSLog(@"%@", roomid);
            }
            
        }
    }
    
    //会议服务
    meetSerArry  =[[NSArray alloc]init];
    meetSerArry =[meetingSersDict objectForKey:roomid];
    [self.meetserCollectView reloadData];
    
   
  
}
-(void)rel{
    //    [dropDown release];
    meetRoomDown = nil;
     meetRoomType= nil;
}

-(void)dateChanged:(id)sender{
    YUDatePicker* control = (YUDatePicker*)sender;
    NSLog(@"date ==%@ ",control.dateStr);
    NSDate *start_date;
    
    if (control.tag==99) {
        start_date = control.date;
        NSDate * curredata = [NSDate date];
        NSComparisonResult result = [start_date compare:curredata];
        if (result == NSOrderedAscending){
            [SVProgressHUD showErrorWithStatus:@"开始时间不小于当前时间"];
            return;
        }
        _startDay.text = control.dateStr;
    }else{
        NSString *starttime =_startDay.text;
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        NSDate *dateA = [dateFormatter dateFromString:starttime];
        
        NSDate *dateB = [dateFormatter dateFromString:control.dateStr];
        
        NSComparisonResult result = [dateA compare:dateB];
        
        if (result == NSOrderedDescending) {
            [SVProgressHUD showErrorWithStatus:@"结束时间不小于开始时间"];
            return;
        }
        else if (result == NSOrderedAscending){
        }else{
            [SVProgressHUD showErrorWithStatus:@"结束时间不小于开始时间"];
            return;
        }
        _endDay.text = control.dateStr;
    }
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (range.location >=50) {
//        [SVProgressHUD showErrorWithStatus:@"会议名称最多为50字符"];
//        return NO;
//    }else{
//        return YES;
//    }
//
//}

// 会议内容限制为4000字
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView.tag==33){
        if (range.location >=50) {
            [SVProgressHUD showErrorWithStatus:@"会议名称最多为50字符"];
            return NO;
        }else{
            return YES;
        }
    
    }else{
        if (range.location>=500)
        {
            [SVProgressHUD showErrorWithStatus:@"会议内容最多为500字符"];
            return  NO;
        }
        else
        {
            return YES;
        }
    }
   
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag != 33) {
        UIDatePicker *datePicker = self.datePicker;
        datePicker.tag = textField.tag;
        textField.inputView = datePicker;
        if (datePicker.tag ==99) {
            _startDay = textField;
        }else{
            _endDay = textField;
        }
    }
   
    

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==99) {
        return meetSerArry.count;
    }else{
        return self.joinUserArry.count+1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    int index = indexPath.row;
    int count = self.joinUserArry.count;
    if (collectionView.tag ==99) {

        CollectviewChooseCell *cell = (CollectviewChooseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectviewChooseCell" forIndexPath:indexPath];
        NSDictionary *dict = [meetSerArry objectAtIndex:index];
        NSString *name = [dict objectForKey:@"name"];
        
        cell.titleLab.text = name;
        [cell.SelectIconBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cell.SelectIconBtn setTitle:name forState:UIControlStateNormal];
        
        
        return cell;
    }
    else{
        UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"joinUserCollectionViewCell" forIndexPath:indexPath];
        
        for (UIView *view in [cell.contentView subviews]) {
            [view removeFromSuperview];
        }
        
        if (index==self.joinUserArry.count||self.joinUserArry.count==0) {
            UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 40, 40)];
            [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
            [addBtn setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
            
            [cell.contentView addSubview:addBtn];
        }
        else{
            
            
            NSDictionary *dict = [self.joinUserArry objectAtIndex:index];
            NSString *name = [dict objectForKey:@"name"];
            
            
            UIImageView *AppImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 40)];
            AppImage.image=[UIImage imageNamed:@"icon_user_del"];
            
            UILabel *AppName = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, cell.contentView.frame.size.width, 20)];
            AppName.textAlignment = NSTextAlignmentCenter;
            AppName.font = [UIFont systemFontOfSize:12];
            AppName.text = name;
            AppName.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:AppName];
            [cell.contentView addSubview:AppImage];
            
        }
        return cell;
    }
    
    return nil;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView.tag ==99) {
        CollectviewChooseCell * cell = (CollectviewChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NSDictionary *dict = [meetSerArry objectAtIndex:indexPath.row];
        NSString *servercodeId = [dict objectForKey:@"id"];
        
        BOOL selected = [meetSerArry containsObject:dict];
        
        
        [cell UpdateCellWithState:!cell.isSelected];
        if (cell.isSelected) {
            [chooseArr addObject:servercodeId];
            [cell.SelectIconBtn setImage:[UIImage imageNamed:@"back_xz"] forState:UIControlStateSelected];
        }
        else{
            [chooseArr removeObject:servercodeId];
            [cell.SelectIconBtn setImage:[UIImage imageNamed:@"back_xz"] forState:UIControlStateSelected];
        }
        

    }else{
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"是否移除用户" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"移除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnullaction) {
            [self.joinUserArry removeObjectAtIndex:indexPath.row];
            
            [self.joinUserCollectView reloadData];
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnullaction) {
           
        }];
        [alert addAction:ok];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
    }
    OALog(@"zzzzzzzzz%@",chooseArr);
}



////设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==99) {
        return CGSizeMake(50, 50);
    }else{
        return CGSizeMake(60, 60);
    }
}

-(void) reloadMonitorTable:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    NSMutableArray *arry = [[NSMutableArray alloc]init];
    self.joinUserArry = [dataDic objectForKey:@"select_user_array"];
    for (NSDictionary *dict in self.joinUserArry) {
        NSString *joinUserId = [dict objectForKey:@"id"];
        [arry addObject:joinUserId];
    }
    attendsUserIds = [arry componentsJoinedByString:@","];
    
    [self.joinUserCollectView reloadData];
    
}
-(void) reloadMonitorTable1:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    self.hosterArry = [dataDic objectForKey:@"select_user_array"];
    if (self.hosterArry.count>0) {
        NSDictionary *dict = [self.hosterArry objectAtIndex:0];
        hosterid =[dict objectForKey:@"id"];
        NSString *hoster =[dict objectForKey:@"name"];
        self.hoster.titleLabel.text= hoster;
        [self.hoster setTitle:hoster forState:UIControlStateNormal];
    }

    
}

-(void) reloadMonitorTable2:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    self.summaryArry = [dataDic objectForKey:@"select_user_array"];
    if (self.summaryArry.count>0) {
        NSDictionary *dict = [self.summaryArry objectAtIndex:0];
        summarid =[dict objectForKey:@"id"];
        NSString *summar =[dict objectForKey:@"name"];
        self.summaryUser.titleLabel.text= summar;
        [self.summaryUser setTitle:summar forState:UIControlStateNormal];
    }
}

- (void)addClick:(UIButton *)sender{
    
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowUserViewController * vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    vc.noti_name = @"notif_create_meet_user";
    vc.selectUserArray = self.joinUserArry;
    [self presentViewController:vc animated:YES completion:^(void){}];
    
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



- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}
@end
