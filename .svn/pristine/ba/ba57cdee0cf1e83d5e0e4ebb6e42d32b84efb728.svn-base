//
//  DocexOptionViewController.m
//  hongdabaopo
//
//  Created by admin on 14-8-1.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexOptionViewController.h"
#import "Utils.h"
#import "Constant.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "DocexOptionCell.h"
#import "AttachmentListViewController.h"



@interface DocexOptionViewController ()
{
    float app_width;
    float app_height;
}

@end

@implementation DocexOptionViewController

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
    [self loadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [self loadData];
}
-(void) loadData{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/getInboxOptions?id=%@&opId=0&s=%d&c=%d&rn=20&type=%@",serverAddress,self.docexId,KEY_READ_LINE,KEY_RETURN_COUNT,self.docexcaretory];
    NSLog(@"%@......",urlAddress);
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
    
    dataArray=[rspBody objectForKey:@"docexFileOptionVOs"];
    
    for(int k = 0 ;k<[dataArray count];k++ ){
        
    NSMutableDictionary *docexOpReply=[dataArray objectAtIndex:k];
      if([[docexOpReply objectForKey:@"docexFileOpReplyVOs"] count]>0){
          for(int j = 0 ; j < [docexOpReply count]; j++){
            NSDictionary * OpReply = [[docexOpReply objectForKey:@"docexFileOpReplyVOs"] objectAtIndex:0];
            NSMutableDictionary * data=[[NSMutableDictionary alloc] init];
              [data setObject:[OpReply objectForKey:@"repId"]forKey:@"opId"];
              [data setObject:[OpReply objectForKey:@"repDate"]forKey:@"opDate"];
              [data setObject:[OpReply objectForKey:@"repContent"]forKey:@"opContent"];
              [data setObject:[OpReply objectForKey:@"repUser"]forKey:@"opUser"];
              [data setObject:[OpReply objectForKey:@"repUId"]forKey:@"opUId"];
              [data setObject:[OpReply objectForKey:@"repUSex"]forKey:@"opUSex"];
              [data setObject:[OpReply objectForKey:@"docexFileAttachAllVO"]forKey:@"docexFileAttachAllVO"];
              [dataArray addObject:data];
          }

       }
    }
    [self.theTableView reloadData];
    self.theTableView.dataSource=self;
    self.theTableView.delegate=self;
    
}
- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    NSLog(@"服务器连接不上！");
    
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
    static NSString *CellIdentifier = @"DocexOptionCell";
    int index = indexPath.row;
    DocexOptionCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor  = [UIColor clearColor];
    
    NSDictionary * data = [dataArray objectAtIndex:index];
    cell.usernamelbl.text=[data objectForKey:@"opUser"];
    cell.timelbl.text=[data objectForKey:@"opDate"];
    cell.titlelbl.text=[data objectForKey:@"opContent"];
    if([[data objectForKey:@"opUSex"] intValue]==1){
        [cell.headImage setImage:[UIImage imageNamed:@"peoheadman"]];
    }
    else{
        [cell.headImage setImage:[UIImage imageNamed:@"peoheadwoman"]];
    }
    NSMutableDictionary *attachdata=[data objectForKey:@"docexFileAttachAllVO"];
    NSMutableArray * attachArray=[attachdata objectForKey:@"docexFileAttachVOs"];
   
    if([attachArray count]>0){
        cell.attatchbtn.hidden=NO;
        cell.attatchbtn.tag=index;
        [cell.attatchbtn addTarget:self action:@selector(attatch:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
         cell.attatchbtn.hidden=YES;
    }
    cell.tag = index;
    
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
    
    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    [cell addGestureRecognizer:oneFingerTwoTaps];
    return cell;
}

-(IBAction)attatch:(id)sender{
    UIButton *btn=(UIButton *)sender;
    int index = btn.tag;
    NSDictionary * data = [dataArray objectAtIndex:index];
    NSMutableDictionary *attachdata=[data objectForKey:@"docexFileAttachAllVO"];
    NSMutableArray * attachArray=[attachdata objectForKey:@"docexFileAttachVOs"];
    if([attachArray count]==0){return;}
    AttachmentListViewController * attachmentList = [self.storyboard instantiateViewControllerWithIdentifier:@"AttachmentListViewController"];
    
    attachmentList.listData =  attachArray;
    attachmentList.attachType = 3;
    [self.navigationController pushViewController:attachmentList animated:YES];
    
    
}

-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    NSDictionary * data = [dataArray objectAtIndex:index];
    NSMutableDictionary *attachdata=[data objectForKey:@"docexFileAttachAllVO"];
    NSMutableArray * attachArray=[attachdata objectForKey:@"docexFileAttachVOs"];
    NSString *msg=[data objectForKey:@"opContent"];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"意见详情"
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil,nil];
    [alert show];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int index = indexPath.row;
    NSDictionary * data = [dataArray objectAtIndex:index];
    NSMutableDictionary *attachdata=[data objectForKey:@"docexFileAttachAllVO"];
    NSMutableArray * attachArray=[attachdata objectForKey:@"docexFileAttachVOs"];
    if([attachArray count]==0){return;}
    AttachmentListViewController * attachmentList = [self.storyboard instantiateViewControllerWithIdentifier:@"AttachmentListViewController"];
    
    attachmentList.listData =  attachArray;
    attachmentList.attachType = 3;
    [self.navigationController pushViewController:attachmentList animated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
