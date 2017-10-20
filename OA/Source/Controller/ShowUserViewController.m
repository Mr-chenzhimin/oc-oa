//
//  ShowUserViewController.m
//  OA
//
//  Created by APPLE on 13-12-22.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "ShowUserViewController.h"

@interface ShowUserViewController (){
    NSString * deptName;
    
}

@end

@implementation ShowUserViewController

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
  //  self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"index_background.png"]];
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
   
    if(self.selectUserArray == nil){
        self.selectUserArray = [[NSMutableArray alloc] init];
        
    }
    rememberstep = [[NSMutableArray alloc] init];
    NSMutableDictionary * fileSentStepVo = [[NSMutableDictionary alloc] init];
    [fileSentStepVo setObject:@"2" forKey:@"deptId"];
    [fileSentStepVo setObject:@"选人" forKey:@"deptName"];
    [rememberstep addObject:fileSentStepVo];
    
    [self loadData];
    
    show_user = false;
    
}



-(IBAction) selectUserOkBtnClick:(id)sender{
    
    NSDictionary *respData= [NSDictionary dictionaryWithObject:self.selectUserArray
                                                  forKey:@"select_user_array"];
    NSString * notif_name = self.noti_name;
    NSLog(@"notif_name==%@", notif_name);
    if([notif_name isEqualToString: @"notif_create_hoster_user"]||[notif_name isEqualToString: @"notif_create_summary_user"]){
        NSMutableArray * data = [respData objectForKey:@"select_user_array"];
        NSLog(@"respData.count=%d", [data count]);
        if (data.count > 1) {
            NSString * msg = @"请只选择一个用户！";
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:msg
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil,nil];
            [alert show];
            return ;
        }
    }
    
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:respData];

    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
    
}



-(IBAction)searchBtnClick:(id)sender{
    
    show_user = false;
    
    NSString * searchKey = self.searchUserField.text;
    if (searchKey == Nil) {
        
        [self loadData];
        
        return;
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/findUsersByKey",serverAddress];
    
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

-(void) loadData{
    
    
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/deptNav?deptId=2",serverAddress];
    if(self.inboxid != nil){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/deptNav?deptId=2&inboxId=%@&stepId=%@",serverAddress,_inboxid,_stepid];

    }
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
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];

}




-(void)loadData2:(NSString * )deptId{
    
    
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/deptNav?deptId=%@",serverAddress,deptId];
    
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
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)returnBtnClick:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
}






