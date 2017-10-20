//
//  workLogViewController.m
//  OA
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import "workLogViewController.h"
#import "Utils.h"
#import "Constant.h"
#import "SBJsonParser.h"
#import "JSON.h"
#import "WorkLogDetailViewController.h"
#import "WorkLogAddViewController.h"
#import "JKAlertDialog.h"
#import "PopoverSelector.h"


#define seachtop   @"选择时间范围"
@interface workLogViewController (){

    UIView *typeView;
    int type;
  
    UISegmentedControl *segmentedControl;
    
    NSString *startime;
    NSString *endtime;
    
    UIButton *lable;//搜索框
    
    RKTabItem * presonItem;
    
    NSString *dateString;
}
@property (nonatomic,assign) NSInteger index;
@end

@implementation workLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showTimeRangeSelector:(TimeRangeType)rangeType{
    PopoverSelector *selector = [[PopoverSelector alloc] initSelectorWithFrameRangeType:CGRectMake(0, UIScreenHeight - 216, UIScreenWidth, 216) RangeType:rangeType];
    [selector setTitle:seachtop];
    [selector setTag:10000 + 1];
    [selector setSelectDelegate:self];
    
    [selector show];
}

- (void)setuptop{
    
    self.topMenuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 50)];
    self.topMenuView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"head背景.png"]];
    
    
    [self.view addSubview:self.topMenuView];
    
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

- (void)viewDidLoad
{
    
    [self setuptop];
    
    _theTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, UIScreenWidth, UIScreenHeight-100)];
    _theTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _theTableView.dataSource=self;
    _theTableView.delegate=self;
    _theTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_theTableView];
    
    
    UIImage *presonsele =[Constant scaleToSize:[UIImage imageNamed:@"a11"] size:CGSizeMake(77, 47)];
    UIImage *preson =[Constant scaleToSize:[UIImage imageNamed:@"a11 - 副本"] size:CGSizeMake(77, 47)];
    presonItem =[RKTabItem createUsualItemWithImageEnabled:presonsele imageDisabled:preson];
    presonItem.titleFontColor=[UIColor blackColor];
    presonItem.titleFont=[UIFont systemFontOfSize:20];
//    presonItem.titleString = @"个人";
    
    UIImage *presonssele =[Constant scaleToSize:[UIImage imageNamed:@"a12"] size:CGSizeMake(77, 47)];
    UIImage *presons =[Constant scaleToSize:[UIImage imageNamed:@"a12 - 副本"] size:CGSizeMake(77, 47)];
    RKTabItem * presonsItem =[RKTabItem createUsualItemWithImageEnabled:presons imageDisabled:presonssele];
    presonsItem.titleFontColor=[UIColor blackColor];
    presonsItem.titleFont=[UIFont systemFontOfSize:20];
//    presonsItem.titleString = @"汇总";
    
    UIImage *writesele =[Constant scaleToSize:[UIImage imageNamed:@"a13"] size:CGSizeMake(77, 47)];
    UIImage *write =[Constant scaleToSize:[UIImage imageNamed:@"a13 - 副本"] size:CGSizeMake(77, 47)];
    RKTabItem * writeItem =[RKTabItem createUsualItemWithImageEnabled:write imageDisabled:writesele];
    writeItem.titleFontColor=[UIColor blackColor];
    writeItem.titleFont=[UIFont systemFontOfSize:20];
//    writeItem.titleString = @"录入";
    
    UIImage *addsele =[Constant scaleToSize:[UIImage imageNamed:@"foot_w4"] size:CGSizeMake(77, 47)];
    UIImage *add =[Constant scaleToSize:[UIImage imageNamed:@"foot_w4"] size:CGSizeMake(77, 47)];
    RKTabItem * addItem =[RKTabItem createUsualItemWithImageEnabled:add imageDisabled:addsele];
    addItem.titleFontColor=[UIColor blackColor];
    addItem.titleFont=[UIFont systemFontOfSize:20];
