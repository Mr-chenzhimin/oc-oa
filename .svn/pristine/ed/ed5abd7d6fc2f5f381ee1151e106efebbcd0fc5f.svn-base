//
//  EntrustlistViewController.m
//  OA
//
//  Created by admin on 17/1/5.
//  Copyright © 2017年 dengfan. All rights reserved.
//

#import "EntrustlistViewController.h"
#import "EntrustViewController.h"
#import "ASIHTTPRequest.h"

@interface EntrustlistViewController (){
    UISegmentedControl *segmentedControl;
}
@property(nonatomic) NSUInteger selectedIndex;//add
@property(nonatomic ,strong) NSString *entrustType;
@property (nonatomic,strong) UIImageView * checkBtn;
@end

@implementation EntrustlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectUserArray = [[NSMutableArray alloc]init];
    _dataArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 50)];
    topView.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:topView];
    
    UIButton *backbtn =[[UIButton alloc]initWithFrame:CGRectMake(10, 15, 30, 30)];
    [backbtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setImage:[UIImage imageNamed:@"L"] forState:UIControlStateNormal];
    [topView addSubview:backbtn];
    
    int x_ = ((UIScreenWidth - 280) / 2);
    UILabel *titile =[[UILabel alloc]initWithFrame:CGRectMake(x_, 20, 280, 30)];
    titile.text=@"我的委托";
    titile.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:titile];
    
    NSArray *entrust = [NSArray arrayWithObjects:@"未委托",@"已委托" ,nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:entrust];
   
    segmentedControl.frame = CGRectMake(x_, 54, 280, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    
    _entrustType =@"undoent";
    
    UITableView *theTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 85, UIScreenWidth, UIScreenHeight-100)];
    theTableView.delegate =self;
    theTableView.dataSource=self;
    [self.view addSubview:theTableView];
    
    //委托底部控件
    _entBtn = [[UIButton alloc] initWithFrame:CGRectMake(2, UIScreenHeight-40, UIScreenWidth-4, 40)];
    [_entBtn setTitle:@"委托" forState:UIControlStateNormal];
    [_entBtn setBackgroundImage:[UIImage imageNamed:@"btn_绿色"] forState:UIControlStateNormal];
    [_entBtn addTarget:self action:@selector(entBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_entBtn];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self loadData];
}


-(void) loadData{
    
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_READ_LINE] forKey:@"s"];
    [parameter setObject:[NSString stringWithFormat:@"%d",KEY_RETURN_COUNT] forKey:@"c"];
    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    
    if ([_entrustType isEqualToString:@"undoent"]) {
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/getAllworkflow?s=%d&c=%d&isAll=1&type=2",serverAddress,KEY_READ_LINE,KEY_RETURN_COUNT];
    }else{
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/getAllworkflow?s=%d&c=%d&isAll=1&type=1",serverAddress,KEY_READ_LINE,KEY_RETURN_COUNT];
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
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    _dataArray = [rspBody objectForKey:@"workflowList"];
   
  
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



-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            _entrustType = @"undoent";
            [_entBtn setTitle:@"委托" forState:UIControlStateNormal];
            [_selectUserArray removeAllObjects];
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
        case 1:
            _entrustType = @"donent";
            [_entBtn setTitle:@"取消委托" forState:UIControlStateNormal];
            [_selectUserArray removeAllObjects];
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData];
            break;
    }
}



-(void)entBtnSelected:(UIButton*)sender{
    if ([_entrustType isEqualToString:@"donent"]) {
        OALog(@"取消委托");
        [self cancelClick];
        
    }else{
        if ([_selectUserArray count] == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:@"温馨提示"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"请选择一条委托",nil];
            [alert show];
        }else{
            EntrustViewController *entVc = [[EntrustViewController alloc]init];
            
            entVc.selectEntArray = _selectUserArray;
            
            [self presentViewController:entVc animated:YES completion:nil];
            
        }
    }
    
}

//取消委托
- (void)cancelClick {
    //
    NSInteger count = [_selectUserArray count];
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    if (count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"温馨提示"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"请选择一条委托",nil];
        [alert show];
        alert.tag = 11;
        return ;
    }
    
    NSString *flowIds = nil;
    
    for (NSMutableDictionary *flowid in _selectUserArray) {
        NSString *flow = [flowid objectForKey:@"id"];
        if(flowIds == nil){
            flowIds = flow;
        }else{
            flowIds = [NSString stringWithFormat:@"%@,%@", flowIds, flow];
        }
    }
    
    
    //        NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/message/saveMessage",serverAddress];
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/removeagentFile?flowids=%@",serverAddress,flowIds];
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
   ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url];
    [request1 setRequestHeaders:headers];
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request1 setDelegate:self];
    [request1 startAsynchronous];
    
    [request1 setDidFinishSelector:@selector(GetResult1:)];
    [request1 setDidFailSelector:@selector(GetErr1:)];
    
}
- (void)GetResult1:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    NSInteger status = [[rspHeader objectForKey:@"code"] integerValue];
    NSString * msg = [rspHeader objectForKey:@"msg"];
    
    if (status == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:msg
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 10;
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:msg
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:nil,nil];
        [alert show];
        
    }
    [self loadData];
}


- (void) GetErr1:(ASIHTTPRequest *)request{
    
    
    NSLog(@"%@", [request error]);
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"加载失败"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    static NSString *newfilecell = @"newfilenamecell";
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:newfilecell];
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0,3,UIScreenWidth,41)];
  
    _checkBtn = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    //内容
    UILabel *entrustlabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, UIScreenWidth, 30)];

    NSDictionary * data = [_dataArray objectAtIndex:index];
    //
    BOOL selected = [self.selectUserArray containsObject:data];
    
    if (selected) {
        [_checkBtn setImage:[UIImage imageNamed:@"icon_打勾"]];
        
    }else{
        [_checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"]];
        
    }
    
    
    
    NSString *name = [data objectForKey:@"name"];
    NSInteger flowids1 = [[data objectForKey:@"id"]intValue];
    NSString *catalogy = [data objectForKey:@"catalogy"];
    //          int catalogyid = [[data objectForKey:@"catalogyid"]intValue];
    
    
    if ([name isEqualToString:@""]) {
        entrustlabel.text = catalogy;
        _checkBtn.hidden =YES;
        cell.userInteractionEnabled = NO;
        entrustlabel.frame = CGRectMake(5, 5, UIScreenWidth, 30);
    }else{
        entrustlabel.text = name;
        _checkBtn.hidden =NO;
        entrustlabel.frame = CGRectMake(60, 5, UIScreenWidth, 30);
    }
    
    
    [backview addSubview:_checkBtn];
    [backview addSubview:entrustlabel];
    
    [cell.contentView addSubview:backview];
    cell.backgroundColor=[UIColor clearColor];
   
    
    
    
    cell.tag = index;
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
    
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    [cell addGestureRecognizer:oneFingerTwoTaps];
    return cell;

}

-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
  
        
    NSDictionary * data = [_dataArray objectAtIndex:index];
    
    BOOL selected = [self.selectUserArray containsObject:data];
    
    if (selected) {
        [self.selectUserArray removeObject:data];
    }else{
        [self.selectUserArray addObject:data];
    }
    
    [self.theTableView reloadData];
        
        
        NSLog(@"buttag==%ld",(long)_checkBtn.tag);
        NSLog(@"index==%ld",(long)index);
   
}


- (void)backClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
