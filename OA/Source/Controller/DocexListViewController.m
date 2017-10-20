//
//  DocexListViewController.m
//  hongdabaopo
//
//  Created by admin on 14-7-29.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexListViewController.h"
#import "DocexDetailViewController.h"
#import "DocexCreateViewController.h"
#import "Utils.h"
#import "Constant.h"
#import "SBJsonParser.h"
#import "Constant.h"
#import "JSON.h"
#import "MainCenterViewController.h"
@interface DocexListViewController ()
@property (nonatomic,strong) MainCenterViewController * mainCenterVc;

@property(nonatomic,assign) NSUInteger index;
@end

@implementation DocexListViewController

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
    [self.theTableView addGestureRecognizer:oneFingerTwoTaps];
    
    self.mySearchBar = [[UISearchBar alloc] init];
    self.mySearchBar.placeholder = @"请输入查找内容";
    self.mySearchBar.delegate = self;
    
    UIImage *image1 =[Constant scaleToSize:[UIImage imageNamed:@"bt1"] size:CGSizeMake(80, 70)];
    UIImage *image2 =[Constant scaleToSize:[UIImage imageNamed:@"bt2"] size:CGSizeMake(80, 70)];
    UIImage *image3 =[Constant scaleToSize:[UIImage imageNamed:@"bt3"] size:CGSizeMake(80, 70)];
    UIImage *image4 =[Constant scaleToSize:[UIImage imageNamed:@"bt4"] size:CGSizeMake(80, 70)];
    
    UIImage *image1_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt1_1"] size:CGSizeMake(80, 70)];
    UIImage *image2_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt2_1"] size:CGSizeMake(80, 70)];
    UIImage *image3_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt3_1"] size:CGSizeMake(80, 70)];
    UIImage *image4_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt4_1"] size:CGSizeMake(80, 70)];
    RKTabItem * b1 = [RKTabItem createUsualItemWithImageEnabled:image1_1 imageDisabled:image1];
    b1.titleString = @"";
    RKTabItem * b2 = [RKTabItem createUsualItemWithImageEnabled:image2_1 imageDisabled:image2];
    b2.titleString = @"";
    RKTabItem * b3 = [RKTabItem createUsualItemWithImageEnabled:image3_1 imageDisabled:image3];
    b3.titleString = @"";
    RKTabItem * b4 = [RKTabItem createUsualItemWithImageEnabled:image4 imageDisabled:image4];
    b2.titleString = @"";
    
    self.tabview.darkensBackgroundForEnabledTabs = NO;
    self.tabview.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.tabview.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    // self.titledTabsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view背景.png"]];
    self.tabview.tabItems = @[b1,b2,b3,b4];
    [self.tabview swtichTab:b1];
    
    self.myTitleLabel.text = @"待办传阅";
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    _index =KEY_READ_LINE;
    self.theTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _index -=KEY_RETURN_COUNT;
        if (_index <=0) {
            _index=0;
        }
        [self loadData];
    }];
    self.theTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if(dataArray.count==KEY_RETURN_COUNT){
            _index +=KEY_RETURN_COUNT;
        }
        [self loadData];
    }];

    
}

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    [self.theTableView setContentOffset:CGPointMake(0, 0) animated:NO];  //每次都置顶
    _index =KEY_READ_LINE;
    if(index==0){
        self.myTitleLabel.text = @"待办传阅";
        self.myTitleLabel.tag = 1;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
    else if(index ==1){
        self.myTitleLabel.text = @"经办传阅";
        self.myTitleLabel.tag = 2;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
    else if(index ==2){
        self.myTitleLabel.text = @"拟稿传阅";
        self.myTitleLabel.tag = 3;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
    else if(index ==3){
        [self.repaly setUserInteractionEnabled:NO];
        self.myTitleLabel.text = @"新建传阅";
//        self.myTitleLabel.tag = 0;
        [self createDocex];
    }

}


-(void)viewDidAppear:(BOOL)animated{
    [self loadData];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self.myTitleLabel.tag == 1){
        return self.mySearchBar;
    }else{
        [self.mySearchBar removeFromSuperview];
        return  [[UIView alloc]init];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.myTitleLabel.tag == 1){
        return 25;
    }
    else{
        return 0.01f;
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
    static NSString *CellIdentifier = @"DocexListCell";
    int index = indexPath.row;
    
    DocexListCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor  = [UIColor clearColor];
    
    NSDictionary * data = [dataArray objectAtIndex:index];
    
    cell.subjectlbl.text = [data objectForKey:@"title"];
    
    cell.usernamelbl.text = [data objectForKey:@"sender"];
    
    cell.timelbl.text = [data objectForKey:@"createdate"];
    
    if([[data objectForKey:@"isRead"] intValue]==0) {
       [cell.priorityImg setImage:[UIImage imageNamed:@"p10.png"]];
    }else{
       [cell.priorityImg setImage:[UIImage imageNamed:@"p50.png"]];
    }
    
    NSMutableArray *adataattach =  [data objectForKey:@"attachList"];
    if([adataattach count]>0){
        cell.attatchImg.hidden = NO;
    }else{
        cell.attatchImg.hidden = YES;
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
    
     docexdata = [dataArray objectAtIndex:index];
    if([[docexdata objectForKey:@"isRead"] intValue]==1){
        DocexDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexDetailViewController"];
        vc.docexData=[dataArray objectAtIndex:index-1];
        [self.navigationController pushViewController:vc animated:YES  ];
    }else{
        [self checkread];
    }
    
    
}

-(void)createDocex{
    
    DocexCreateViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexCreateViewController"];
    [self.navigationController pushViewController:vc animated:YES  ];
}

-(void)checkread{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/docexRead?id=%@",serverAddress,[docexdata objectForKey:@"id"]];
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    [postbody appendData:data];
    
    [request setPostBody:postbody ];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
}
- (void)GetResult1:(ASIHTTPRequest *)request{
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);

    DocexDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexDetailViewController"];
    vc.docexData=docexdata;
    NSString * titleTag = [NSString stringWithFormat:@"%ld",(long)self.myTitleLabel.tag];
    [vc.docexData setObject:titleTag forKey:@"titleTag"];
    [self.navigationController pushViewController:vc animated:YES  ];
    
}


-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    
    docexdata = [dataArray objectAtIndex:index];
    if([[docexdata objectForKey:@"isRead"] intValue]==1){
        DocexDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexDetailViewController"];
        vc.docexData=[dataArray objectAtIndex:index];
        NSString * titleTag = [NSString stringWithFormat:@"%ld",(long)self.myTitleLabel.tag];
        [vc.docexData setObject:titleTag forKey:@"titleTag"];
        
        [self.navigationController pushViewController:vc animated:YES  ];
    }else{
        [self checkread];
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"DocexDetail"])
	{
        
        // Get destination view
        id vc = [segue destinationViewController];
        
        // Get button tag
        NSInteger tagIndex = [(NSString *) sender intValue];
        
        DocexDetailViewController * noticeDetail = (DocexDetailViewController *) vc;
        
        NSString * titleTag = [NSString stringWithFormat:@"%ld",(long)self.myTitleLabel.tag];
        [noticeDetail.docexData setObject:titleTag forKey:@"titleTag"];
    }
}


