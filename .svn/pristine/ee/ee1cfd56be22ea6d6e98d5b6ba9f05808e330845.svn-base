//
//  AttachmentListViewController.m
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "AttachmentListViewController.h"
#import "AttachmentCell.h"
#import "Constant.h"

@interface AttachmentListViewController ()

@end

@implementation AttachmentListViewController

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    if(self.attachType==3||self.attachType ==9){
        
    }else{
        [self loadData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}


-(IBAction)returnBtnClick:(id)sender{
    
        [self.navigationController popViewControllerAnimated:YES];

}



#pragma mark - 列表

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.listData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AttachmentCell";
    
    int index = indexPath.row;
    
    AttachmentCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.backgroundColor  = [UIColor clearColor];
    
    NSDictionary * data = [self.listData objectAtIndex:index];
    if(self.attachType==3){
       cell.subjectLabel.text = [data objectForKey:@"title"];
    }else if (self.attachType ==9){
        cell.subjectLabel.text = [data objectForKey:@"filename"];
        
        int  size = (int)[[data objectForKey:@"filesize"] floatValue]/1024;
        cell.sizeLabel.text = [[NSString alloc] initWithFormat:@"%dkb",(int)size];
        return cell;
    }
    else{
       cell.subjectLabel.text = [data objectForKey:@"name"];
    }
    
    
    int  size = (int)[[data objectForKey:@"size"] floatValue]/1024;
    if(size ==0){
        size = 1;
    }
    cell.sizeLabel.text = [[NSString alloc] initWithFormat:@"%dkb",(int)size];
    NSString * fileImg = [[NSString alloc] initWithFormat:@"%@.png",[data objectForKey:@"ext"]];
    [cell.fileTypeIv setImage:[UIImage imageNamed:fileImg]];

    NSString * fileURL = [data objectForKey:@"fileURL"];
    
    
//    if (self.myTitleLabel.tag == 0) {
//        cell.subjectLabel.text = [data objectForKey:@"fileName"];
//    }else {
//        cell.subjectLabel.text = [data objectForKey:@"title"];
//    }
//    
//    cell.usernameLabel.text = [data objectForKey:@"sender"];
//    cell.timeLabel.text = [data objectForKey:@"sendDate"];
//    
//    int priority = [[data objectForKey:@"priority"] intValue];
//    
//    int attachCount = [[data objectForKey:@"attachCount"] integerValue];
//    int attatchCount = [[data objectForKey:@"attatchCount"] integerValue];
//    
//    if(attatchCount > 0 || attachCount >0){
//        cell.attatchIv.hidden = NO;
//    }else{
//        cell.attatchIv.hidden = YES;
//    }
//    
//    NSString * priorityImage =[NSString stringWithFormat:@"p%d",priority];
//    
//    [cell.priorityIv setImage:[UIImage imageNamed:priorityImage]];
//    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int index = indexPath.row;
    
    NSDictionary * data = [self.listData objectAtIndex:index];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    
    
    NSString * fileURL = [data objectForKey:@"fileURL"];
    NSString * ext = [data objectForKey:@"ext"];
    NSString  *aid = [NSString stringWithFormat:@"%d",[[data objectForKey:@"id"] intValue]];
    
    
    if (self.attachType==9) {
        NSString *filename =[data objectForKey:@"filename"];
        NSArray *arry =[filename componentsSeparatedByString:@"."];
        ext  =[arry objectAtIndex:1];
//        ext = []
    }
    
    
    
//    NSString * path = [NSString stringWithFormat:@"%@%@?tokenId=%@",serverAddress,fileURL,tokenId];
    
    NSString * path = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/getAttachFile?id=%@",serverAddress,aid];
    
    if(self.attachType == 0){
        //工作流
        path = [NSString stringWithFormat:@"%@/mobile/workflowModule/attachs/%@",serverAddress,aid];
        
    }else if(self.attachType == 1){
        //消息
        path = [NSString stringWithFormat:@"%@/mobile/message/getAttachFile?aid=%@",serverAddress,aid];
    }else if(self.attachType == 2){
        //公告附件
        path = [NSString stringWithFormat:@"%@/mobile/bulletins/getAttachFile?aid=%@",serverAddress,aid];
        
    }else if (self.attachType == 9){//会议附件
        
        path = [NSString stringWithFormat:@"http://oa.com/mobile/meetings/attachment_download?fid=%@",aid];
    }
    
    AttachmentViewController * attVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AttachmentViewController"];
    attVc.ext = ext;
    attVc.path = path;
    attVc.token = tokenId;
    attVc.fileId = aid;
    
    [self presentViewController:attVc animated:YES completion:^(void){}];
    
    
}

-(void) loadData{

    //mobile/workflowModule /attachs?fid=xx&s=0&c=12

    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    int fid = self.fileID.integerValue;
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/attachs?fid=%@&s=%d&c=%d",serverAddress,self.fileID,KEY_READ_LINE,KEY_RETURN_COUNT];
    
    if(self.attachType == 1){
        //消息附件
        urlAddress = [NSString stringWithFormat:@"%@/mobile/message/findAttachs?msgId=%@&s=%d&c=%d",serverAddress,self.fileID,KEY_READ_LINE,KEY_RETURN_COUNT];
        
    }else if (self.attachType == 2) {
        //公告附件
        //mobile/bulletins/findAttachs?bulletinsId={bulletinsId}&s=0&c=12
        urlAddress = [NSString stringWithFormat:@"%@/mobile/bulletins/findAttachs?bulletinsId=%@&s=%d&c=%d",serverAddress,self.fileID,KEY_READ_LINE,KEY_RETURN_COUNT];
        
    }
//    else if (self.attachType ==9){
//        
//        urlAddress = [NSString stringWithFormat:@"http://oa.com/mobile/meetings/attachment_download?fid=%d",fid];
//    
//    }
    
    NSLog(@"urlAddress=%@",urlAddress);
    
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
    
    NSString * aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    int code = [[rspHeader objectForKey:@"code"] intValue];
    NSString * msg = [rspHeader objectForKey:@"msg"];
    
    if(code != 0){
        [SVProgressHUD dismissWithError:msg afterDelay:2];
        
    }else{
        self.listData = [result objectForKey:@"rspBody"];
        
        [self.dataTableView reloadData];
    }
    
}


- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    
     NSLog(@"%@", [request error]);
    
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
