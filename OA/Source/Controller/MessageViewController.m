//
//  MessageViewController.m
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "MessageViewController.h"
#import "Utils.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "CreateMessageViewController.h"
#import "Constant.h"
@interface MessageViewController ()
@property (nonatomic,assign) NSInteger index;
@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTitleLabel.tag = 0;
    self.mySearchBar = [[UISearchBar alloc] init];
    self.mySearchBar.placeholder = @"请输入查找内容";
    self.mySearchBar.delegate = self;
    
    UITapGestureRecognizer *oneFingerTwoTaps =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSearchBar)] autorelease];
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    [self.dataTableView addGestureRecognizer:oneFingerTwoTaps];
      
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    [self.backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIImage *img1 = [Constant scaleToSize:[UIImage imageNamed:@"inc7_1"] size:CGSizeMake(140, 60)];
    UIImage *img_1 = [Constant scaleToSize:[UIImage imageNamed:@"inc7_2"] size:CGSizeMake(140, 60)];
    RKTabItem * communItem = [RKTabItem createUsualItemWithImageEnabled:img1 imageDisabled:img_1];
    communItem.titleString = @"";
    
    UIImage *img2 = [Constant scaleToSize:[UIImage imageNamed:@"inc8_1"] size:CGSizeMake(140, 60)];
    UIImage *img2_1 = [Constant scaleToSize:[UIImage imageNamed:@"inc8_2"] size:CGSizeMake(140, 60)];
    RKTabItem * notifyItem = [RKTabItem createUsualItemWithImageEnabled:img2 imageDisabled:img2_1];
    notifyItem.titleString = @"";
    
    self.titledTabsView.delegate = self;
    self.titledTabsView.tabItems = @[communItem, notifyItem];
    
    
    self.titledTabsView.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    
    [self tabView:self.titledTabsView tabBecameEnabledAtIndex:0 tab:communItem];
    [ self.titledTabsView swtichTab:communItem];

    
//    UzysSMMenuItem *item0 = [[UzysSMMenuItem alloc] initWithTitle:@"沟通消息" image:[UIImage imageNamed:@"a0.png"] action:^(UzysSMMenuItem *item) {
//        NSLog(@"Item: %@", item);
//        
//        
//        [UIView animateWithDuration:0.2 animations:^{
//            keyword = @"";
//            
//            [self.topMenuBtn setSelected:NO];
//
//            [self.uzysSMenu removeFromSuperview];
//            
//            self.myTitleLabel.text = @"沟通消息";
//            self.myTitleLabel.tag = 0;
//            [SVProgressHUD showWithStatus:@"加载中..."];
//            [self loadData];
//            
//        }];
//    }];
//    
//    UzysSMMenuItem *item1 = [[UzysSMMenuItem alloc] initWithTitle:@"通知消息" image:[UIImage imageNamed:@"a1.png"] action:^(UzysSMMenuItem *item) {
//        NSLog(@"Item: %@", item);
//        
//        [UIView animateWithDuration:0.2 animations:^{
//            keyword = @"";
//            
//            [self.topMenuBtn setSelected:NO];
//
//            [self.uzysSMenu removeFromSuperview];
//            
//            self.myTitleLabel.text = @"通知消息";
//            self.myTitleLabel.tag = 1;
//            [SVProgressHUD showWithStatus:@"加载中..."];
//            [self loadData];
//
//        }];
//        
//        
//    }];
//    
//    
//    item0.tag = 0;
//    item1.tag = 1;
//    
//    //Items must contain ImageView(icon).
//    self.uzysSMenu = [[UzysSlideMenu alloc] initWithItems:@[item0,item1]];
//    self.uzysSMenu.frame = CGRectMake(0, 54, 320, self.uzysSMenu.frame.size.height);
    
//    [self loadData];
    
    NSString * receive_new_message_list = @"receive_new_message_list";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:receive_new_message_list object:nil];
    
//    [self createHeaderView];
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
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:.0f];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self loadData];
}


- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    [self.dataTableView setContentOffset:CGPointMake(0, 0) animated:NO];  //每次都置顶
    _index =KEY_READ_LINE;
    if(index==0){
        keyword = @"";
        self.myTitleLabel.text = @"收件箱";
        self.myTitleLabel.tag = 0;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
    else if(index ==1){
        keyword = @"";
        self.myTitleLabel.text = @"发件箱";
        self.myTitleLabel.tag = 1;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
   
    
}

-(void) popToRootView:(NSNotification * )notiData{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void) reloadMonitorTable:(NSNotification * )notiData{
    
     [self loadData];
    
}

- (void) backBtnClick:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


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
    [self.mySearchBar resignFirstResponder];
    
    
    static NSString *CellIdentifier = @"MessageListCell";
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    int index = indexPath.row;
    NSDictionary *data = [self.listData objectAtIndex:index];
    if(data==nil){return nil;}
    
    NSLog(@"data.........%@.......%d",[data objectForKey:@"context"],index);
    NSString *context=[data objectForKey:@"context"];
    if(context==(NSString *)[NSNull null]){
        cell.subjectLabel.text=@"";
    }else{   
        cell.subjectLabel.text = [data objectForKey:@"context"];
    }

    cell.usernameLabel.text = [data objectForKey:@"publisher"];
    cell.timeLabel.text = [data objectForKey:@"startDate"];
    cell.itemback.highlightedImage=[UIImage imageNamed:@"itembgyes.png"];
    int attachCount = [[data objectForKey:@"attachCount"] integerValue];
    if (attachCount == 0) {
        cell.attachmentImage.hidden = YES;
    }else{
        cell.attachmentImage.hidden = NO;
    }
    
    int readCount = [[data objectForKey:@"readCount"] integerValue];
   
    if(readCount == 0){
        
        [cell.priorityIv setImage:[UIImage imageNamed:@"p10"]];
        
    }else{
        [cell.priorityIv setImage:[UIImage imageNamed:@"p50"]];
        
    }
    
    cell.tag = index;
    
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
    
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    [cell addGestureRecognizer:oneFingerTwoTaps];
    
    return cell;
}


-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    [self.mySearchBar resignFirstResponder];
    
    NSDictionary *data = [self.listData objectAtIndex:index];
    
    NSString * context =  [data objectForKey:@"context"];
    [Utils cache:context forKey:@"zhuanfa_msg"];
    
    [self performSegueWithIdentifier:@"MessageDetail" sender:[NSString stringWithFormat:@"%d",index]];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mySearchBar resignFirstResponder];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int index = indexPath.row;
    
    NSDictionary *data = [self.listData objectAtIndex:index];

    NSString * context =  [data objectForKey:@"context"];
    [Utils cache:context forKey:@"zhuanfa_msg"];
    
    [self performSegueWithIdentifier:@"MessageDetail" sender:[NSString stringWithFormat:@"%d",index]];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"MessageDetail"])
	{
        
        // Get destination view
        id vc = [segue destinationViewController];
        
        // Get button tag
        NSInteger tagIndex = [(NSString *) sender intValue];
        
        MessageDetailViewController * messageDetail = (MessageDetailViewController *) vc;
        
        messageDetail.messageData = [self.listData objectAtIndex:tagIndex];
    }
}


-(void) loadData{
    keyword = self.mySearchBar.text;
    
    if(keyword == nil){
        keyword = @"";
    }
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString *method = @"getMessageList";
    if(self.myTitleLabel.tag == 1){
        method = @"getSendMessageList";
    }
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/message/%@?s=%d&c=%d&kind=0&key=%@",serverAddress,method,_index, KEY_RETURN_COUNT,keyword];
    
    
    //用于显示详细信息里面的jsp的参数
    [Utils cache:[NSString stringWithFormat:@"%d",self.myTitleLabel.tag] forKey:@"messageKind"];
    
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

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    
    self.listData = [rspBody objectForKey:@"bulletinsVOs"];
    
    NSString * titleLable = @"收件箱";
    if(self.myTitleLabel.tag == 1){
        titleLable = @"发件箱";
    }
    self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@(%d)",titleLable,[self.listData count]];
    
    
    [self.dataTableView reloadData];
    [self.dataTableView.mj_header endRefreshing];
    [self.dataTableView.mj_footer endRefreshing];
    [SVProgressHUD dismissWithSuccess:@""];
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];

}

- (IBAction) createBtnClick:(id)sender{
    [Utils cache:@"1" forKey:@"CreateKind"];
    [self performSegueWithIdentifier:@"CreateMessage" sender:self];
}




//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f,0.0f - self.dataTableView.bounds.size.height,
                                     self.view.frame.size.width, self.dataTableView.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
	[self.dataTableView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}


-(void)removeHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = nil;
}


//===============
//刷新delegate


-(void)testFinishedLoadData{
	
    [self finishReloadingData];
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.dataTableView];
    }
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}


#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
	{
        [self loadData];
        // pull down to refresh data
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter)
	{
        // pull up to load more data
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
	
	// overide, the actual loading data operation is done in the subclass
}

//刷新调用的方法
-(void)refreshView
{
	NSLog(@"刷新完成");
    
    [self testFinishedLoadData];
	
}
//加载调用的方法
-(void)getNextPageView
{
    
    [self testFinishedLoadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
    
}


#pragma mark -
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
	
	[self beginToReloadData:aRefreshPos];
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
	
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

@end
