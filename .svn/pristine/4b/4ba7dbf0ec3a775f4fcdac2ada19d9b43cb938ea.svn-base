//
//  FollowDetailViewController.m
//  OA
//
//  Created by Mac on 14-5-9.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "FollowDetailViewController.h"
#import "FollwdetailCell.h"
#import "Utils.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"

@interface FollowDetailViewController ()

@end

@implementation FollowDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
//返回组数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//组的名称
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return @"当前文件所在位置";//就是组名
    }else{
        return @"流程跟踪信息";
    }
}

//返回组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [dataCurArray count];
    }else{
        return [dataHistoryArray count];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 130;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FollwdetailCell";
    int index = indexPath.row;
    if(indexPath.section == 0){
        
        NSDictionary * data = [dataCurArray objectAtIndex:index];
        FollwdetailCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor  = [UIColor clearColor];
        
        cell.lblsendnode.text=[NSString stringWithFormat:@"%@",[data objectForKey:@"placestep"]];
        cell.lblsendpeo.text=[NSString stringWithFormat:@"处理人:%@",[data objectForKey:@"manager"]];
        cell.lblreceivenode.text=[NSString stringWithFormat:@"所在部门:%@",[data objectForKey:@"placedept"]];
        cell.receivepeo.text=[NSString stringWithFormat:@"状态:%@",[data objectForKey:@"status"]];
    
        cell.lblstarttime.text=[NSString stringWithFormat:@"开始时间:%@",[data objectForKey:@"starttime"]];
        if([[data objectForKey:@"receivetime"] isEqualToString:@"null"]||[[data objectForKey:@"receivetime"] isEqualToString:@" "])
         {
             cell.lblreceivetime.text=@"签收时间:无";
         }else{
         cell.lblreceivetime.text=[NSString stringWithFormat:@"签收时间:%@",[data objectForKey:@"receivetime"]];
         }
    
        return cell;
    }else{
        
        NSDictionary * data = [dataHistoryArray objectAtIndex:index];
        FollwdetailCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor  = [UIColor clearColor];
        
        cell.lblsendnode.text=[NSString stringWithFormat:@"%@",[data objectForKey:@"placestep"]];
        cell.lblsendnode.text=[NSString stringWithFormat:@"%@",[data objectForKey:@"sendnode"]];
        cell.lblsendpeo.text=[NSString stringWithFormat:@"发送人:%@",[data objectForKey:@"sendpeo"]];
        cell.lblreceivenode.text=[NSString stringWithFormat:@"接收节点:%@",[data objectForKey:@"receivenode"]];
        cell.receivepeo.text=[NSString stringWithFormat:@"接收人:%@",[data objectForKey:@"receivepeo"]];
        cell.lblrelateinfo.text=[NSString stringWithFormat:@"相关信息:%@",[data objectForKey:@"relateinfo"]];
        cell.lblprocessresult.text=[NSString stringWithFormat:@"处理结果:%@",[data objectForKey:@"processresult"]];
        
        cell.lblstarttime.text=[NSString stringWithFormat:@"开始时间:%@",[data objectForKey:@"starttime"]];
        if([[data objectForKey:@"receivetime"] isEqualToString:@"null"]||[[data objectForKey:@"receivetime"] isEqualToString:@" "])
        {
            cell.lblreceivetime.text=@"签收时间:";
        }else{
            cell.lblreceivetime.text=[NSString stringWithFormat:@"签收时间:%@",[data objectForKey:@"receivetime"]];
        }
        if([[data objectForKey:@"sendtime"] isEqualToString:@"null"]||[[data objectForKey:@"sendtime"] isEqualToString:@" "]){
            cell.lblsendtime.text = @"送出时间：";
        }else{
            cell.lblsendtime.text = [NSString stringWithFormat:@"送出时间:%@",[data objectForKey:@"sendtime"]];
        }

        
        return cell;

    }

}

- (void)viewDidLoad
{
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    dataCurArray = [[NSMutableArray alloc] init];
    dataDetailAllArray = [[NSMutableDictionary alloc] init];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self loadData];
}

-(void) loadData{
    
     NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
     NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/getfollowinfo?boxId=%@",serverAddress,_boxId];
    
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
    
    dataDetailAllArray = [result objectForKey:@"rspBody"];
    dataCurArray = [dataDetailAllArray objectForKey:@"followCurFinfo"];
    dataHistoryArray = [dataDetailAllArray objectForKey:@"followInfoVOs"];
    self.theFollowdetailView.delegate=self;
    self.theFollowdetailView.dataSource=self;
    [self.theFollowdetailView reloadData];
}
- (IBAction)btnback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    NSLog(@"服务器连接不上！");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
