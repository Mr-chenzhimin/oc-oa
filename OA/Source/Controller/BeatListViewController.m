//
//  BeatListViewController.m
//  OA
//
//  Created by admin on 15-7-13.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import "BeatListViewController.h"
#import "BeatDetailViewController.h"
#import "Utils.h"
#import "Constant.h"
#import "SBJsonParser.h"
#import "Constant.h"
#import "JSON.h"

@interface BeatListViewController ()

@end

@implementation BeatListViewController

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
    
    dataArray = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *oneFingerTwoTaps =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSearchBar)];
    
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    [[self view] addGestureRecognizer:oneFingerTwoTaps];
    
    self.myTitleLabel.text = @"报餐管理";
    
    
    
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    [self createHeaderView];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:.0f];
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self.myTitleLabel.tag == 1){
        return self.mySearchBar;
    }else{
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
    
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BeatListCell";
    int index = indexPath.row;
    
    DocexListCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor  = [UIColor clearColor];
    
    NSDictionary * data = [dataArray objectAtIndex:index];
    
    
    cell.usernamelbl.text = [data objectForKey:@"userName"];
    
    cell.timelbl.text = [data objectForKey:@"doDate"];
    
    
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
    
    beatdata = [dataArray objectAtIndex:index];
    BeatDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BeatDetailViewController"];
    //vc.beatdata=[dataArray objectAtIndex:index-1];
    [self.navigationController pushViewController:vc animated:YES  ];
    
    
    
}

-(IBAction) createBeatClick:(id)sender{
    
    BeatDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BeatDetailViewController"];
    vc.beatId = @"";
    [self.navigationController pushViewController:vc animated:YES  ];
}




-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    
    beatdata = [dataArray objectAtIndex:index];
    BeatDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BeatDetailViewController"];
    //vc.beatdata=[dataArray objectAtIndex:index];
    NSString * titleTag = [NSString stringWithFormat:@"%ld",(long)self.myTitleLabel.tag];
    //[vc.beatdata setObject:titleTag forKey:@"titleTag"];
    vc.beatId = [beatdata objectForKey:@"id"];
    
    [self.navigationController pushViewController:vc animated:YES  ];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DocexDetail"])
    {
        
        // Get destination view
        id vc = [segue destinationViewController];
        
        // Get button tag
        NSInteger tagIndex = [(NSString *) sender intValue];
        
        BeatDetailViewController * noticeDetail = (BeatDetailViewController *) vc;
        
        NSString * titleTag = [NSString stringWithFormat:@"%ld",(long)self.myTitleLabel.tag];
        //[noticeDetail.beatdata setObject:titleTag forKey:@"titleTag"];
    }
}


-(void) loadData{
    
    keyword = self.mySearchBar.text;
    if(keyword == nil){
        keyword = @"";
    }
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/catering/getCateringsList?s=%d&c=%d",serverAddress,KEY_READ_LINE,KEY_RETURN_COUNT];
   
    
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
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    dataArray = [rspBody objectForKey:@"cateringVOs"];
    
    [self.theTableView reloadData];
    [SVProgressHUD dismissWithSuccess:@""];
    self.theTableView.delegate=self;
    self.theTableView.dataSource=self;
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
     [self loadData];
    
    
}

-(void) popToRootView:(NSNotification * )notiData{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) hiddenSearchBar{
    [self.mySearchBar resignFirstResponder];
    
}

- (IBAction) menuBtnClick:(id)sender{
    
    [self.topMenuBtn setSelected:!self.topMenuBtn.selected];
    
    if(self.topMenuBtn.selected){
        self.uzysSMenu.userInteractionEnabled = YES;
        [self.view addSubview:self.uzysSMenu];
        
    }else{
        self.uzysSMenu.userInteractionEnabled = NO;
        [self.uzysSMenu removeFromSuperview];
    }
    
    
    [self.uzysSMenu toggleMenu];
    
    [self.view bringSubviewToFront:self.uzysSMenu];
}




//- (IBAction) refreshBtnClick:(id)sender{
//    [SVProgressHUD showWithStatus:@"刷新..."];
//    [self loadData];
//    
//}





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
                          CGRectMake(0.0f,0.0f - self.theTableView.bounds.size.height,
                                     self.view.frame.size.width, self.theTableView.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
    [self.theTableView addSubview:_refreshHeaderView];
    
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
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.theTableView];
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

@end
