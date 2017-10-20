//
//  SendNewFileViewController.m
//  OA
//
//  Created by admin on 14-5-30.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "SendNewFileViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"
#import "ShowUserViewController.h"



@interface SendNewFileViewController (){
    int  del_user;
     NSMutableDictionary * selectDeptDic;
}

@end

@implementation SendNewFileViewController

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
     stepTypeId = 0;
     selectUserArray = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"index_background.png"]];
    self.topmenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    selectUserArray = [[NSMutableArray alloc]init];
    
    
    NSString * notif_send_work_flow_user = @"notif_send_work_flow_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:notif_send_work_flow_user object:nil];
    
    self.photoWallTableView.dataSource=self;
    self.photoWallTableView.delegate=self;
    
    [self loaddata];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void)tapAction{
    [self.leaveword resignFirstResponder];
}

-(void)loaddata{
    if(self.inboxId == nil){
        self.inboxId = @"";
    }

    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    //getSelfStep
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/getNextStep?boxId=%@",serverAddress,self.inboxId];
    
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
    
    
    if([rspBody count]>0  ){
        
        selectDeptDic = [rspBody objectAtIndex:0];
        
        stepId = [[selectDeptDic objectForKey:@"stepId"] intValue];
        
        stepTypeId = [[selectDeptDic objectForKey:@"stepTypeId"] intValue];
        
        iscanChoose=[selectDeptDic objectForKey:@"isCanChoose"];
        
        if([selectDeptDic objectForKey:@"stepUserVOs"] >0){
            selectUserArray = [selectDeptDic objectForKey:@"stepUserVOs"];
            [self.photoWallTableView reloadData];
        }
        
    }
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    
}

- (IBAction)btnSend:(id)sender {
    
    [self.leaveword resignFirstResponder];
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    
    NSMutableDictionary * reqHeader = [[NSMutableDictionary alloc]init];
    [reqHeader setObject:self.inboxId forKey:@"boxId"];
    
    NSMutableDictionary * reqBody = [[NSMutableDictionary alloc]init];
    NSString * leaveword = self.leaveword.text;
    if(leaveword == nil){
        leaveword = @"";
    }
    
    [reqBody setObject:leaveword forKey:@"leaveword"];
    
    NSMutableArray * fileSentStepVOs = [[NSMutableArray alloc] init];
    
    
    NSMutableDictionary * fileSentStepVo = [[NSMutableDictionary alloc] init];
    NSString *stepId1=[NSString stringWithFormat:@"%d",stepId];
    [fileSentStepVo setObject:stepId1  forKey:@"stepId"];
    
    NSMutableArray * users = [[NSMutableArray alloc] init];
    
    
    
    for (NSDictionary  *user in selectUserArray) {
        [users  addObject:[user objectForKey:@"id"]];
    }
    
    if ([users count]<=0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"请选择下一步处理人"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:nil,nil];
        [alert show];
        
        return;
    }
    
    [fileSentStepVo setObject:users forKey:@"userIds"];
    
    [fileSentStepVOs addObject:fileSentStepVo];
    
    [reqBody setObject:fileSentStepVOs forKey:@"fileSentStepVOs"];
    
    
    [params setObject:reqHeader forKey:@"reqHeader"];
    
    [params setObject:reqBody forKey:@"reqBody"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/sent?boxId=%@",serverAddress,self.inboxId];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSString * message = [params JSONRepresentation];
    
    NSData * data =  [message dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    
    
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
    
    
    int code = [[rspHeader objectForKey:@"code"] integerValue];
    if(code == 0){
        NSString * msg = [rspHeader objectForKey:@"msg"];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:msg
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil,nil];
        [alert show];
        alert.tag = 100;
        
        
    }else{
        NSString * msg = [rspHeader objectForKey:@"msg"];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:msg
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:nil,nil];
        [alert show];
        return ;
    }
    
    
}

