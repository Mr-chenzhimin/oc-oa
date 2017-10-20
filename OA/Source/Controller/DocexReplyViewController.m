//
//  DocexReplyViewController.m
//  hongdabaopo
//
//  Created by admin on 14-8-2.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexReplyViewController.h"
#import "Utils.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

#import "DocexFileUpdataViewController.h"



@interface DocexReplyViewController ()

@end


@implementation DocexReplyViewController
//@synthesize loginBtn = _loginBtn;

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
    NSString * notif_send_work_flow_user = @"notif_docex_updatafile_select";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:notif_send_work_flow_user object:nil];
    
    
   // [self loadData];
}
-(void) reloadMonitorTable:(NSNotification * )notiData{
    NSDictionary * dataDic = notiData.userInfo;
    
    NSString * data = [dataDic objectForKey:@"filename"];
    
    NSString * docexfilename = data;
    self.FileName.text=docexfilename;    
}


-(void)loadData{
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString * username=[Utils getCacheForKey:@"userName"];
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/findUsersByKey?key=%@",serverAddress,username];
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:username forKey:@"searchkey"];
    
    
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
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableArray *rspBody = [result objectForKey:@"rspBody"];
    
    dataArray = rspBody;// [rspBody objectForKey:@"todoList"];
    
    //    rspBody
    
    
    
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)returnbtnclick:(id)sender {
    
    [self.replytext resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)backgroundClick:(id)sender{
    [self.replytext resignFirstResponder];
}

- (IBAction)finishbtn:(id)sender {
    [self.replytext resignFirstResponder];
    NSString * context = self.replytext.text;
    if([context isEqualToString:@""]||context==nil){
        //提示不能为空
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:nil
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"请输入回复内容",nil];
        [alert show];
        return ;

    }
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/saveOption",serverAddress];
    urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    NSString *userId = [Utils getCacheForKey:@"userId"];
    [param setObject:self.Replyid forKey:@"detailId"];
    [param setObject: userId  forKey:@"uid"];
    [param setObject:@"0" forKey:@"isReply"];
    [param setObject:context forKey:@"content"];
    
    
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
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableArray *rspBody = [result objectForKey:@"rspBody"];
    
    optiondata = rspBody;
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"意见保存成功!"
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


- (IBAction)FileBtnUpdata:(id)sender {
    
    DocexFileUpdataViewController * docexreply = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexFileUpdataViewController"];
    docexreply.noti_name = @"notif_docex_updatafile_select";
    [self.navigationController pushViewController:docexreply animated:YES  ];
    
    
}
@end
