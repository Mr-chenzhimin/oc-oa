//
//  WorkFlowListViewController.m
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "WorkFlowListViewController.h"
#import "Utils.h"
#import "Constant.h"
#import "NewWorkFlowFIleosViewController.h"
#import "EntrustlistViewController.h"

@interface WorkFlowListViewController ()<RKTabViewDelegate>{

}
@property (strong, nonatomic) IBOutlet RKTabView *titledTabsView;
@property (nonatomic,strong) MainCenterViewController * mainCenterVc;
@property (nonatomic, strong)NSMutableArray *itemArray;
@property (nonatomic,assign) NSInteger index;
@end

@implementation WorkFlowListViewController

@synthesize msgBadge;


- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

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
	typekey=1;
    dataArray = [[NSMutableArray alloc] init];
    datacaretoryName= [[NSMutableArray alloc] init];
    datacaretory= [[NSMutableArray alloc] init];
    
    
    self.mySearchBar = [[UISearchBar alloc] init];
    self.mySearchBar.placeholder = @"请输入查找内容";
    self.mySearchBar.delegate = self;
    
    UITapGestureRecognizer *oneFingerTwoTaps =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSearchBar)];
   
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    [self.theTableView addGestureRecognizer:oneFingerTwoTaps];
   
    
    NSString * notif_workflow_poproot = @"notif_workflow_poproot";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView:) name:notif_workflow_poproot object:nil];
    
    self.navigationItem.title=@"我的待办";
    
    UIImage *image1 =[Constant scaleToSize:[UIImage imageNamed:@"bt1"] size:CGSizeMake(80, 70)];
    UIImage *image2 =[Constant scaleToSize:[UIImage imageNamed:@"bt2"] size:CGSizeMake(80, 70)];
    UIImage *image3 =[Constant scaleToSize:[UIImage imageNamed:@"bt3"] size:CGSizeMake(80, 70)];
    UIImage *image4 =[Constant scaleToSize:[UIImage imageNamed:@"bt4"] size:CGSizeMake(80, 70)];
    UIImage *image5 =[Constant scaleToSize:[UIImage imageNamed:@"bt5"] size:CGSizeMake(80, 70)];
    UIImage *image1_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt1_1"] size:CGSizeMake(80, 70)];
    UIImage *image2_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt2_1"] size:CGSizeMake(80, 70)];
    UIImage *image3_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt3_1"] size:CGSizeMake(80, 70)];
    UIImage *image4_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt4_1"] size:CGSizeMake(80, 70)];
    UIImage *image5_1 =[Constant scaleToSize:[UIImage imageNamed:@"bt5"] size:CGSizeMake(80, 70)];
    RKTabItem * b1 = [RKTabItem createUsualItemWithImageEnabled:image1_1 imageDisabled:image1];
    b1.titleString = @""; // 待办
    RKTabItem * b2 = [RKTabItem createUsualItemWithImageEnabled:image2_1 imageDisabled:image2];
    b2.titleString = @""; // 经办
    RKTabItem * b3 = [RKTabItem createUsualItemWithImageEnabled:image3_1 imageDisabled:image3];
    b3.titleString = @""; // 拟稿
    RKTabItem * b4 = [RKTabItem createUsualItemWithImageEnabled:image4_1 imageDisabled:image4];
    b2.titleString = @""; // 新建
    RKTabItem * b5 = [RKTabItem createUsualItemWithImageEnabled:image5 imageDisabled:image5];
    b2.titleString = @"";  // 委托
    self.titledTabsView.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    // self.titledTabsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view背景.png"]];
    self.titledTabsView.tabItems = @[b1,b2,b3,b4];
    [self.titledTabsView swtichTab:b1];
    
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

