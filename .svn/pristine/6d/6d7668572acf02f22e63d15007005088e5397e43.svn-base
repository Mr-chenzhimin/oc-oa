//
//  ShowDeptViewController.m
//  OA
//
//  Created by admin on 15-3-21.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import "ShowDeptViewController.h"

@interface ShowDeptViewController ()
{
    NSString * deptName;
    
}

@end

@implementation ShowDeptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"index_background.png"]];
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    if(self.selectdeptArray == nil){
        self.selectdeptArray = [[NSMutableArray alloc] init];
        
    }
    [self loadData];
    
    show_dept = false;
}
-(IBAction)returnBtnClick:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
}
-(IBAction) selectUserOkBtnClick:(id)sender{
    
    NSDictionary *respData= [NSDictionary dictionaryWithObject:self.selectdeptArray
                                                        forKey:@"select_dept_array"];
    
    NSString * notif_name = self.noti_name;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:respData];
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
    
}



-(IBAction)searchBtnClick:(id)sender{
    
    show_dept = false;
    
    NSString * searchKey = self.searchUserField.text;
    if (searchKey == Nil) {
        
        [self loadData];
        
        return;
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/findDeotByKey",serverAddress];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:searchKey forKey:@"searchkey"];
    
    
    NSData * data = [[param JSONRepresentation]  dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    [postbody appendData:data];
    
    [request setPostBody:postbody ];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) loadData{
    
    
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/depts?deptId=2",serverAddress];
    
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
    
    NSMutableArray *rspBody = [result objectForKey:@"rspBody"];
    
    dataArray = rspBody;// [rspBody objectForKey:@"todoList"];
    
    //    rspBody
    
    [self.mTableView reloadData];
    
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    
    NSLog(@"服务器连接不上！");
    
}

-(void)loadData2:(NSString * )deptId{
    
    
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/depts?deptId=%@",serverAddress,deptId];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
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
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableArray *rspBody = [result objectForKey:@"rspBody"];
    
    dataUserArray = rspBody;// [rspBody objectForKey:@"todoList"];
    
    [self.mTableView reloadData];
    
    
    
}

- (void) GetErr2:(ASIHTTPRequest *)request{
 
    NSLog(@"服务器连接不上！");
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(show_dept == false){
        
        return [dataArray count];
    }else{
        
        return [dataUserArray count]+1;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShowDeptCell";
    
    
    int index = indexPath.row;
    
    ShowDeptCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * data;
    
    
    if(show_dept == false){
        data = [dataArray objectAtIndex:indexPath.row];
        
        
        int type = [[data objectForKey:@"endflag"] intValue];
        NSString * name = [data objectForKey:@"name"];

        
        if (type == 0) {
            
            [cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"] forState:UIControlStateNormal];
            cell.itemcheckBtn.hidden=NO;
            cell.itemcheckBtn.tag=indexPath.row;
            [cell.itemcheckBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            cell.checkBtn.hidden = YES;
            cell.backgroundColor = [UIColor whiteColor];
            //[cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_同事"]];
            
            
            
        }
       
        BOOL selected = [self.selectdeptArray containsObject:data];
       [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_文件夹"]];
        if (selected) {
            [cell.itemcheckBtn setImage:[UIImage imageNamed:@"icon_打勾"] forState:UIControlStateNormal];
            
        }else{
            [cell.itemcheckBtn setImage:[UIImage imageNamed:@"icon_未打勾"] forState:UIControlStateNormal];
            
        }
        
        cell.userNameLabel.text = name;
        
        
        
    }else{
        if (index == 0) {
            [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_文件夹"]];
            [cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"] forState:UIControlStateNormal];
            cell.itemcheckBtn.hidden=YES;
            cell.userNameLabel.text = deptName;
            
        } else {
            
            data = [dataUserArray objectAtIndex:indexPath.row - 1];
            
            
            int type = [[data objectForKey:@"endflag"] intValue];
            NSString * name = [data objectForKey:@"name"];
            //    NSString *
            
            if (type == 0) {
                
                [cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"] forState:UIControlStateNormal];
                cell.itemcheckBtn.hidden=NO;
                cell.itemcheckBtn.tag=indexPath.row;
                [cell.itemcheckBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
            }else{
                
                cell.checkBtn.hidden = YES;
                cell.backgroundColor = [UIColor whiteColor];
                
                
            }
            BOOL selected = [self.selectdeptArray containsObject:data];
           [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_文件夹"]];
            if (selected) {
                [cell.itemcheckBtn setImage:[UIImage imageNamed:@"icon_打勾"] forState:UIControlStateNormal];
                
            }else{
                [cell.itemcheckBtn setImage:[UIImage imageNamed:@"icon_未打勾"] forState:UIControlStateNormal];
                
            }

            [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_文件夹"]];
            cell.userNameLabel.text = name;
            
            
            
        }
        
        
    }
    
    
    
    
    
    return cell;
}
-(void)itemClick:(UIButton*)sender{
    
    UIButton *buttonItem=sender;
    NSDictionary * data = [dataArray objectAtIndex:buttonItem.tag];
    
    BOOL selected = [self.selectdeptArray containsObject:data];
    if (selected) {
       [buttonItem setImage:[UIImage imageNamed:@"icon_未打勾"] forState:UIControlStateNormal];
         [self.selectdeptArray removeObject:data];
    }else{
         [buttonItem setImage:[UIImage imageNamed:@"icon_打勾"] forState:UIControlStateNormal];
         [self.selectdeptArray addObject:data];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(show_dept == false){
        
        NSDictionary * data = [dataArray objectAtIndex:indexPath.row];
       int type = [[data objectForKey:@"endflag"] intValue];
        if (type  == 0) {
            show_dept = true;
            //展开
            deptName = [data objectForKey:@"name"];
            
            NSString * deptId = [NSString stringWithFormat:@"%@",[data objectForKey:@"id"]];
            
            [self loadData2:deptId];
            
        }else{
            //选人
            
            BOOL selected = [self.selectdeptArray containsObject:data];
            
            if (selected) {
                [self.selectdeptArray removeObject:data];
            }else{
                [self.selectdeptArray addObject:data];
            }
            
            [self.mTableView reloadData];
            
        }
        
        
        
    }else{
        int row = indexPath.row;
        if (row == 0) {
            //闭合
            
            show_dept = false;
            
            [self.mTableView reloadData];
            
        } else {
            //选人
            
            
            NSDictionary * data = [dataUserArray objectAtIndex:indexPath.row-1];
            int type = [[data objectForKey:@"endflag"] intValue];
            if(type==0){
                deptName = [data objectForKey:@"name"];
                
                NSString * deptId = [NSString stringWithFormat:@"%@",[data objectForKey:@"id"]];
                
                [self loadData2:deptId];
                
                
            }
            else{
                BOOL selected = [self.selectdeptArray containsObject:data];
                
                if (selected) {
                    [self.selectdeptArray removeObject:data];
                }else{
                    [self.selectdeptArray addObject:data];
                }
            }
            
            [self.mTableView reloadData];
            
            
            
        }
    }
}

@end
