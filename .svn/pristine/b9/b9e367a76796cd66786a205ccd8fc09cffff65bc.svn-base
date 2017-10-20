//
//  MeetMangListViewController.m
//  OA
//
//  Created by admin on 16/8/3.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import "MeetMangListViewController.h"
#import "Utils.h"
#import "Constant.h"
#import "SBJsonParser.h"
#import "JSON.h"
#import "meetlistViewCell.h"
#import "MeetDetailsViewController.h"
#import "MeetCreateViewController.h"
@interface MeetMangListViewController (){
    RKTabItem * undojion;
    
    NSString *aduitStatus;
    
    UIView *typeView;
    UIView *typeView1;
    
    NSString *type;
    BOOL admin;
    BOOL aduitflag;
}
@property (nonatomic,assign) NSInteger index;


@end

@implementation MeetMangListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setuptop];
    
    _theTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, UIScreenWidth, UIScreenHeight-100)];
    _theTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _theTableView.tableFooterView = [[UIView alloc]init];
    _theTableView.dataSource=self;
    _theTableView.delegate=self;
    [self.view addSubview:_theTableView];
    
    
    UIImage *undojionimage1 =[Constant scaleToSize:[UIImage imageNamed:@"a15"] size:CGSizeMake(77, 47)];
    UIImage *undojionimage1_1 =[Constant scaleToSize:[UIImage imageNamed:@"a15 - 副本"] size:CGSizeMake(77, 47)];
    undojion =[RKTabItem createUsualItemWithImageEnabled:undojionimage1 imageDisabled:undojionimage1_1];
    undojion.titleFontColor=[UIColor blackColor];
    undojion.titleFont=[UIFont systemFontOfSize:20];
//    undojion.titleString = @"待参加";
    
    UIImage *undojionimage2_1 =[Constant scaleToSize:[UIImage imageNamed:@"a16"] size:CGSizeMake(77, 47)];
    UIImage *undojionimage2 =[Constant scaleToSize:[UIImage imageNamed:@"a16 - 副本"] size:CGSizeMake(77, 47)];
    RKTabItem * undocheck =[RKTabItem createUsualItemWithImageEnabled:undojionimage2 imageDisabled:undojionimage2_1];
    undocheck.titleFontColor=[UIColor blackColor];
    undocheck.titleFont=[UIFont systemFontOfSize:20];
//    undocheck.titleString = @"待审核";
    
    UIImage *undojionimage3_1 =[Constant scaleToSize:[UIImage imageNamed:@"a17"] size:CGSizeMake(77, 47)];
    UIImage *undojionimage3 =[Constant scaleToSize:[UIImage imageNamed:@"a17 - 副本"] size:CGSizeMake(77, 47)];
    RKTabItem * historymeet =[RKTabItem createUsualItemWithImageEnabled:undojionimage3 imageDisabled:undojionimage3_1];
    historymeet.titleFontColor=[UIColor blackColor];
    historymeet.titleFont=[UIFont systemFontOfSize:20];
//    historymeet.titleString = @"历史会议";
    
    UIImage *undojionimage4_1 =[Constant scaleToSize:[UIImage imageNamed:@"a18"] size:CGSizeMake(77, 47)];
    UIImage *undojionimage4 =[Constant scaleToSize:[UIImage imageNamed:@"a18 - 副本"] size:CGSizeMake(77, 47)];
    RKTabItem * advancet =[RKTabItem createUsualItemWithImageEnabled:undojionimage4 imageDisabled:undojionimage4_1];
    advancet.titleFontColor=[UIColor blackColor];
    advancet.titleFont=[UIFont systemFontOfSize:20];
//    advancet.titleString = @"新增会议";
    
    UIImage *setupimage4_1 =[Constant scaleToSize:[UIImage imageNamed:@"foot_m5_1"] size:CGSizeMake(77, 47)];
    UIImage *setupimage4 =[Constant scaleToSize:[UIImage imageNamed:@"foot_m5"] size:CGSizeMake(77, 47)];
    RKTabItem * setup =[RKTabItem createUsualItemWithImageEnabled:setupimage4_1 imageDisabled:setupimage4];
    setup.titleFontColor=[UIColor blackColor];
    setup.titleFont=[UIFont systemFontOfSize:20];
