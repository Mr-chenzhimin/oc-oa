//
//  NoticeListViewController.m
//  OA
//
//  Created by dengfan on 13-12-9.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "NoticeListViewController.h"
#import "Utils.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "Constant.h"
#import "KOMenuView.h"
#import "FMDB.h"
@interface NoticeListViewController ()
@property(nonatomic,strong)FMDatabase *db;
@property (nonatomic,assign) NSInteger index;
@end

@implementation NoticeListViewController

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
    [self.topMenuBtn setSelected:NO];
    [self.topMenuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.mySearchBar = [[UISearchBar alloc] init];
    self.mySearchBar.placeholder = @"请输入查找内容";
    self.mySearchBar.delegate = self;
    
    [self loadbtntitle];
    
    
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"student.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    if ([db open]) {
            //4.创表
            //3.创建表
            BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
            if (result) {
                NSLog(@"创建表成功"); }
            else {
                NSLog(@"创建表失败");
            }
        
        
    }
     self.db=db;
    
   
    


    
//    UzysSMMenuItem *item0 = [[UzysSMMenuItem alloc] initWithTitle:@"重要公告" image:[UIImage imageNamed:@"a0.png"] action:^(UzysSMMenuItem *item) {
//        NSLog(@"Item: %@", item);
//        
//        [UIView animateWithDuration:0.2 animations:^{
//            
//            [self.topMenuBtn setSelected:NO];
//            
//            [self.uzysSMenu removeFromSuperview];
//            
//            self.myTitleLabel.text = @"重要公告";
//            self.myTitleLabel.tag = 0;
//            [self loadData];
//        }];
//    }];
//    
//    UzysSMMenuItem *item1 = [[UzysSMMenuItem alloc] initWithTitle:@"公告" image:[UIImage imageNamed:@"a1.png"] action:^(UzysSMMenuItem *item) {
//        NSLog(@"Item: %@", item);
//        [UIView animateWithDuration:0.2 animations:^{
//            
//            [self.topMenuBtn setSelected:NO];
//            self.myTitleLabel.text = @"公告";
//            
//            [self.uzysSMenu removeFromSuperview];
//            self.myTitleLabel.tag = 1;
//            [self loadData];
//
//        }];
//        
//        
//    }];
//    
//    UzysSMMenuItem *item2 = [[UzysSMMenuItem alloc] initWithTitle:@"会议通知" image:[UIImage imageNamed:@"a1.png"] action:^(UzysSMMenuItem *item) {
//        NSLog(@"Item: %@", item);
//        [UIView animateWithDuration:0.2 animations:^{
//            
//            [self.topMenuBtn setSelected:NO];
//            self.myTitleLabel.text = @"会议通知";
//            
//            [self.uzysSMenu removeFromSuperview];
//            self.myTitleLabel.tag = 2;
//            [self loadData];
//        }];
//        
//        
//    }];
//    UzysSMMenuItem *item3 = [[UzysSMMenuItem alloc] initWithTitle:@"活动召集" image:[UIImage imageNamed:@"a1.png"] action:^(UzysSMMenuItem *item) {
//        NSLog(@"Item: %@", item);
//        [UIView animateWithDuration:0.2 animations:^{
//            
//            [self.topMenuBtn setSelected:NO];
//            self.myTitleLabel.text = @"活动召集";
//            
//            [self.uzysSMenu removeFromSuperview];
//            self.myTitleLabel.tag = 3;
//            [self loadData];
//        }];
//        
//        
//    }];
//    UzysSMMenuItem *item4 = [[UzysSMMenuItem alloc] initWithTitle:@"内部招聘" image:[UIImage imageNamed:@"a1.png"] action:^(UzysSMMenuItem *item) {
//        NSLog(@"Item: %@", item);
//        [UIView animateWithDuration:0.2 animations:^{
//            
//            [self.topMenuBtn setSelected:NO];
//            self.myTitleLabel.text = @"内部招聘";
//            
//            [self.uzysSMenu removeFromSuperview];
//            self.myTitleLabel.tag = 4;
//            [self loadData];
//        }];
//        
//        
//    }];
//    
//    item0.tag = 0;
//    item1.tag = 1;
//    item2.tag = 2;
//    item3.tag = 3;
//    item4.tag = 4;
//    //Items must contain ImageView(icon).
//    self.uzysSMenu = [[UzysSlideMenu alloc] initWithItems:@[item0,item1,item2,item3,item4]];
//    self.uzysSMenu.frame = CGRectMake(0, 44, 320, self.uzysSMenu.frame.size.height);
//    
//    self.myTitleLabel.text = @"重要通知";
//    
//    [self loadData];
    _index =KEY_READ_LINE;
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _index -=KEY_RETURN_COUNT;
        if (_index <=0) {
            _index=0;
        }
        [self loadData];
    }];
    self.dataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if(_listData.count==KEY_RETURN_COUNT){
            _index +=KEY_RETURN_COUNT;
        }
        [self loadData];
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