-(void) loadData{
    
    keyword = self.mySearchBar.text;
    if(keyword == nil){
        keyword = @"";
    }
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    if (self.myTitleLabel.tag == 1) {
        urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/inboxList?s=%d&c=%d",serverAddress,_index,KEY_RETURN_COUNT];
    }else if(self.myTitleLabel.tag == 2){
        if(keyword == nil){
            keyword = @"";
        }
        urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/passList?s=%d&c=%d",serverAddress,_index,KEY_RETURN_COUNT];
    }else if(self.myTitleLabel.tag == 3){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/CurdraftList?s=%d&c=%d",serverAddress,_index,KEY_RETURN_COUNT];
    }
    
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
    dataArray = [rspBody objectForKey:@"docexFiledtVOs"];
    NSString * titleLable = [self.myTitleLabel.text substringToIndex:4];
    NSLog(@"%lu",(unsigned long)titleLable.length);
    
    if([titleLable isEqualToString:@"新建传阅"]){
        self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@",titleLable];
    }else{
    self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@(%d)",titleLable,[dataArray count]];
    }
    NSLog(@"%@",self.myTitleLabel.text);
     [self.theTableView reloadData];
    [SVProgressHUD dismissWithSuccess:@""];
    self.theTableView.delegate=self;
    self.theTableView.dataSource=self;
   
    [self.theTableView.mj_header endRefreshing];
    [self.theTableView.mj_footer endRefreshing];
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];

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

//- (IBAction) menuBtnClick:(id)sender{
//    
//    [self.topMenuBtn setSelected:!self.topMenuBtn.selected];
//    
//    if(self.topMenuBtn.selected){
//        self.uzysSMenu.userInteractionEnabled = YES;
//        [self.view addSubview:self.uzysSMenu];
//        
//    }else{
//        self.uzysSMenu.userInteractionEnabled = NO;
//        [self.uzysSMenu removeFromSuperview];
//    }
//    
//    
//    [self.uzysSMenu toggleMenu];
//    
//    [self.view bringSubviewToFront:self.uzysSMenu];
//}




- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) refreshBtnClick:(id)sender{
    
    [SVProgressHUD showWithStatus:@"刷新..."];
    [self loadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