//    advancet.titleString = @"我发起会议";
    
    _titledTabsView =[[RKTabView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-50, UIScreenWidth, 50)];
    _titledTabsView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_titledTabsView];
    self.titledTabsView.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    self.titledTabsView.delegate = self;
    [self.titledTabsView swtichTab:undojion];
    self.titledTabsView.tabItems = @[undojion,undocheck,historymeet,advancet,setup];
    
//    NSString *user = [Utils getCacheForKey:@"loginId"];
//    admin = [user isEqualToString:@"admin"];
//    if (admin) {
//        self.titledTabsView.tabItems = @[undojion,undocheck,historymeet,advancet,setup];
//    }
    
//    UISearchBar *headerView =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 25)];
//    headerView.delegate = self;
//    _theTableView.tableHeaderView=headerView;
    
    typeView= [[UIView alloc]initWithFrame:CGRectMake(0, 50, UIScreenWidth, 35)];
    typeView.backgroundColor=[UIColor whiteColor];
    typeView.hidden=YES;
    [self.view addSubview:typeView];
    
    
    NSArray *arry = [NSArray arrayWithObjects:@"已参加",@"未参加",@"未答复" ,nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:arry];
    segmentedControl.frame = CGRectMake(25, 3, 270, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [typeView addSubview:segmentedControl];
    
    
    typeView1= [[UIView alloc]initWithFrame:CGRectMake(0, 50, UIScreenWidth, 35)];
    typeView1.backgroundColor=[UIColor whiteColor];
    typeView1.hidden=YES;
    [self.view addSubview:typeView1];
    
    NSArray *arry1 = [NSArray arrayWithObjects:@"待审核",@"审核通过" ,nil];
    segmentedControl1 = [[UISegmentedControl alloc]initWithItems:arry1];
    segmentedControl1.frame = CGRectMake(25, 3, 270, 30);
    
    [segmentedControl1 addTarget:self action:@selector(segmentAction1:) forControlEvents:UIControlEventValueChanged];
    [typeView1 addSubview:segmentedControl1];

    
    //下拉刷新
    _index =KEY_READ_LINE;
    _index =1;
    self.theTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _index -=KEY_RETURN_COUNT;
        if (_index <=1) {
            _index=1;
        }
        [self loadData];
        [self.theTableView.mj_header endRefreshing];
        
    }];
    self.theTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if(dataArray.count==KEY_RETURN_COUNT){
            _index +=KEY_RETURN_COUNT;
        }
        [self loadData];
        [self.theTableView.mj_footer endRefreshing];
    }];

    
    
    
    
}

- (void)setuptop{
    
    self.topMenuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 50)];
    self.topMenuView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"head背景.png"]];
    [self.view addSubview:self.topMenuView];
    self.view.backgroundColor=[UIColor whiteColor];
    _myTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 15, 100, 30)];
    _myTitleLabel.text=@"工作日志";
    
    
    _topleftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, 30, 30)];
    [_topleftBtn setBackgroundImage:[UIImage imageNamed:@"L"] forState:UIControlStateNormal];
    [_topleftBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth-30, 15, 30, 30)];
    [refreshBtn setImage:[UIImage imageNamed:@"F"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topMenuView addSubview:_myTitleLabel];
    [_topMenuView addSubview:_topleftBtn];
    [_topMenuView addSubview:refreshBtn];
    
    
    
}

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    _index =1;
//    if (admin) {
//        if (index == 0) {
//            [UIView animateWithDuration:0.2 animations:^{
//                keyword = @"";
//                self.myTitleLabel.text = @"我的会议";
//                self.myTitleLabel.tag = 0;
//                [SVProgressHUD showWithStatus:@"加载中..."];
//                [self loadData];
//                [self setupView];
//            }];
//            
//        }else if (index == 1){
//            [UIView animateWithDuration:0.2 animations:^{
//                keyword = @"";
//                aduitStatus = @"waitaudit";
//                self.myTitleLabel.text = @"会议审核";
//                self.myTitleLabel.tag = 1;
//                segmentedControl1.selectedSegmentIndex = 0;
//                [self setupView];
//                [SVProgressHUD showWithStatus:@"加载中..."];
//                [self loadData];
//            }];
//        }else if (index == 2){
//            [UIView animateWithDuration:0.2 animations:^{
//                self.myTitleLabel.text = @"历史会议";
//                self.myTitleLabel.tag = 2;
//                [self setupView];
//                [SVProgressHUD showWithStatus:@"加载中..."];
//                [self loadData];
//                
//            }];
//        }else if(index == 3){
//            [UIView animateWithDuration:0.2 animations:^{
//                self.myTitleLabel.tag = 3;
//                [self toCreateMeetController];
//            }];
//        }else{
//            [UIView animateWithDuration:0.2 animations:^{
//                self.myTitleLabel.text = @"我发起会议";
//                self.myTitleLabel.tag = 4;
//                [self setupView];
//                [SVProgressHUD showWithStatus:@"加载中..."];
//                [self loadData];
//                
//            }];
//        
//        }
//        
//    }else{
        if (index == 0) {
            [UIView animateWithDuration:0.2 animations:^{
                keyword = @"";
                self.myTitleLabel.text = @"我的会议";
                self.myTitleLabel.tag = 0;
                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData];
                [self setupView];
            }];
            
        }else if (index == 1){
            [UIView animateWithDuration:0.2 animations:^{
                keyword = @"";
                aduitStatus = @"waitaudit";
                self.myTitleLabel.text = @"会议审核";
                self.myTitleLabel.tag = 1;
                segmentedControl1.selectedSegmentIndex = 0;
                [self setupView];
                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData];
            }];
        }else if (index == 2){
            [UIView animateWithDuration:0.2 animations:^{
                self.myTitleLabel.text = @"历史会议";
                self.myTitleLabel.tag = 2;
                [self setupView];
                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData];
                
            }];
        }else if(index == 3){
            [UIView animateWithDuration:0.2 animations:^{
                self.myTitleLabel.tag = 3;
                [self toCreateMeetController];
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                self.myTitleLabel.text = @"我发起会议";
                self.myTitleLabel.tag = 4;
                [self setupView];
                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData];
                
            }];
        }
        
        