//    addItem.titleString = @"补记";

    _titledTabsView =[[RKTabView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-55, UIScreenWidth, 55)];
    _titledTabsView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_titledTabsView];
    self.titledTabsView.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    self.titledTabsView.delegate = self;
    [self.titledTabsView swtichTab:presonItem];
    self.titledTabsView.tabItems = @[presonItem,presonsItem,writeItem,addItem];
    
    self.mySearchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 25)];
    self.mySearchBar.delegate=self;
    self.mySearchBar.searchBarStyle=UISearchBarStyleMinimal;
    self.mySearchBar.placeholder=@"请选择开始时间和结束时间";
    _theTableView.tableHeaderView=self.mySearchBar;
    
    
     typeView= [[UIView alloc]initWithFrame:CGRectMake(0, 50, UIScreenWidth, 35)];
    typeView.backgroundColor=[UIColor whiteColor];
    typeView.hidden=YES;
    [self.view addSubview:typeView];
    
    NSArray *arry = [NSArray arrayWithObjects:@"我关注的人员",@"共享日志",@"全部日志" ,nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:arry];
    segmentedControl.frame = CGRectMake(25, 3, 270, 30);
    segmentedControl.selectedSegmentIndex = 0;
    type=4;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [typeView addSubview:segmentedControl];
    
    
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




-(void)segmentAction:(UISegmentedControl *)Seg{
    _index =1;
    [_mySearchBar resignFirstResponder];
    [self.theTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            keyword = @"";
            type = 4;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
        case 1:
            keyword = @"";
            type = 2;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
        case 2:
            keyword = @"";
            type= 0;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
    }
}


- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    _index =1;
    [self.theTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [_mySearchBar resignFirstResponder];
    if (index == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            keyword = @"";
            self.myTitleLabel.text = @"个人日志";
            self.myTitleLabel.tag = 0;
            typeView.hidden = YES;
            lable.titleLabel.text=@"";
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            [self setupView];
        }];
        
    }
    else if (index == 1){
        [UIView animateWithDuration:0.2 animations:^{
            keyword = @"";
            self.myTitleLabel.text = @"日志汇总";
            self.myTitleLabel.tag = 1;
            typeView.hidden=NO;
            [self setupView];
            lable.titleLabel.text=@"";
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
        }];
    }
    else if (index == 2){
        [UIView animateWithDuration:0.2 animations:^{
            self.myTitleLabel.tag = 2;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
    
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.myTitleLabel.tag = 3;
            UIDatePicker *datePicker = [[UIDatePicker alloc] init];
            datePicker.datePickerMode = UIDatePickerModeDate;
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n" message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
            [alert.view addSubview:datePicker];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                //实例化一个NSDateFormatter对象
                [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
                dateString = [dateFormat stringFromDate:datePicker.date];
                //求出当天的时间字符串
                NSLog(@"%@",dateString);
                
                
                NSDate* maxDate = [NSDate date];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *dateA = [dateFormatter dateFromString:dateString];
                
                NSComparisonResult result = [dateA compare:maxDate];
                
                if (result == NSOrderedDescending){
                    [SVProgressHUD showErrorWithStatus:@"补记时间不能大于当前时间"];
                    [self presentViewController:alert animated:YES completion:^{ }];
                    return;
                }

                [self loadData];

            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.titledTabsView swtichTab:presonItem];
                }];
            
            
            [alert addAction:cancel];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:^{ }];

        }];
    }
}


-(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}

-(void)createWorkLog{
    
     WorkLogAddViewController *vc = [[WorkLogAddViewController alloc]initWithNibName:nil bundle:nil];
    vc.status = 3;
    vc.logday =dateString;
    [self presentViewController:vc animated:NO completion:^{
        [self.titledTabsView swtichTab:presonItem];
    }];
}

- (void)setupView{

    if (self.myTitleLabel.tag==1) {
        _theTableView.frame=CGRectMake(0, 85, UIScreenWidth, UIScreenHeight-135);
    }else{
        _theTableView.frame=CGRectMake(0, 50, UIScreenWidth, UIScreenHeight-100);
    }
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    [self loadData];
}

