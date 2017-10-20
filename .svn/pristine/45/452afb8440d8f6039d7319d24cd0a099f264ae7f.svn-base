//
//  WorkLogDetailViewController.m
//  OA
//
//  Created by admin on 16/7/4.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import "WorkLogDetailViewController.h"
#import "Utils.h"
#import "SBJsonParser.h"
#import "Constant.h"
#import "JSON.h"
#import "WorkLogAddViewController.h"
@interface WorkLogDetailViewController (){
    
    UITextView *title;
    NSString *WorkLogId;
    NSString *name;
    int Status;
    NSString * keyword;
    NSMutableArray * dataArray;
    NSMutableArray * datacaretoryName;
    NSMutableArray * shareuerArry;
    EGORefreshTableHeaderView * _refreshHeaderView;
}

@end

@implementation WorkLogDetailViewController

- (void)setuptop{
    
    self.topMenuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 50)];
    self.topMenuView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"head背景.png"]];
    
    
    [self.view addSubview:self.topMenuView];
    
    _myTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(125, 15, 100, 30)];
    _myTitleLabel.text=@"工作日志";
    
    
    _topleftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, 30, 30)];
    [_topleftBtn setBackgroundImage:[UIImage imageNamed:@"L"] forState:UIControlStateNormal];
    [_topleftBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    

    
    [_topMenuView addSubview:_myTitleLabel];
    [_topMenuView addSubview:_topleftBtn];
    
    
}

- (void)viewDidLoad
{
    self.myTitleLabel.text = @"日志详情";
    [self setuptop];
    

    _theTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, UIScreenWidth, UIScreenHeight-50)];
    self.view.backgroundColor =[UIColor whiteColor];
    _theTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _theTableView.tableFooterView = [[UIView alloc]init];
    _theTableView.dataSource=self;
    _theTableView.delegate=self;
    [self.view addSubview:_theTableView];
    

    UIImage *deletedsele =[Constant scaleToSize:[UIImage imageNamed:@"foot_mc_3_2"] size:CGSizeMake(160, 47)];
    UIImage *deleted =[Constant scaleToSize:[UIImage imageNamed:@"foot_mc_3_2"] size:CGSizeMake(160, 47)];
    RKTabItem * deletedItem =[RKTabItem createUsualItemWithImageEnabled:deletedsele imageDisabled:deleted];
    deletedItem.titleFontColor=[UIColor blackColor];
    deletedItem.titleFont=[UIFont systemFontOfSize:20];
//    deletedItem.titleString = @"删除";
    
    UIImage *addsele =[Constant scaleToSize:[UIImage imageNamed:@"a9"] size:CGSizeMake(160, 47)];
    UIImage *add =[Constant scaleToSize:[UIImage imageNamed:@"a9"] size:CGSizeMake(160, 47)];
    RKTabItem * addItem =[RKTabItem createUsualItemWithImageEnabled:add imageDisabled:addsele];
    addItem.titleFontColor=[UIColor blackColor];
    addItem.titleFont=[UIFont systemFontOfSize:20];
//    addItem.titleString = @"增加内容";
    
    
//    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 40, 30)];
//    lbl.backgroundColor=[UIColor whiteColor];
//    lbl.text =@"标题:";
//    [self.view addSubview:lbl];
    NSString *user = [_worklogData objectForKey:@"user"];
    NSString *titlesStr = [_worklogData objectForKey:@"title"];
    title = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 35)];
    title.textAlignment = NSTextAlignmentCenter;
    title.font=[UIFont systemFontOfSize:16];
//    title.backgroundColor=[UIColor lightGrayColor];
    
    title.text = titlesStr;
//    [self.view addSubview:title];
    self.theTableView.tableHeaderView = title;
    
    
    _titledTabsView =[[RKTabView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-50, UIScreenWidth, 50)];
    _titledTabsView.backgroundColor=[UIColor whiteColor];
    
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    self.titledTabsView.delegate = self;
    NSString *currentUser = [Utils getCacheForKey:@"userName"];
    if ([currentUser isEqualToString:@"admin"]) {
        currentUser = @"超级用户";
    }
    if ([user isEqualToString:currentUser]) {
        [self.view addSubview:_titledTabsView];
    }
//    [self.view addSubview:_titledTabsView];
    self.titledTabsView.tabItems = @[addItem,deletedItem];
    
    //     _mySearchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 20)];
    //    _theTableView.tableHeaderView=_mySearchBar;
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [self loadData];
}

- (void)backBtn{
    [self dismissViewControllerAnimated:NO completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    if (index == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.myTitleLabel.tag = 0;

            [self addLog];
        }];
        
    }else if (index == 1){
        [UIView animateWithDuration:0.2 animations:^{
            
            [self deleteLog];
        }];
    }
    
}

// 删除
- (void)deleteLog{
    keyword = self.mySearchBar.text;
    if(keyword == nil){
        keyword = @"";
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_READ_LINE] forKey:@"ec_p"];
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_RETURN_COUNT] forKey:@"ec_crd"];
    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    NSString *LogID = [self.worklogData objectForKey:@"id"];
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/user_worklog_delete?ids=%@",serverAddress,LogID];
    
//    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:LogID forKey:@"ids"];
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    
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
    
    //    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
 
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) GetErr2:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];
}