//    }
}


-(void)segmentAction:(UISegmentedControl *)Seg{
    
    _index =1;
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            
            type = @"1";
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
        case 1:
            
            type = @"0";
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
        case 2:
           
            type= @"9";
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
    }
}
-(void)segmentAction1:(UISegmentedControl *)Seg{
    
    _index =1;
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            aduitflag = NO;
            aduitStatus = @"waitaudit";
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
        case 1:
            aduitflag = YES;
           aduitStatus = @"pass";
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
    }
}

- (void)setupView{
    
    if (self.myTitleLabel.tag ==1) {
        typeView.hidden=YES;
        typeView1.hidden=NO;
        _theTableView.frame=CGRectMake(0, 85, UIScreenWidth, UIScreenHeight-135);
    }
    else if (self.myTitleLabel.tag ==2){
        typeView.hidden=NO;
        typeView1.hidden=YES;
        _theTableView.frame=CGRectMake(0, 85, UIScreenWidth, UIScreenHeight-135);
    }
    else{
        typeView.hidden=YES;
        typeView1.hidden=YES;
        _theTableView.frame=CGRectMake(0, 50, UIScreenWidth, UIScreenHeight-100);
    }
    
}


- (void)toCreateMeetController{
    MeetCreateViewController *vc = [[MeetCreateViewController alloc]initWithNibName:@"MeetCreateViewController" bundle:nil];
//    [self presentViewController:vc animated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
    
}

-(void)viewWillAppear:(BOOL)animated{
   
    
    if (self.myTitleLabel.tag ==3) {
        
        [self.titledTabsView swtichTab:undojion];
    }
    [self loadData];
}

