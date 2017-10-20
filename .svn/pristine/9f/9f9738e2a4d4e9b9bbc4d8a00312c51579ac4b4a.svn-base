//
//  DocexSignViewController.m
//  hongdabaopo
//
//  Created by admin on 14-8-2.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexSignViewController.h"

@interface DocexSignViewController ()
{
    int  del_user;
}

@end

@implementation DocexSignViewController

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
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    selectUserArray = [[NSMutableArray alloc]init];
    
    NSString * notif_send_work_flow_user = @"notif_send_work_flow_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:notif_send_work_flow_user object:nil];
}



#pragma mark - 上传照片事件

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
        
        //        cell.view1.backgroundColor = [UIColor redColor];
        cell.lb1.hidden = NO;
        cell.btn1.tag = index*3;
        
        [cell.btn1 addTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(index*3 == count){
        [cell.btn1 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn1 addTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        
        
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
        //        cell.view2.backgroundColor = [UIColor blueColor];
        [cell.btn2 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn2 addTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        
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
        //        cell.view3.backgroundColor = [UIColor blueColor];
        [cell.btn3 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn3 addTarget:self action:@selector(photoWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        cell.view3.hidden = YES;
    }
    
    return cell;
    
}

-(void) reloadMonitorTable:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_user_array"];
    
    selectUserArray = data;
    
    [self.photoWallTableView reloadData];
    
}


- (void)photoWallAddAction
{
    
    ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    
    vc.noti_name = @"notif_send_work_flow_user";
    vc.selectUserArray = selectUserArray;
    
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    
}


- (void)photoWallDelAction:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    del_user = btn.tag;
    
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"是否移除用户" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:@"移除" otherButtonTitles:nil,nil];
    
    
    sheet.tag = 1000;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    
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

- (IBAction)returnBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^(void){}];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendSign:(id)sender {
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    NSString *detailId=[self.docexData objectForKey:@"id"];
    NSString *stepId=[self.docexData objectForKey:@"stepId"];
    NSString *signuserid=nil;
    if([selectUserArray count]>0){
        signuserid=[[selectUserArray objectAtIndex:0] objectForKey:@"id"];
        if([selectUserArray count]>1){
            for(int i=1;i<[selectUserArray count];i++){
                NSString *userid=[[selectUserArray objectAtIndex:i] objectForKey:@"id"];
                signuserid=[NSString stringWithFormat:@"%@,%@",signuserid,userid];
            }

        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"请选择加签人员"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:nil,nil];
        [alert show];
        
        return;

    }
    
    

    
    if ([[self.docexData objectForKey:@"titleTag"] intValue] == 1) {
        urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/docexsign?detailId=%@&stepId=%@&from=inbox&signuserid=%@&caretory=inbox",serverAddress,detailId,stepId,signuserid];
    }else if ([[self.docexData objectForKey:@"titleTag"] intValue] == 2){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/docexsign?detailId=%@&stepId=%@&from=outbox&signuserid=%@&caretory=pass",serverAddress,detailId,stepId,signuserid];

    }else if([[self.docexData objectForKey:@"titleTag"] intValue] == 3){
        urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/docexsign?detailId=%@&stepId=%@&from=outbox&signuserid=%@&caretory=draft",serverAddress,detailId,stepId,signuserid];
    }
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
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
}
- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    OALog(@"aStr=%@",aStr);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:aStr
                          message:nil
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定",nil];
    [alert show];
    alert.tag = 100;
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}
    


- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    
    NSLog(@"服务器连接不上！");
    
}

@end