//    [self createHeaderView];
//    [self createFooterView];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:.0f];
    
}
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
   [tabView swtichTab:tabItem];
    [self.theTableView setContentOffset:CGPointMake(0, 0) animated:NO];  //每次都置顶
    _index =KEY_READ_LINE;
    if(index==0){
        keyword = @"";
        self.myTitleLabel.text = @"待办文件";
        self.myTitleLabel.tag = 0;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
    else if(index ==1){
        self.myTitleLabel.text = @"我的经办";
        self.myTitleLabel.tag = 1;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
    else if(index ==2){
        self.myTitleLabel.text = @"我的拟稿";
        self.myTitleLabel.tag = 3;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }
    else if(index ==3){
        self.myTitleLabel.text = @"新建公文";
        self.myTitleLabel.tag = 4;
        [SVProgressHUD showWithStatus:@"加载中..."];
        [self loadData];
    }else if (index ==4){
        self.myTitleLabel.text = @"我的委托";
        self.myTitleLabel.tag = 5;
//        [SVProgressHUD showWithStatus:@"加载中..."];
        [self toEntrustviewController];
    }
    
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %tu became disabled on tab view", index);
}

-(void)viewDidAppear:(BOOL)animated{
    [self loadData];
}
- (void)toEntrustviewController{
    EntrustlistViewController *vc =[[EntrustlistViewController alloc]init];
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}

-(void) popToRootView:(NSNotification * )notiData{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}



- (IBAction) refreshBtnClick:(id)sender{
    [SVProgressHUD showWithStatus:@"刷新..."];
    [self loadData];
    
}
//

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    if (self.myTitleLabel.tag == 0) {
        dataArray = [rspBody objectForKey:@"todoList"];
    }else if(self.myTitleLabel.tag == 4){
        dataArray=[rspBody objectForKey:@"newFilelist"];
        if (dataArray) {
            datacaretoryName=[self getfileCaretoryname:@""];
        }
    }else {
        dataArray = [rspBody objectForKey:@"doneFileDescVOs"];
    }
    
    
    NSString * titleLable = [self.myTitleLabel.text substringToIndex:4];
    if(self.myTitleLabel.tag == 4)
    {
        self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@(%d)",titleLable,[datacaretoryName count]];
    }else{
        self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@(%d)",titleLable,[dataArray count]];
    }
    
    
    [self.theTableView reloadData];
    [self.theTableView.mj_header endRefreshing];
    [self.theTableView.mj_footer endRefreshing];
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
    
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_READ_LINE] forKey:@"s"];
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_RETURN_COUNT] forKey:@"c"];
    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;

    if (self.myTitleLabel.tag == 0) {
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/todoList?s=%d&c=%d&isAll=1&type=0",serverAddress,_index,KEY_RETURN_COUNT];
    }else if(self.myTitleLabel.tag == 1){
        if(keyword == nil){
            keyword = @"";
        }
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/doneList?s=%d&c=%d&isAll=1&type=mySent&key=%@",serverAddress,_index,KEY_RETURN_COUNT,keyword];
    }else if(self.myTitleLabel.tag == 3){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/doneList?s=%d&c=%d&isAll=1&type=myDraft",serverAddress,_index,KEY_RETURN_COUNT];
    }else if(self.myTitleLabel.tag == 2){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/doneList?s=%d&c=%d&isAll=1&type=myAttention",serverAddress,_index,KEY_RETURN_COUNT];
    }else if(self.myTitleLabel.tag == 4){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/newFilelist?ft=0&fi=0",serverAddress];
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
        return  nil;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.myTitleLabel.tag == 1){
        return 25;
    }
    else{
        return 0.01f;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.myTitleLabel.tag==4){
        if(typekey==1){
            return [datacaretoryName count];
        }
        else{
            return [datacaretory count]+1;
        }
    }else{
        
        return [dataArray count];
    }
    return  0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.myTitleLabel.tag == 4){
        int index=indexPath.row;
      
     if(typekey==1){
         static NSString *newfilecell = @"newfilecaretorycell";
         UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:newfilecell];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         if(cell == nil){
             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newfilecell];
             CGRect nameRect = CGRectMake(63, 14, 193, 31);
             UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
             nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
             nameLabel.textColor = [UIColor blackColor];
             NSDictionary * data = [datacaretoryName objectAtIndex:index];
             NSString * caretoryname=  [data objectForKey:@"catetoryName"];
             nameLabel.text=caretoryname;
             [cell.contentView addSubview:nameLabel];
             
             CGRect imageRect = CGRectMake(8, 9, 42, 42);
             UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
             imageView.image = [UIImage imageNamed:@"icon_文件夹"];
             [cell.contentView addSubview:imageView];
             
             CGRect imageRect1 = CGRectMake(283, 14, 28, 28);
             UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:imageRect1];
             imageView1.image = [UIImage imageNamed:@"icon_向下箭头"];
             [cell.contentView addSubview:imageView1];
             UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
             lbl.frame = CGRectMake(cell.frame.origin.x , cell.frame.size.height+25, cell.frame.size.width, 1);
             lbl.backgroundColor =  [UIColor lightGrayColor];
             [cell.contentView addSubview:lbl];
             [lbl release];
         }
         cell.tag = index;
         UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
         
         [oneFingerTwoTaps setNumberOfTapsRequired:1];
         [oneFingerTwoTaps setNumberOfTouchesRequired:1];
         
         [cell addGestureRecognizer:oneFingerTwoTaps];
         return cell;
        
     }else{
         int index = indexPath.row;
        
         if(index==0){
             static NSString *newfilecell = @"newcell";
             UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:newfilecell];
             if(cell == nil){
                 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newfilecell];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 CGRect nameRect = CGRectMake(63, 14, 193, 31);
                 UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
                 nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
                 nameLabel.textColor = [UIColor blackColor];
                 NSDictionary * data = [datacaretoryName objectAtIndex:caretoryindex];
                 NSString * caretoryname=[data objectForKey:@"catetoryName"];
                 nameLabel.text=caretoryname;
                 
                 [cell.contentView addSubview:nameLabel];
                 
                 CGRect imageRect = CGRectMake(8, 9, 42, 42);
                 UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
                 imageView.image = [UIImage imageNamed:@"icon_文件夹"];
                 [cell.contentView addSubview:imageView];
                 
                 CGRect imageRect1 = CGRectMake(283, 14, 28, 28);
                 UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:imageRect1];
                 imageView1.image = [UIImage imageNamed:@"icon_向下箭头"];
                 [cell.contentView addSubview:imageView1];
                 UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
                 lbl.frame = CGRectMake(cell.frame.origin.x , cell.frame.size.height+25, cell.frame.size.width, 1);
                 lbl.backgroundColor =  [UIColor lightGrayColor];
                 [cell.contentView addSubview:lbl];
                 [lbl release];
             }
          
             cell.tag = index;
             UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
             
             [oneFingerTwoTaps setNumberOfTapsRequired:1];
             [oneFingerTwoTaps setNumberOfTouchesRequired:1];
             
             [cell addGestureRecognizer:oneFingerTwoTaps];
             return cell;
         
         }else{
         static NSString *newfilecell = @"newfilenamecell";
             UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:newfilecell];
         
         if(cell == nil){
             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                      reuseIdentifier:newfilecell];
             CGRect imageRect = CGRectMake(4, 17, 30, 30);
             UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
             imageView.image = [UIImage imageNamed:@"workflow1"];
             [cell.contentView addSubview:imageView];
             
             UIView *backview = [[UIView alloc] init];
             backview.frame=CGRectMake(35,3,280,65);
             
             CGRect imageRect1 = CGRectMake(0, 0, 280, 65);
             UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:imageRect1];
             imageView1.image = [UIImage imageNamed:@"bg_选项背景2"];
             
                     
             CGRect nameRect = CGRectMake(10, 14, 193, 31);
             UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
             nameLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
             nameLabel.textColor = [UIColor blackColor];
             NSDictionary * data = [datacaretory objectAtIndex:index-1];
             NSString * lastver=[data objectForKey:@"lastver"];
             NSString * fileosName=[data objectForKey:@"fileosName"];
             nameLabel.text=[NSString stringWithFormat:@"%@",fileosName];
             [backview addSubview:imageView1];
             [backview addSubview:nameLabel];
             
             [cell.contentView addSubview:backview];
             cell.backgroundColor=[UIColor clearColor];
             [backview release];
         }
         cell.tag = index;
         UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
         
         [oneFingerTwoTaps setNumberOfTapsRequired:1];
         [oneFingerTwoTaps setNumberOfTouchesRequired:1];
         
         [cell addGestureRecognizer:oneFingerTwoTaps];
             return cell;
         }
     }
    }
    else
    {
        static NSString *CellIdentifier = @"WorkFlowCell";
        
        [self.mySearchBar resignFirstResponder];
        
        int index = indexPath.row;
        
        WorkFlowCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor  = [UIColor clearColor];

        NSDictionary * data = [dataArray objectAtIndex:index];
        
        if (self.myTitleLabel.tag == 0) {
            cell.subjectLabel.text = [data objectForKey:@"fileName"];
        }else {
            cell.subjectLabel.text = [data objectForKey:@"title"];
        }
        
        cell.usernameLabel.text = [data objectForKey:@"sender"];
        cell.timeLabel.text = [data objectForKey:@"sendDate"];
        cell.itemback.highlightedImage=[UIImage imageNamed:@"itembgyes.png"];
        int priority = [[data objectForKey:@"priority"] intValue];
        
        int attachCount = [[data objectForKey:@"attachCount"] integerValue];
        int attatchCount = [[data objectForKey:@"attatchCount"] integerValue];
        
        if(attatchCount > 0 || attachCount >0){
            cell.attatchIv.hidden = NO;
        }else{
            cell.attatchIv.hidden = YES;
        }
        if(priority==-9999){
            priority=50;
        }
        
        NSString * priorityImage =[NSString stringWithFormat:@"p%d",priority];
        
        [cell.priorityIv setImage:[UIImage imageNamed:priorityImage]];
        
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
     
    [self performSegueWithIdentifier:@"WorkFlowDetail" sender:[NSString stringWithFormat:@"%d",index]];
    
   
}