-(void) loadData{
    
    if(type == nil){
        type = @"";
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_READ_LINE] forKey:@"ec_p"];
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_RETURN_COUNT] forKey:@"ec_crd"];
    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    

    
    if (self.myTitleLabel.tag == 0) {
        urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/user_wait_meeting?ec_p=%d&ec_crd=%d",serverAddress,_index,KEY_RETURN_COUNT];
    }else if(self.myTitleLabel.tag == 1){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/user_aduit_meetings?aduitStatus=%@",serverAddress,aduitStatus];
    }else if(self.myTitleLabel.tag ==2){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/public_meetings?&search_meetingUsersXXresponsionstatu_s_eq=%@",serverAddress,type];
    }else if(self.myTitleLabel.tag ==4){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/meetings/user_apply_meetings?ec_p=%d&ec_crd=%d",serverAddress,_index,KEY_RETURN_COUNT];
    }
    
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
    
    if (self.myTitleLabel.tag == 0) {
        dataArray = [rspBody objectForKey:@"meetingVOs"];
        
        
    }else if (self.myTitleLabel.tag ==1){
         dataArray = [rspBody objectForKey:@"meetingVOs"];
    }
    else if(self.myTitleLabel.tag == 2){
        dataArray=[rspBody objectForKey:@"meetingVOs"];
        
    }else if (self.myTitleLabel.tag ==3){
        
        dataArray=[rspBody objectForKey:@"list"];
        
    }
    else if (self.myTitleLabel.tag ==4){
        dataArray=[rspBody objectForKey:@"meetingVOs"];
    }
    else {
        dataArray = [rspBody objectForKey:@"list"];
        [self.theTableView reloadData];
    }
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



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
        keyword = searchBar.text;
        if(keyword == nil){
            keyword = @"";
        }
    
    [self loadData];
    
    [self.mySearchBar resignFirstResponder];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(self.myTitleLabel.tag == 2){
        return self.mySearchBar;
    }
    else{
        [self.mySearchBar removeFromSuperview];
        return  [[UIView alloc]init];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 105;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CustomCellIdentifier = @"meetlistViewCell";
    
    
    meetlistViewCell *cell = (meetlistViewCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
//    if(!cell)
//    {
//        [tableView registerNib:[UINib nibWithNibName:@"meetlistViewCell" bundle:nil] forCellReuseIdentifier:@"meetlistViewCell"];
//        cell = [tableView dequeueReusableCellWithIdentifier:@"meetlistViewCell"];
//    }
    if (cell == nil) {
        cell= (meetlistViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"meetlistViewCell" owner:self options:nil]  lastObject];
    }
    if (self.myTitleLabel.tag==1) {
        cell.usertype.text=@"申请人";
    }else {
        cell.usertype.text=@"主持人";
    }
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [dataArray objectAtIndex:row];
    cell.titile.text = [rowData objectForKey:@"name"];
    cell.startTime.text = [rowData objectForKey:@"startDay"];
    cell.endTime.text = [rowData objectForKey:@"endDay"];
    cell.chairPerson.text = [rowData objectForKey:@"emceeUser"];
    cell.meetRoom.text =[rowData objectForKey:@"rooms"];
    
    if (self.myTitleLabel.tag == 0){
        cell.chairPerson.text = [rowData objectForKey:@"emceeUser"];
        cell.notifyStatus.text =[rowData objectForKey:@"attendstatu"];
    }
    else if (self.myTitleLabel.tag == 1){
        cell.chairPerson.text = [rowData objectForKey:@"applyUser"];
        cell.notifyStatus.text =[rowData objectForKey:@"meetingstatu"];
    }
    else{
        cell.notifyStatus.text =[rowData objectForKey:@"meetingstatu"];
        
    }
    // 附件
    BOOL attachs = [[rowData objectForKey:@"hasAttachs"]boolValue];
    CGRect imageRect1 = CGRectMake(280, 17, 40, 40);
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:imageRect1];
    
    if (attachs) {
        imageView1.image = [UIImage imageNamed:@"icon_附件图标"];
    }
    [cell.contentView addSubview:imageView1];
    
    
    cell.tag = row;
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
    
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    [cell addGestureRecognizer:oneFingerTwoTaps];
    
    return  cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mySearchBar resignFirstResponder];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int index = indexPath.row;
    
    //    [self performSegueWithIdentifier:@"WorkFlowDetail" sender:[NSString stringWithFormat:@"%d",index]];
    
    
}

-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    NSMutableDictionary *rowData = [dataArray objectAtIndex:index];
    
    MeetDetailsViewController *vc =[[MeetDetailsViewController alloc]initWithNibName:@"MeetDetailsViewController" bundle:nil];
    vc.meetid =[[rowData objectForKey:@"id"]stringValue];
    vc.meetData = rowData;
    vc.tag = self.myTitleLabel.tag;
    vc.aduitflag = aduitflag;
    [self.navigationController pushViewController:vc animated:NO];
//    [self presentViewController:vc animated:NO completion:^{
//        
//    }];
}




- (void)refreshBtnClick:(id *)sender{
    [self loadData];
    
}


- (void)backBtn{
//    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}




// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
    
    return [NSDate date]; // should return date data source was last changed
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