-(void) loadData{
    //    keyword = self.mySearchBar.text;
    if(keyword == nil){
        keyword = @"";
    }
    if (startime ==nil) {
        startime=@"";
    }if (endtime ==nil) {
        endtime=@"";
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_READ_LINE] forKey:@"ec_p"];
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_RETURN_COUNT] forKey:@"ec_crd"];
    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    int page = 1;
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    
    if (self.myTitleLabel.tag == 0) {
        urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/user_worklog?ec_p=%d&ec_crd=%d&key=%@&logDay_s_ge=%@&logDay_s_le=%@",serverAddress,_index,KEY_RETURN_COUNT,keyword,startime,endtime];
    }else if(self.myTitleLabel.tag == 1){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/public_worklog?t=%d&ec_p=%d&ec_crd=%d&key=%@&logDay_s_ge=%@&logDay_s_le=%@",serverAddress,type,_index,KEY_RETURN_COUNT,keyword,startime,endtime];
    }else if(self.myTitleLabel.tag ==2){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/user_worklog?ec_p=%d&ec_crd=%d&logDay_s_ge=%@&logDay_s_le=%@",serverAddress,_index,KEY_RETURN_COUNT,date,date];
    }else{
        urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/user_worklog?ec_p=%d&ec_crd=%d&logDay_s_ge=%@&logDay_s_le=%@",serverAddress,_index,KEY_RETURN_COUNT,dateString,dateString];
        
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



-(void) popToRootView:(NSNotification * )notiData{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) refreshBtnClick:(id)sender{
    [SVProgressHUD showWithStatus:@"刷新..."];
    [self loadData];
    
}
//

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    if (self.myTitleLabel.tag == 0) {
        dataArray = [rspBody objectForKey:@"list"];
            [self.theTableView reloadData];
        
    }else if(self.myTitleLabel.tag == 2){
        dataArray=[rspBody objectForKey:@"list"];
//        datacaretoryName=[self getfileCaretoryname:@""];
        if (dataArray.count) {
            WorkLogDetailViewController *vc = [[WorkLogDetailViewController alloc]initWithNibName:nil bundle:nil];;
            vc.worklogTag =self.myTitleLabel.tag;
            vc.worklogData=[dataArray objectAtIndex:0];
            vc.DetailId = [[vc.worklogData objectForKey:@"id"]intValue];
            [self presentViewController:vc animated:NO completion:^{
                [self.titledTabsView swtichTab:presonItem];
            }];
        }else{
            dateString =nil;
            [self createWorkLog];
        }


    }else if (self.myTitleLabel.tag ==3){
    
        dataArray=[rspBody objectForKey:@"list"];
    
        if (dataArray.count) {
            WorkLogDetailViewController *vc = [[WorkLogDetailViewController alloc]initWithNibName:nil bundle:nil];;
            vc.worklogTag =self.myTitleLabel.tag;
            vc.worklogData=[dataArray objectAtIndex:0];
            vc.DetailId = [[vc.worklogData objectForKey:@"id"]intValue];
            [self presentViewController:vc animated:NO completion:^{
                [self.titledTabsView swtichTab:presonItem];
            }];
        }else{
            
            [self createWorkLog];
        }
        

    }
    else {
        dataArray = [rspBody objectForKey:@"list"];
            [self.theTableView reloadData];
    }
    
    startime=@"";
    endtime=@"";
//    [self.theTableView reloadData];
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


#pragma mark - 列表

-(void) hiddenSearchBar{
    [self.mySearchBar resignFirstResponder];
    
}

- (void)seach{
    
    [self showTimeRangeSelector:YYYYMMDD];
    [lable setTitle:@"" forState:UIControlStateNormal];
}

- (void)itemSelected:(PopoverSelector*)selector SelectedItem:(NSString*)item{
    NSLog(@"%@ selected %@", [selector getTitle], item);
//    lable.titleLabel.text = item;

    
    if ([item isEqualToString:seachtop]) {
        item =@"";
        return;
    }else{
        [lable setTitle:item forState:UIControlStateNormal];
        startime = [item substringToIndex:10];
        endtime = [item substringFromIndex:11];
    }

    
    [self loadData];
    
    //    [lblRange setText:item];
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    keyword = searchBar.text;
//    if(keyword == nil){
//        keyword = @"";
//    }
    
    [self loadData];
    
    [self.mySearchBar resignFirstResponder];
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [_mySearchBar resignFirstResponder];
    [self showTimeRangeSelector:YYYYMMDD];
    return NO;
    
}

//-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    if(self.myTitleLabel.tag == 1){
//        return self.mySearchBar;
//    }
//    else{
//        [self.mySearchBar removeFromSuperview];
//        return  [[UIView alloc]init];
//    }
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index=indexPath.row;
    if(self.myTitleLabel.tag == 2){

    }
    else{
        
        static NSString *newfilecell = @"newfilecaretorycell";
        UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:newfilecell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newfilecell];
            NSDictionary * data = [dataArray objectAtIndex:index];
            // 标题
            CGRect titleRect = CGRectMake(14, 10, 300, 30);
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleRect];
            titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
            titleLabel.textColor = [UIColor blackColor];
            NSString * title=  [data objectForKey:@"title"];
            titleLabel.text=title;
            [cell.contentView addSubview:titleLabel];
            //时间
            CGRect timeRect = CGRectMake(14, 42, 100, 30);
            UILabel *timeLabel = [[UILabel alloc]initWithFrame:timeRect];
            timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
            timeLabel.textColor = [UIColor blackColor];
            NSString * time=  [data objectForKey:@"logDay"];
            timeLabel.text=time;
            [cell.contentView addSubview:timeLabel];
            
            //状态
            CGRect imageRect = CGRectMake(260, 20, 50, 20);
            UILabel *statusLabel = [[UILabel alloc]initWithFrame:imageRect];
            statusLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
