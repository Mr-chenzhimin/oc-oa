//
//  CreateMessageViewController.m
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "CreateMessageViewController.h"
#import "MessageViewController.h"
#import "MessageDetailViewController.h"

@interface CreateMessageViewController (){
    int  del_user;
}

@end

@implementation CreateMessageViewController

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
	// Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"index_background.png"]];
//    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    
    self.reviewText.text = self.review;
    
    selectUserArray = [[NSMutableArray alloc]init];
   

    NSString * CreateKind = [Utils getCacheForKey:@"CreateKind"];
    if ([CreateKind isEqualToString:@"2"]) {
        NSString * publishID = [Utils getCacheForKey:@"publishID"];
        NSString * publishName = [Utils getCacheForKey:@"publishName"];
        
        NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
        [data setObject:publishID forKey:@"id"];
        [data setObject:publishName forKey:@"name"];
        
        [selectUserArray addObject:data];
    }else if([CreateKind isEqualToString:@"3"]){
        self.myTitleLabel.text = @"转发消息";
        self.reviewText.text =[Utils getCacheForKey:@"zhuanfa_msg"];
        
    }
    
    
    NSString * receive_message_user = @"receive_message_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:receive_message_user object:nil];
    [self.messagecheck setImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
    self.messagecheck.tag = 0;

}


- (void) GetAttachmentErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"加载失败"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)returnBtnClick:(id)sender{
    [self.reviewText resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void) reloadMonitorTable:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_user_array"];
    
    selectUserArray = data;
    
    [self.photoWallTableView reloadData];
    
    
}



-(void) viewDidAppear:(BOOL)animated{
    
    
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


#pragma mark -


- (void)photoWallAddAction
{
    
    ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    
    vc.noti_name = @"receive_message_user";
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

-(IBAction)sendBtnClick:(id) sender
{
    [self.reviewText resignFirstResponder];
    
    int count = [selectUserArray count];
    NSLog(@"=======>count:%d",count);
    
    //内容
    NSString * context = self.reviewText.text;
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    if ( [[context stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:nil] || [[context stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:nil
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"请输入消息内容",nil];
        [alert show];
        return ;
    }
    
    if (count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:nil
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"请选择接收人",nil];
        [alert show];
        return ;
    }
    if(self.messagecheck.tag==0){
        issms=@"0";
    }else{
        issms=@"1";
    }
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/message/saveMessage",serverAddress];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    
    NSMutableData * postbody = [[NSMutableData alloc] init];
    
    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //{"context":"sdfsadf","recevies":[{"1","2"}]}

    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:context forKey:@"context"];
//    [params setObject:_inboxId forKey:@"fromId"];
    
    //只有回复与转发时才有fromId
    if(self.typecode != nil){
        if([self.typecode isEqualToString:@"1"] || [self.typecode isEqualToString:@"2"]){
            [params setObject:_inboxId forKey:@"fromId"];
//            [params setObject:self.typecode forKey:@"typecode"];
        }
        
    }
    NSMutableDictionary * users = [[NSMutableDictionary alloc] init];
    [params setObject:issms forKey:@"sms"];
    
    for (NSDictionary * data in selectUserArray) {
        //int userid = [data objectForKey:@"id"];
        [users setObject:[data objectForKey:@"id"] forKey:[NSString stringWithFormat:@"%d",[[data objectForKey:@"id"] intValue]]];
    }
    
    [params setObject:[users allKeys] forKey:@"receives"];
    
    NSString * message = [params JSONRepresentation];
    
    NSData * data =  [message dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [postbody appendData:data];
    
    [request setPostBody:postbody];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
    
}


- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    int status = [[rspHeader objectForKey:@"code"] integerValue];
    NSString * msg = [rspHeader objectForKey:@"msg"];
    
    if (status == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:msg
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 100;
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:msg
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:nil,nil];
        [alert show];

    }
    
}


- (void) GetErr:(ASIHTTPRequest *)request{
    
    
    NSLog(@"%@", [request error]);
    NSLog(@"服务器连接不上！");
   [SVProgressHUD dismissWithError:@"加载失败"];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(IBAction)backgroundClick:(id)sender{
    [self.reviewText resignFirstResponder];
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

- (IBAction)messagecheckBox:(id)sender {
    if(self.messagecheck.tag == 1){
        [self.messagecheck setImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
        self.messagecheck.tag = 0;
        
        
    }else{
        [self.messagecheck setImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
        self.messagecheck.tag = 1;
        
    }

}
@end