#pragma mark - 列表

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(show_user == false){
        
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
    static NSString *CellIdentifier = @"ShowUserCell";
    
    
    int index = indexPath.row;
    
    ShowUserCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * data;
    
    
    if(show_user == false){
        data = [dataArray objectAtIndex:indexPath.row];
        
        NSMutableArray *arry = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in self.selectUserArray) {
            NSString *uid = [[dict objectForKey:@"id"]stringValue];
            [arry addObject:uid];
        }
        NSString *uid =[[data objectForKey:@"id"]stringValue];

        int type = [[data objectForKey:@"type"] integerValue];
        NSString * name = [data objectForKey:@"name"];
        
        
        if (type == 0) {
            [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_文件夹"]];
            [cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"]];
            //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"] forState:UIControlStateNormal];
            
            
        }else{
            [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_同事"]];
            cell.checkBtn.hidden = NO;
            cell.backgroundColor = [UIColor whiteColor];
            
            BOOL select = [arry containsObject:uid];
            BOOL selected = [self.selectUserArray containsObject:data];
            
            if (select) {
                [cell.checkBtn setImage:[UIImage imageNamed:@"icon_打勾"]];
                //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_打勾"] forState:UIControlStateNormal];
                
            }else{
                [cell.checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"]];
                //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"] forState:UIControlStateNormal];
                
            }
            
        }
        
        cell.userNameLabel.text = name;
        
        
        
    }else{
        if (index == 0) {
            [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_文件夹"]];
            [cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"]];
            //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"] forState:UIControlStateNormal];
            
            cell.userNameLabel.text = deptName;
            
        } else {
            
            data = [dataUserArray objectAtIndex:indexPath.row - 1];
            
            NSMutableArray *arry = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in self.selectUserArray) {
                NSString *uid = [[dict objectForKey:@"id"]stringValue];
                [arry addObject:uid];
            }
            NSString *uid =[[data objectForKey:@"id"]stringValue];
            int type = [[data objectForKey:@"type"] integerValue];
            NSString * name = [data objectForKey:@"name"];
            
            
            if (type == 0) {
                [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_文件夹"]];
                //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"] forState:UIControlStateNormal];
                [cell.checkBtn setImage:[UIImage imageNamed:@"icon_向下箭头"]];
                //cell.checkBtn.hidden = YES;
                
            }else{
                [cell.userHeaderImageView setImage:[UIImage imageNamed:@"icon_同事"]];
                cell.checkBtn.hidden = NO;
                cell.backgroundColor = [UIColor whiteColor];
                
                BOOL select = [arry containsObject:uid];
                BOOL selected = [self.selectUserArray containsObject:data];
                
                if (select) {
                    [cell.checkBtn setImage:[UIImage imageNamed:@"icon_打勾"]];
                    //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_打勾"] forState:UIControlStateNormal];
                    
                }else{
                    [cell.checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"]];
                    //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"] forState:UIControlStateNormal];
                    
                }
                
            }
            
            cell.userNameLabel.text = name;
        
            
            
        }
        
       
    }
    
    
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(show_user == false){
        
        NSDictionary * data = [dataArray objectAtIndex:indexPath.row];
        int type = [[data objectForKey:@"type"] integerValue];
        if (type  == 0) {
            show_user = true;
            //展开
            deptName = [data objectForKey:@"name"];
            
            NSString * deptId = [NSString stringWithFormat:@"%@",[data objectForKey:@"id"]];
            
            [self loadData2:deptId];
            
        }else{
           //选人
            NSMutableArray *arry = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in self.selectUserArray) {
                NSString *uid = [[dict objectForKey:@"id"]stringValue];
                [arry addObject:uid];
            }
            NSString *uid =[[data objectForKey:@"id"]stringValue];
            BOOL select = [arry containsObject:uid];
            BOOL selected = [self.selectUserArray containsObject:data];
            
            if (select) {
                [self.selectUserArray removeObject:data];
            }else{
                [self.selectUserArray addObject:data];
            }
            
            [self.mTableView reloadData];
            
        }
        
        
        
    }else{
        int row = indexPath.row;
        if (row == 0) {
            //闭合
            
            show_user = false;
            
            [self.mTableView reloadData];
            
        } else {
            //选人
            
            
            NSDictionary * data = [dataUserArray objectAtIndex:indexPath.row-1];
            int type = [[data objectForKey:@"type"] integerValue];
            if(type==0){
                deptName = [data objectForKey:@"name"];
                
                NSString * deptId = [NSString stringWithFormat:@"%@",[data objectForKey:@"id"]];
                
                [self loadData2:deptId];

                
            }
            else{
                
                    NSMutableArray *arry = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in self.selectUserArray) {
                        NSString *uid = [[dict objectForKey:@"id"]stringValue];
                        [arry addObject:uid];
                    }
                    NSString *uid =[[data objectForKey:@"id"]stringValue];
                    BOOL select = [arry containsObject:uid];
                    BOOL selected = [_selectUserArray containsObject:data];
                    
                    if (select) {
                        [self.selectUserArray removeObject:data];
                    }else{
                        [self.selectUserArray addObject:data];
                    }
                }
                
                [self.mTableView reloadData];
            
            
            
        }
        
    }
    
  
    
//    NSDictionary * data = [dataArray objectAtIndex:indexPath.row];
//    int type = [[data objectForKey:@"type"] integerValue];
//    if (type == 0) {
//        
//    } else {
//        
//    }
    
    
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
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