-(void)viewDidAppear:(BOOL)animated{
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createBtn:(NSMutableArray *)btnlist{
    NSMutableArray * btnitemlist = [[NSMutableArray alloc] init];
    
    int num = 0;
    for(int i=0;i<btnlist.count;i++){
        NSDictionary * data = [btnlist objectAtIndex:i];
        NSString *cataName = [data objectForKey:@"name"];
        if([cataName isEqualToString:@"内部招聘"]){
            continue;
        }
        num++;
        UzysSMMenuItem *item0 = [[UzysSMMenuItem alloc] initWithTitle:[data objectForKey:@"name"] image:[UIImage imageNamed:@"a0.png"] action:^(UzysSMMenuItem *item) {
            NSLog(@"Item: %@", item);
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.dataTableView setContentOffset:CGPointMake(0, 0) animated:NO];  //每次都置顶
                _index =KEY_READ_LINE;
                [self.topMenuBtn setSelected:NO];
                
                [self.uzysSMenu removeFromSuperview];
                self.selectTitleLabel = [data objectForKey:@"name"];
                self.myTitleLabel.text = [data objectForKey:@"name"];
                self.myTitleLabel.tag = i;
                [SVProgressHUD showWithStatus:@"加载中..."];
                [self loadData];
            }];
        }];
        [btnitemlist addObject:item0];
        
        //        self.selectTitleLabel = [data objectForKey:@"name"];
        //        self.myTitleLabel.text = [data objectForKey:@"name"];
        //        self.myTitleLabel.tag = i;
        //        [SVProgressHUD showWithStatus:@"加载中..."];
        //[self loadData];
        
    }
    
    self.uzysSMenu = [[UzysSlideMenu alloc] initWithItems:btnitemlist];
    int yHeight = self.view.frame.size.height - 50;
    self.uzysSMenu.frame = CGRectMake(0, yHeight-num*45, 320, self.uzysSMenu.frame.size.height);
    
    self.myTitleLabel.text = [[btnlist objectAtIndex:0] objectForKey:@"name"];
    self.selectTitleLabel = [[btnlist objectAtIndex:0] objectForKey:@"name"];
    [self loadData];
    
}



- (IBAction) menuBtnClick:(id)sender{
    [self.topMenuBtn setSelected:!self.topMenuBtn.selected];
    
    if(self.topMenuBtn.selected){
        self.uzysSMenu.userInteractionEnabled = YES;
        [self.view addSubview:self.uzysSMenu];
        
    }else{
        self.uzysSMenu.userInteractionEnabled = NO;
//        [self.uzysSMenu removeFromSuperview];  //解决多次点击失效问题
    }
    
    [self.uzysSMenu toggleMenu];
    
    [self.view bringSubviewToFront:self.uzysSMenu];
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    keyword = searchBar.text;
    if(keyword == nil){
        keyword = @"";
    }
    [self loadData];
    
    [self.mySearchBar resignFirstResponder];
    
}

#pragma mark - Table view data source

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.mySearchBar;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.listData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index = indexPath.row;
    float height = 70;
    
    return height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NoticeListCell";
    NoticeListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    int index = indexPath.row;
    
    NSDictionary *data = [self.listData objectAtIndex:index];
    
    cell.subjectLabel.text = [data objectForKey:@"title"];
    
    cell.usernameLabel.text = [data objectForKey:@"publisher"];
    cell.timeLabel.text = [data objectForKey:@"startDate"];
    cell.itemback.highlightedImage=[UIImage imageNamed:@"itembgyes.png"];
    int attachCount = [[data objectForKey:@"read"] integerValue];
    int read = [[data objectForKey:@"attachCount"] integerValue];
    if (attachCount == 0) {
        cell.attachmentImage.hidden = YES;
    }else{
        cell.attachmentImage.hidden = NO;
    }
//    if (read==1) {
//        <#statements#>
//    }
    cell.tag = index;
    
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
    
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    [cell addGestureRecognizer:oneFingerTwoTaps];
    
    return cell;
}

-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    [self performSegueWithIdentifier:@"NoticeDetail" sender:[NSString stringWithFormat:@"%d",index]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int index = indexPath.row;
    
    
    
    [self performSegueWithIdentifier:@"NoticeDetail" sender:[NSString stringWithFormat:@"%d",index]];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"NoticeDetail"])
	{
        
        // Get destination view
        id vc = [segue destinationViewController];
        
        // Get button tag
        NSInteger tagIndex = [(NSString *) sender intValue];
        
        NoticeDetailViewController * noticeDetail = (NoticeDetailViewController *) vc;
        
        noticeDetail.noticeData =  [self.listData objectAtIndex:tagIndex];
        
        // Set the selected button in the new view
        // [vc setSelectedButton:tagIndex];
    }
}
-(void)loadbtntitle{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/bulletins/getBullNewsCatalog",serverAddress];
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
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];

}


- (void)GetResult1:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    BtnTitleList = [result objectForKey:@"rspBody"];
    
    [self createBtn:BtnTitleList];
    [SVProgressHUD dismissWithSuccess:@""];

    
}

- (void) GetErr1:(ASIHTTPRequest *)request{
    
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
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString *title=self.selectTitleLabel;
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/bulletins/getBulletinsList?s=%d&c=%d&title=%@",serverAddress,_index,KEY_RETURN_COUNT,title];
    
    //用于显示详细信息里面的jsp的参数
    [Utils cache:[NSString stringWithFormat:@"%d",self.myTitleLabel.tag] forKey:@"noticeKind"];
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
}

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    
    self.listData = [rspBody objectForKey:@"bulletinsVOs"];
    
    //NSString * titleLable = [self.myTitleLabel.text substringToIndex:4];
    self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@(%d)",self.selectTitleLabel,[self.listData count]];

    
    [self.dataTableView reloadData];
    [self.dataTableView.mj_header endRefreshing];
    [self.dataTableView.mj_footer endRefreshing];
    [SVProgressHUD dismissWithSuccess:@""];
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"加载失败"];
}

- (IBAction) refreshBtnClick:(id)sender{
    [SVProgressHUD showWithStatus:@"刷新..."];
    [self loadData];
    int mark_student = 0;
    //插入数据
    NSString *name = [NSString stringWithFormat:@"王子涵%@",@(mark_student)];
    int age = mark_student;
    NSString *sex = @"男";
    mark_student ++;
    BOOL result = [_db executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
    if (result) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
   
}

- (IBAction)backBtn:(id)sender {
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

@end