//            statusLabel.textColor = [UIColor redColor];
            int status=  [[data objectForKey:@"status"]intValue];
            if (status ==1) {
                statusLabel.text = @"发布";
            }else{
                statusLabel.text = @"暂存";
            }
            [cell.contentView addSubview:statusLabel];
            
            //用户
            UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 52, 60, 10)];
            userLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
            userLabel.textColor = [UIColor blackColor];
            userLabel.textAlignment = NSTextAlignmentLeft;
            NSString *user= [data objectForKey:@"user"];
            userLabel.text=user;
            [cell.contentView addSubview:userLabel];
            
            // 附件
            BOOL attachs = [[data objectForKey:@"hasAttachs"]boolValue];
            CGRect imageRect1 = CGRectMake(283, 14, 40, 40);
            UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:imageRect1];
            
            if (attachs) {
                imageView1.image = [UIImage imageNamed:@"icon_附件图标"];
            }
            [cell.contentView addSubview:imageView1];
            
//            UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
//            lbl.frame = CGRectMake(cell.frame.origin.x , 69, cell.frame.size.width, 1);
//            lbl.backgroundColor =  [UIColor lightGrayColor];
//            [cell.contentView addSubview:lbl];
            
        }
        cell.tag = index;
        UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
        
        [oneFingerTwoTaps setNumberOfTapsRequired:1];
        [oneFingerTwoTaps setNumberOfTouchesRequired:1];
        
        [cell addGestureRecognizer:oneFingerTwoTaps];
        return cell;
    }

       return  nil;
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
    WorkLogDetailViewController *vc = [[WorkLogDetailViewController alloc]initWithNibName:nil bundle:nil];;
    vc.worklogTag =self.myTitleLabel.tag;
    vc.worklogData=[dataArray objectAtIndex:index];
    vc.DetailId = [[vc.worklogData objectForKey:@"id"]intValue];
    [self presentViewController:vc animated:NO completion:nil];
   

}


-(NSMutableArray*)getfileCaretoryname:(NSString *)caretory{
    
    NSMutableArray * caretoryArray = [[NSMutableArray alloc] init];
    if([caretory isEqualToString:@""]){
        [caretoryArray addObject:[dataArray objectAtIndex:0]];
        
        for(int k=1;k<[dataArray count];k++){
            NSString *isdouble=@"false";
            NSDictionary * data = [dataArray objectAtIndex:k];
            NSString * caretoryname=[data objectForKey:@"catetoryName"];
            
            for(int j=0;j<[caretoryArray count];j++){
                NSDictionary * data1 = [caretoryArray objectAtIndex:j];
                NSString * caretoryname1=[data1 objectForKey:@"catetoryName"];
                
                if([caretoryname isEqualToString:caretoryname1]){
                    isdouble=@"true";
                    break;
                }
            }
            if([isdouble isEqualToString:@"false"]){
                [caretoryArray addObject:[dataArray objectAtIndex:k]];
            }
        }
    }else{
        
        for(int k=0;k<[dataArray count];k++){
            NSDictionary * data = [dataArray objectAtIndex:k];
            NSString * caretoryname=[data objectForKey:@"catetoryName"];
            if([caretory isEqualToString:caretoryname]){
                [caretoryArray addObject:[dataArray objectAtIndex:k]];
            }
        }
    }
    return caretoryArray;
}


- (void)backBtn{
//    [self dismissViewControllerAnimated:NO completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