//增加
- (void)addLog{
    WorkLogAddViewController *addVc = [[WorkLogAddViewController alloc]initWithNibName:@"WorkLogAddViewController" bundle:nil];
    
    addVc.status = Status;
    addVc.workLogId = WorkLogId;
    addVc.worklogData = _worklogData;
    addVc.worklogTag =self.myTitleLabel.tag;
    [self presentViewController:addVc animated:NO completion:nil];

}




- (void)setupView{
    
    if (self.myTitleLabel.tag==1) {
        _theTableView.frame=CGRectMake(0, 80, UIScreenWidth, UIScreenHeight-80);
    }else{
        _theTableView.frame=CGRectMake(0, 50, UIScreenWidth, UIScreenHeight-50);
    }
    
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
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
//    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    shareuerArry = [rspBody objectForKey:@"worklogShareUsers"];
    
    name = [rspBody objectForKey:@"user"];
    NSString *user = [Utils getCacheForKey:@"userName"];
    if ([name isEqualToString:user]||name ==nil||[user isEqualToString:@"admin"]) {
        _titledTabsView.hidden = NO;
    }else{
        _titledTabsView.hidden = YES;
    }
    
    WorkLogId = [rspBody objectForKey:@"id"];
    
    Status = [[rspBody objectForKey:@"status"]intValue];
    
    dataArray = [rspBody objectForKey:@"worklogMxes"];
    
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


-(void) loadData{
    keyword = self.mySearchBar.text;
    if(keyword == nil){
        keyword = @"";
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_READ_LINE] forKey:@"ec_p"];
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_RETURN_COUNT] forKey:@"ec_crd"];
    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/worklog/user_worklog_detail?id=%d",serverAddress,_DetailId];
    
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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


#pragma mark - 列表

-(void) hiddenSearchBar{
    [self.mySearchBar resignFirstResponder];
    
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    keyword = searchBar.text;
    if(keyword == nil){
        keyword = @"";
    }
    
    [self loadData];
    
    [self.mySearchBar resignFirstResponder];
    
}



-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(self.myTitleLabel.tag == 1){
        return self.mySearchBar;
    }
    else{
        [self.mySearchBar removeFromSuperview];
        return  [[UIView alloc]init];
    }
    
}

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
    
    return 75;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        int index=indexPath.row;
        static NSString *newfilecell = @"newfilecaretorycell";
        UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:newfilecell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newfilecell];
            NSDictionary * data = [dataArray objectAtIndex:index];
            
//            int ids = [data objectForKey:@"id"];  // id
            NSString *finish = [[data objectForKey:@"finish"]stringValue]; //进度
            int  status = [[data objectForKey:@"share"]intValue];  // 状态
            NSString *content = [data objectForKey:@"content"];  // 内容
            NSString *workHour = [[data objectForKey:@"workHour"]stringValue];  // 工时
            NSString *assistUser = [data objectForKey:@"assistUser"];  //配合人员
            
            
            // 内容
            CGRect titleRect = CGRectMake(14, 10, 250, 30);
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleRect];
            titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.text=[NSString stringWithFormat:@"工作内容：%@",content];
            [cell.contentView addSubview:titleLabel];
            //工时
            CGRect timeRect = CGRectMake(14, 40, 100, 15);
            UILabel *timeLabel = [[UILabel alloc]initWithFrame:timeRect];
            timeLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
            timeLabel.textColor = [UIColor blackColor];
            timeLabel.text=[NSString stringWithFormat:@"工时：%@",workHour];;
            [cell.contentView addSubview:timeLabel];
            //配合人员
            UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 60, 100, 15)];
            userLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
            userLabel.textColor = [UIColor blackColor];
            userLabel.text=[NSString stringWithFormat:@"配合人员：%@",assistUser];
            [cell.contentView addSubview:userLabel];
            //进度
            CGRect finishRect = CGRectMake(260, 45, 50, 20);
            UILabel *finishLabel = [[UILabel alloc]initWithFrame:finishRect];
            finishLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
            finishLabel.textColor = [UIColor blackColor];
            finishLabel.text=[NSString stringWithFormat:@"进度：%@",finish];
            [cell.contentView addSubview:finishLabel];

            //状态
            CGRect imageRect = CGRectMake(260, 20, 50, 20);
            UILabel *statusLabel = [[UILabel alloc]initWithFrame:imageRect];
            statusLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
//            statusLabel.textColor = [UIColor redColor];
            if (status ==1) {
                statusLabel.text= @"公开";
            }else if (status ==2){
                statusLabel.text= @"共享";
            }else{
                statusLabel.text= @"个人";
            }            
            [cell.contentView addSubview:statusLabel];
        
        
            
//                UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
//                lbl.frame = CGRectMake(cell.frame.origin.x , cell.frame.size.height+25, cell.frame.size.width, 1);
//                lbl.backgroundColor =  [UIColor lightGrayColor];
//                [cell.contentView addSubview:lbl];
//                [lbl release];
        }
        cell.tag = index;
        UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
        
        [oneFingerTwoTaps setNumberOfTapsRequired:1];
        [oneFingerTwoTaps setNumberOfTouchesRequired:1];
        
        [cell addGestureRecognizer:oneFingerTwoTaps];
        return cell;
  
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
    WorkLogAddViewController *vc =[[WorkLogAddViewController alloc]init];
    vc.status = Status;
    vc.name = name;
    vc.worklogTag =1;
    vc.workLogId = WorkLogId;
    vc.titleStr = title.text;
    vc.shareUserArry = shareuerArry;
    vc.worklogData=[dataArray objectAtIndex:index];
    vc.contentId = [[vc.worklogData objectForKey:@"id"]intValue];
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

@end