- (void) GetErr2:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        [self dismissViewControllerAnimated:YES completion:^(void){
            NSString * notif_name = @"notif_workflow_poproot";
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:notif_name object:nil userInfo:nil];
            
        }];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (([selectUserArray count]+1)%3 == 0) {
        return  ([selectUserArray count]+1)/3;
    } else {
        return ([selectUserArray count]+1)/3 + 1;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell = @"SendWorkFlowUserCell";
    
    SendWorkFlowUserCell *cell = (SendWorkFlowUserCell *)[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        cell = [[SendWorkFlowUserCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:Cell];
    }
    int count = [selectUserArray count];
    int index = indexPath.row;
    
    cell.view1.hidden = NO;
    cell.view2.hidden = NO;
    cell.view3.hidden = NO;
    
    cell.lb1.hidden = YES;
    cell.lb2.hidden = YES;
    cell.lb3.hidden = YES;
    
    
    [cell.btn1 removeTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 removeTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 removeTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btn1 removeTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 removeTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 removeTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(index*3 < count){
        
        NSMutableDictionary * dataUser =[selectUserArray objectAtIndex:index*3];
        
        cell.lb1.text = [dataUser objectForKey:@"name"];
        
        [cell.btn1 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        
        cell.btn1.hidden=NO;
        cell.lb1.hidden = NO;
        cell.btn1.tag = index*3;
        
        [cell.btn1 addTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(index*3 == count){
        if(iscanChoose==nil||[iscanChoose intValue]==0){
            cell.btn1.hidden = YES;
            
        }else{
           cell.btn1.hidden = NO;
        [cell.btn1 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn1 addTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        
        }
    }else{
        cell.view3.hidden = YES;
    }
    
    if(index*3 + 1 < count){
        NSMutableDictionary * dataUser =[selectUserArray objectAtIndex:index*3+1];
        
        cell.lb2.text = [dataUser objectForKey:@"name"];
        cell.lb2.hidden = NO;
        
        [cell.btn2 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        cell.btn2.tag = index*3 +1;
        
        [cell.btn2 addTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if(index*3 + 1 == count){
        if(iscanChoose==nil||[iscanChoose intValue]==0){
            cell.btn2.hidden = YES;
            
        }else{
        [cell.btn2 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn2 addTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        cell.view2.hidden = YES;
    }
    
    
    if(index*3 +2 < count){
        cell.btn3.tag = index*3 +2;
        
        NSMutableDictionary * dataUser =[selectUserArray objectAtIndex:index*3 +2];
        
        cell.lb3.text = [dataUser objectForKey:@"name"];
        cell.lb3.hidden = NO;
        [cell.btn3 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        
        [cell.btn3 addTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else if(index*3 + 2 == count){
        if(iscanChoose==nil||[iscanChoose intValue]==0){
            cell.btn3.hidden = YES;
            
        }else{
        [cell.btn3 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn3 addTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        
        cell.view3.hidden = YES;
    }
    
    return cell;
    
}

- (void)photoWallDelAction:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    del_user = btn.tag;
    if(iscanChoose==nil||[iscanChoose intValue]==0){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"至少需要一个审批！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil,nil];
        [alert show];
        alert.tag=10000;
        return;
        
    }else{
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"是否移除用户" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:@"移除" otherButtonTitles:nil,nil];
    
    
    sheet.tag = 1000;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    }
}




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int actionSheetTag = actionSheet.tag;
    if(actionSheetTag == 1000){
        if (buttonIndex == 0) {
            [selectUserArray removeObjectAtIndex:del_user];
            [self.photoWallTableView reloadData];
        }
        
    }else{
        
    }
    
}



- (void)photoWallAddAction
{
    
    ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    
    vc.noti_name = @"notif_send_work_flow_user";
    vc.selectUserArray = selectUserArray;
    
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    [self.leaveword resignFirstResponder];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) reloadMonitorTable:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_user_array"];
    
    selectUserArray = data;
    
    [self.photoWallTableView reloadData];
    
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

- (IBAction)btnback:(id)sender {
    [self.leaveword resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}



@end