-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    
    if(self.myTitleLabel.tag==4){
        
        if(typekey==1){
            typekey=2;
            [datacaretory removeAllObjects];
            caretoryindex=index;
            NSDictionary * data = [datacaretoryName objectAtIndex:index];
            NSString * caretoryname=[data objectForKey:@"catetoryName"];
            datacaretory=[self getfileCaretoryname:caretoryname];
            NSString * titleLable = [self.myTitleLabel.text substringToIndex:4];
            
            self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@(%d)",titleLable,[datacaretory count]];
            [self.theTableView reloadData];
            
        }
        else{
            if(index==0){
                typekey=1;
                NSString * titleLable = [self.myTitleLabel.text substringToIndex:4];
                self.myTitleLabel.text = [[NSString alloc] initWithFormat:@"%@(%d)",titleLable,[datacaretoryName count]];
                [self.theTableView reloadData];
                
            }else{
                NewWorkFlowFIleosViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewWorkFlowFIleosViewController"];
                vc.WorkflownewFiledata=[datacaretory objectAtIndex:index-1];
                [self.navigationController pushViewController:vc animated:YES  ];
            }
            
            
        }
        
    }else{
          [self performSegueWithIdentifier:@"WorkFlowDetail" sender:[NSString stringWithFormat:@"%d",index]];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"WorkFlowDetail"])
	{
        
        // Get destination view
        id vc = [segue destinationViewController];
        
        // Get button tag
        NSInteger tagIndex = [(NSString *) sender intValue];
        
        WorkFlowDetailViewController * noticeDetail = (WorkFlowDetailViewController *) vc;
        
        noticeDetail.workFlowData =  [dataArray objectAtIndex:tagIndex];
        noticeDetail.workFlowTag = self.myTitleLabel.tag;
        
        //
        if (self.myTitleLabel.tag == 0) {
            NSString * attatchCount = [noticeDetail.workFlowData objectForKey:@"attatchCount"];
            [noticeDetail.workFlowData setObject:attatchCount forKey:@"attachCount"];
        }else if(self.myTitleLabel.tag == 1){
            
        }
        
        NSString * titleTag = [NSString stringWithFormat:@"%d",self.myTitleLabel.tag];
        [noticeDetail.workFlowData setObject:titleTag forKey:@"titleTag"];

        // Set the selected button in the new view
        // [vc setSelectedButton:tagIndex];
    }
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

-(void)createFooterView{
    if (_refreshFooterView && [_refreshFooterView superview]) {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                          CGRectMake(0,0,  self.theTableView.bounds.size.width, 0)];
    _refreshFooterView.delegate = self;
    self.theTableView.tableFooterView = _refreshFooterView;
    [self.theTableView addSubview:_refreshFooterView];
    
    [_refreshFooterView refreshLastUpdatedDate];
    
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
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.theTableView];
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
        _index -= KEY_RETURN_COUNT;
        if (_index <0) {
            _index =0;
        }
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
    [_theTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    if (dataArray.count==KEY_RETURN_COUNT) {
        _index += KEY_RETURN_COUNT;
    }
    [self loadData];
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
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
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
