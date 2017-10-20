//
//  DocexSentViewController.m
//  OA
//
//  Created by admin on 15-3-20.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import "DocexSentViewController.h"
#import "SendWorkFlowUserCell.h"
#import "ShowUserViewController.h"
#import "ShowDeptViewController.h"
#import "SendDeptCell.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>


@interface DocexSentViewController ()
{
    int  del_user;
    int  del_dept;
}

@end

@implementation DocexSentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectUserArray = [[NSMutableArray alloc]init];
    selectDeptArray= [[NSMutableArray alloc]init];
    
    NSString * notif_send_docexfile_user = @"notif_send_docexfile_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:notif_send_docexfile_user object:nil];
    NSString * notif_send_docexfile_dept = @"notif_send_docexfile_dept";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable1:) name:notif_send_docexfile_dept object:nil];
}
-(void) reloadMonitorTable:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_user_array"];
    
    selectUserArray = data;
    
    [self.userTableView reloadData];
    
}

-(void) reloadMonitorTable1:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_dept_array"];
    
    selectDeptArray = data;
    
    [self.deptTableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.userTableView){
    if (([selectUserArray count]+1)%3 == 0) {
        return  ([selectUserArray count]+1)/3;
    } else {
        return ([selectUserArray count]+1)/3 + 1;
    }
    }else{
        if (([selectDeptArray count]+1)%3 == 0) {
            return  ([selectDeptArray count]+1)/3;
        } else {
            return ([selectDeptArray count]+1)/3 + 1;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(tableView==self.userTableView){
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
    
    
    [cell.btn1 removeTarget:self action:@selector(photouserWallAddAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 removeTarget:self action:@selector(photouserWallAddAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 removeTarget:self action:@selector(photouserWallAddAction) forControlEvents:UIControlEventTouchUpInside];
    
       [cell.btn1 removeTarget:self action:@selector(photouserWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn2 removeTarget:self action:@selector(photouserWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn3 removeTarget:self action:@selector(photouserWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(index*3 < count){
        
        NSMutableDictionary * dataUser =[selectUserArray objectAtIndex:index*3];
        
        cell.lb1.text = [dataUser objectForKey:@"name"];
        
        [cell.btn1 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        
        //        cell.view1.backgroundColor = [UIColor redColor];
        cell.lb1.hidden = NO;
        cell.btn1.tag = index*3;
        
        [cell.btn1 addTarget:self action:@selector(photouserWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(index*3 == count){
        [cell.btn1 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn1 addTarget:self action:@selector(photouserWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else{
        cell.view3.hidden = YES;
    }
    
    if(index*3 + 1 < count){
        NSMutableDictionary * dataUser =[selectUserArray objectAtIndex:index*3+1];
        
        cell.lb2.text = [dataUser objectForKey:@"name"];
        cell.lb2.hidden = NO;
        
        [cell.btn2 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        cell.btn2.tag = index*3 +1;
        
        [cell.btn2 addTarget:self action:@selector(photouserWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if(index*3 + 1 == count){
        //        cell.view2.backgroundColor = [UIColor blueColor];
        [cell.btn2 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn2 addTarget:self action:@selector(photouserWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        cell.view2.hidden = YES;
    }
    
    
    if(index*3 +2 < count){
        cell.btn3.tag = index*3 +2;
        
        NSMutableDictionary * dataUser =[selectUserArray objectAtIndex:index*3 +2];
        
        cell.lb3.text = [dataUser objectForKey:@"name"];
        cell.lb3.hidden = NO;
        [cell.btn3 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        
        [cell.btn3 addTarget:self action:@selector(photouserWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else if(index*3 + 2 == count){
        //        cell.view3.backgroundColor = [UIColor blueColor];
        [cell.btn3 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
        
        [cell.btn3 addTarget:self action:@selector(photouserWallAddAction) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        cell.view3.hidden = YES;
    }
       return cell;
       
       
       
   }else{
       static NSString *Cell = @"SendDeptCell";
       
       SendDeptCell *cell = (SendDeptCell *)[tableView dequeueReusableCellWithIdentifier:Cell];
       if (cell == nil) {
           cell = [[SendDeptCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:Cell];
       }
       int count = [selectDeptArray count];
       int index = indexPath.row;
       
       cell.view1.hidden = NO;
       cell.view2.hidden = NO;
       cell.view3.hidden = NO;
       
       cell.lb1.hidden = YES;
       cell.lb2.hidden = YES;
       cell.lb3.hidden = YES;
       
       
       [cell.btn1 removeTarget:self action:@selector(photodeptWallAddAction) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn2 removeTarget:self action:@selector(photodeptWallAddAction) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn3 removeTarget:self action:@selector(photodeptWallAddAction) forControlEvents:UIControlEventTouchUpInside];
       
       [cell.btn1 removeTarget:self action:@selector(photodeptWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn2 removeTarget:self action:@selector(photodeptWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn3 removeTarget:self action:@selector(photodeptWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
       
       
       if(index*3 < count){
           
           NSMutableDictionary * dataUser =[selectDeptArray objectAtIndex:index*3];
           
           cell.lb1.text = [dataUser objectForKey:@"name"];
           
           [cell.btn1 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
           
           //        cell.view1.backgroundColor = [UIColor redColor];
           cell.lb1.hidden = NO;
           cell.btn1.tag = index*3;
           
           [cell.btn1 addTarget:self action:@selector(photodeptWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
           
       }else if(index*3 == count){
           [cell.btn1 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
           
           [cell.btn1 addTarget:self action:@selector(photodeptWallAddAction) forControlEvents:UIControlEventTouchUpInside];
           
           
       }else{
           cell.view3.hidden = YES;
       }
       
       if(index*3 + 1 < count){
           NSMutableDictionary * dataUser =[selectDeptArray objectAtIndex:index*3+1];
           
           cell.lb2.text = [dataUser objectForKey:@"name"];
           cell.lb2.hidden = NO;
           
           [cell.btn2 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
           cell.btn2.tag = index*3 +1;
           
           [cell.btn2 addTarget:self action:@selector(photodeptWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
       }else if(index*3 + 1 == count){
           //        cell.view2.backgroundColor = [UIColor blueColor];
           [cell.btn2 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
           
           [cell.btn2 addTarget:self action:@selector(photodeptWallAddAction) forControlEvents:UIControlEventTouchUpInside];
           
       }else{
           cell.view2.hidden = YES;
       }
       
       
       if(index*3 +2 < count){
           cell.btn3.tag = index*3 +2;
           
           NSMutableDictionary * dataUser =[selectDeptArray objectAtIndex:index*3 +2];
           
           cell.lb3.text = [dataUser objectForKey:@"name"];
           cell.lb3.hidden = NO;
           [cell.btn3 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
           
           [cell.btn3 addTarget:self action:@selector(photodeptWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
           
           
       }else if(index*3 + 2 == count){
           //        cell.view3.backgroundColor = [UIColor blueColor];
           [cell.btn3 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
           
           [cell.btn3 addTarget:self action:@selector(photodeptWallAddAction) forControlEvents:UIControlEventTouchUpInside];
           
       }else{
           
           cell.view3.hidden = YES;
       }
       return cell;
   }
    
    return nil;
    
}
- (void)photouserWallAddAction
{
    
    ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    
    vc.noti_name = @"notif_send_docexfile_user";
    vc.selectUserArray = selectUserArray;
    
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    
}
- (void)photodeptWallAddAction
{
    
    ShowDeptViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowDeptViewController"];
    
    vc.noti_name = @"notif_send_docexfile_dept";
    vc.selectdeptArray = selectDeptArray;
    
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    
}
- (void)photouserWallDelAction:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    del_user = btn.tag;
    
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"是否移除用户" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:@"移除" otherButtonTitles:nil,nil];
    
    
    sheet.tag = 1000;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    
}
- (void)photodeptWallDelAction:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    del_dept = btn.tag;
    
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"是否移除部门" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:@"移除" otherButtonTitles:nil,nil];
    
    
    sheet.tag = 10000;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int actionSheetTag = actionSheet.tag;
    if(actionSheetTag == 1000){
        if (buttonIndex == 0) {
            [selectUserArray removeObjectAtIndex:del_user];
            [self.userTableView reloadData];
        }
        
    }else{
        if (buttonIndex == 0) {
            [selectDeptArray removeObjectAtIndex:del_dept];
            [self.deptTableView reloadData];
        }

        
    }
    
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
     image = [info objectForKey:UIImagePickerControllerOriginalImage];
    ALAssetsLibrary* alLibrary = [[ALAssetsLibrary alloc] init];
    __block float fileMB  = 0.0;
    int perMBBytes = 1024;
    [alLibrary assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset)
     {
         ALAssetRepresentation *representation = [asset defaultRepresentation];
         NSString *filename=[representation filename];
         self.filenametxt.text=filename;
         filesize = (float)([representation size]/perMBBytes);
         NSLog(@"size of asset in bytes: %0.2f", fileMB);
        
     } failureBlock:^(NSError *error) {
         NSLog(@"Failure, wahhh!");
     }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (IBAction)checkfile:(id)sender {
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}
-(void)imagetobase64{
    
    NSData *_data = UIImageJPEGRepresentation(image, 1.0f);
    
    filecontent = [_data base64Encoding];
    
    NSLog(@"===Encoded image:\n%@", filecontent);
}

- (IBAction)docexsent:(id)sender {
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    
    NSMutableDictionary * reqHeader = [[NSMutableDictionary alloc]init];
    [reqHeader setObject:@"0" forKey:@"boxId"];
    
   NSMutableDictionary * reqBody = [[NSMutableDictionary alloc]init];
    
    NSMutableArray * docexFileList = [[NSMutableArray alloc] init];
    
    NSMutableDictionary * DocexfileVO = [[NSMutableDictionary alloc] init];
    [DocexfileVO setObject:self.docex_title forKey:@"title"];
    [DocexfileVO setObject:self.share forKey:@"isShare"];
    [DocexfileVO setObject:self.additional forKey:@"additional"];
    [DocexfileVO setObject:self.conrem forKey:@"isConcerm"];
    [DocexfileVO setObject:self.docex_context forKey:@"content"];
    [DocexfileVO setObject:@"F" forKey:@"isFree"];
    [DocexfileVO setObject:@"1"forKey:@"fileType"];
    
    NSMutableArray * users = [[NSMutableArray alloc] init];
    for (NSDictionary  *user in selectUserArray) {
        [users  addObject:[user objectForKey:@"id"]];
    }
    
    
    NSMutableArray * depts = [[NSMutableArray alloc] init];
    for (NSDictionary  *dept in selectDeptArray) {
        [depts  addObject:[dept objectForKey:@"id"]];
    }
    
  
    if ([users count]<=0 && [depts count]<=0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"必须选择一个接收对象！"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:nil,nil];
        [alert show];
        
        return;
    }
    [DocexfileVO setObject:users forKey:@"users"];
    [DocexfileVO setObject:depts forKey:@"depts"];
    [docexFileList addObject:DocexfileVO];
    NSMutableArray * docexFileAttachSaveVOs = [[NSMutableArray alloc] init];

    NSMutableDictionary * DocexFileAttachSaveVO = [[NSMutableDictionary alloc] init];
    [DocexFileAttachSaveVO setObject:@"0" forKey:@"fileId"];
    [DocexFileAttachSaveVO setObject:@"0" forKey:@"userID"];
    [DocexFileAttachSaveVO setObject:@"0" forKey:@"id"];
    
    NSString * filelength= [NSString stringWithFormat:@"%d",(int)filesize];
    
    [DocexFileAttachSaveVO setObject:filelength forKey:@"attachSize"];
    
    [DocexFileAttachSaveVO setObject:self.filenametxt.text forKey:@"attachTitle"];
    [DocexFileAttachSaveVO setObject:@"JPG" forKey:@"attachExt"];
    [DocexFileAttachSaveVO setObject:@"JPG" forKey:@"attachSuffix"];
    [self imagetobase64];

   NSString *filecontent1 = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                               (CFStringRef)filecontent,
                                                                               NULL,
                                                                               CFSTR(":/?#[]@!$&’()*+,;="),
                                                                               kCFStringEncodingUTF8);
    
    
    if(filecontent1==nil){
        filecontent1=@"";
    }
    [DocexFileAttachSaveVO setObject:filecontent1 forKey:@"attachContent"];
    
   
    [reqBody setObject:docexFileList forKey:@"docexFileList"];

    [docexFileAttachSaveVOs addObject:DocexFileAttachSaveVO];
    [reqBody setObject:docexFileAttachSaveVOs forKey:@"docexFileAttachSaveVOs"];
    
    [params setObject:reqHeader forKey:@"reqHeader"];
    
    [params setObject:reqBody forKey:@"reqBody"];

    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    urlAddress = [NSString stringWithFormat:@"%@/mobile/docexModule/docexdetail/NewDocex",serverAddress];
    
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
    
    NSString * msg = [rspHeader objectForKey:@"msg"];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:msg
                          message:nil
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定",nil];
    [alert show];
    alert.tag = 100;
   
    
    
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    
    
    NSLog(@"服务器连接不上！");
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}

- (IBAction)returnback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
