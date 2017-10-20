//
//  SendWorkFlowViewController.m
//  OA
//
//  Created by dengfan on 13-12-8.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "SendWorkFlowViewController.h"

@interface SendWorkFlowViewController (){
    NSInteger  del_user;
    NSInteger  flag;
    NSMutableArray * deptArray;
    NSMutableDictionary * iscanArray;
    
    NSMutableDictionary * stepID;
    
    
    NSMutableDictionary * selectDeptDic;
    NSMutableDictionary * deptbodyDic;
    
}

@end

@implementation SendWorkFlowViewController

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
    
    stepTypeId = 0;
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"index_background.png"]];
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    deptbodyDic = [[NSMutableDictionary alloc]init];
   
    self.reviewText.text = self.review;
    

    selectUserArray = [[NSMutableArray alloc]init];
    iscanArray= [[NSMutableDictionary alloc]init];
    stepID= [[NSMutableDictionary alloc]init];
    
    NSString * notif_send_work_flow_user = @"notif_send_work_flow_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMonitorTable:) name:notif_send_work_flow_user object:nil];
    
    
    NSString * notif_select_dept_user = @"notif_select_dept_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDeptNoti:) name:notif_select_dept_user object:nil];
    
    
    [self loadData];
    
     UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    [self.view addGestureRecognizer:tapRecognizer];
    
}


-(void)tapAction{
    [self.reviewText resignFirstResponder];
}




-(void) loadData{
    
    if(self.inboxId == nil){
        self.inboxId = @"";
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    [parameter setObject:[NSString stringWithFormat:@"0"] forKey:@"s"];
    [parameter setObject:[NSString stringWithFormat:@"12"] forKey:@"c"];
    [parameter setObject:[NSString stringWithFormat:@"1"] forKey:@"isAll"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    //getSelfStep
    urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/getNextStep?boxId=%@",serverAddress,self.inboxId];
    
    if(self.workFlowTag == 1){
        //协办
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/getSelfStep?boxId=%@",serverAddress,self.inboxId];
        
    }else if(stepTypeId == 11){
        
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/getNextStep?boxId=%@&stepId=%@",serverAddress,self.inboxId,stepId];
        
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
  
    deptArray = rspBody;
    
    if([rspBody count]>0  ){
        
        selectDeptDic = [rspBody objectAtIndex:0];
    
        stepId = [selectDeptDic objectForKey:@"stepId"] ;
        
        stepTypeId = [[selectDeptDic objectForKey:@"stepTypeId"] intValue];
        
        iscanChoose=[selectDeptDic objectForKey:@"isCanChoose"];
        
        NSString *special = [selectDeptDic objectForKey:@"isSpecial"];
        if(![special isEqual:[NSNull null]]){
            int isSpecial = [special intValue];
            if(isSpecial == 2){
                //liuqj,2015-8-1,处理协办返回
                self.workFlowTag = 2;
            }
        }

        
        [self.selectDeptBtn setTitle:[selectDeptDic objectForKey:@"stepName"] forState:UIControlStateNormal];
        
        [self loadViewStep];
        
    }
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    
}

-(void)loadViewStep{
    
    _scrollview= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 127, 320, 270)];
    _scrollview.tag=10;
    _scrollview.bounces=NO;
    _scrollview.pagingEnabled=YES;
    _scrollview.delegate=self;
    _scrollview.contentOffset=CGPointMake(0, 0);
    _scrollview.contentSize=CGSizeMake([[selectDeptDic objectForKey:@"stepVOs"] count]*320, 270);
    _scrollview.showsHorizontalScrollIndicator=NO;
    _scrollview.showsVerticalScrollIndicator=YES;
    _scrollview.userInteractionEnabled=YES;
    
    int  stepTypeId1 = [[selectDeptDic objectForKey:@"stepTypeId"] intValue];
    if(stepTypeId1==11){
        //清空scrollview的子控件
        for(UIView *view in self.view.subviews){
            if(view.tag==100){
              [view removeFromSuperview];
            }
        }
        
       NSMutableArray * DeptDicbody=[selectDeptDic objectForKey:@"stepVOs"];
        for(int k=0;k<[DeptDicbody count];k++){
            
            NSString *key=[NSString stringWithFormat:@"%d",k];
            NSMutableArray *userVOs=[[DeptDicbody objectAtIndex:k ] objectForKey:@"stepUserVOs"];
            [deptbodyDic setObject:userVOs forKey:key];
             int isCanChoose1=[[[DeptDicbody objectAtIndex:k ] objectForKey:@"isCanChoose"]intValue];
            [iscanArray setValue:[NSString stringWithFormat:@"%d",isCanChoose1] forKey:key];
            int stepid=[[[DeptDicbody objectAtIndex:k ] objectForKey:@"stepId"]intValue];
            [stepID setValue: [NSString stringWithFormat:@"%d",stepid] forKey:key];
       
            int xlength=k*320;
            UIView  *pageview=[[UIView alloc] initWithFrame:CGRectMake(0+xlength,0.0, 320, 270)];
            
            UILabel *stepmainname=[[UILabel alloc] initWithFrame:CGRectMake(2.0, 0, 72, 28)];
            stepmainname.tag=10;
            stepmainname.text=[NSString stringWithFormat:@"[%@]",[selectDeptDic objectForKey:@"stepName"]];
            stepmainname.textAlignment=NSTextAlignmentCenter;
            [pageview addSubview:stepmainname];
            UILabel *stepbodyname=[[UILabel alloc] initWithFrame:CGRectMake(77.0, 0, 190, 28)];
            stepbodyname.tag=10;
            stepbodyname.text=[[DeptDicbody objectAtIndex:k ] objectForKey:@"stepName"] ;
            stepbodyname.textAlignment=NSTextAlignmentCenter;
            [pageview addSubview:stepbodyname];
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(13, 42, 51, 21)];
            label.tag=10;
            label.text=@"处理人" ;
            [pageview addSubview:label];
            UITableView   *photoTable=[[UITableView alloc] initWithFrame:CGRectMake(77.0,34.0, 228.0, 212.0)];
            photoTable.separatorStyle=UITableViewCellSeparatorStyleNone;
            photoTable.tag=k;
            photoTable.delegate=self;
            photoTable.dataSource=self;
            [photoTable reloadData];
            [pageview addSubview:photoTable];
            [_scrollview addSubview:pageview];
            
        }
        self.pagecontroller.hidden=NO;
        self.pagecontroller.numberOfPages=[DeptDicbody count];
        //设置非选中页的圆点颜色
        self.pagecontroller.pageIndicatorTintColor=[UIColor grayColor];
        //设置选中页的圆点颜色
        self.pagecontroller.currentPageIndicatorTintColor=[UIColor whiteColor];
        //禁止默认的点击功能
        self.pagecontroller.enabled=NO;
       // [_scrollview addSubview:self.pagecontroller];
        [self.view addSubview:_scrollview];
    }else{
        for(UIScrollView *view in self.view.subviews){
            if(view.tag==10){
             [view removeFromSuperview];
            }
        }
        
        NSString *key=[NSString stringWithFormat:@"%d",0];
        NSMutableArray *userVOs=[selectDeptDic objectForKey:@"stepUserVOs"];
        [deptbodyDic setObject:userVOs forKey:key];
        
        int isCanChoose1=[[selectDeptDic objectForKey:@"isCanChoose"]intValue];
        if (_workFlowTag ==2) { //协办返回写死不能选人
            isCanChoose1 =0;
        }
        
        [iscanArray setValue:[NSString stringWithFormat:@"%d",isCanChoose1] forKey:key];
        int stepid=[[selectDeptDic objectForKey:@"stepId"]intValue];
        [stepID setValue: [NSString stringWithFormat:@"%d",stepid] forKey:key];
        
        UIView  *pageview=[[UIView alloc] initWithFrame:CGRectMake(0.0,0.0, 320.0, 240.0)];
        pageview.tag=100;
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(13.0, 2.0, 51.0, 21.0)];
        label.tag=10;
        label.text=@"处理人" ;
        [pageview addSubview:label];
        UITableView   *photoTable=[[UITableView alloc] initWithFrame:CGRectMake(77.0,0.0, 228.0, 212.0)];
        photoTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        photoTable.tag=0;
        photoTable.delegate=self;
        photoTable.dataSource=self;
        [photoTable reloadData];
        [pageview addSubview:photoTable];
        [_scrollview addSubview:pageview];
        [self.view addSubview:_scrollview];
        self.pagecontroller.hidden=YES;
        
    }
    
   
    
}

#pragma mark 当scrollView 正在滚动的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page=_scrollview.contentOffset.x/_scrollview.frame.size.width;
    self.pagecontroller.currentPage=page;
    
}

-(void) reloadMonitorTable:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_user_array"];
    
    NSString *key=[NSString stringWithFormat:@"%ld",(long)flag];
    
    [deptbodyDic setObject:data forKey:key];
    
    [self tableData];
  
}

-(void)tableData{
    
    for(UIScrollView *scroll in self.view.subviews){
        if(scroll.tag==10){
           for(UIView *view in scroll.subviews){
                for(UITableView *tableview in view.subviews){
                   if(tableview.tag==flag){
                      [tableview reloadData];
                   }
                }
               
            }
        }
    }
    
    
    
    
}

-(void) selectDeptNoti:(NSNotification * )notiData{
    
    
    NSDictionary * dataDic = notiData.userInfo;
    
    selectDeptDic = [dataDic mutableCopy];
  
    stepId = [selectDeptDic objectForKey:@"stepId"];
    
    stepTypeId = [[selectDeptDic objectForKey:@"stepTypeId"] intValue];
    
    iscanChoose=[selectDeptDic objectForKey:@"isCanChoose"];
    
    [self.selectDeptBtn setTitle:[dataDic objectForKey:@"stepName"] forState:UIControlStateNormal];

    [self loadViewStep];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
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
    
    if(stepTypeId == 11){
        if (([[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",tableView.tag]] count]+1)%3 == 0) {
            
            return  ([[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",tableView.tag]] count]+1)/3;
            
        } else {
            
            return ([[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",tableView.tag]] count]+1)/3 + 1;
        }
        
    }else{
        if (([[deptbodyDic objectForKey:@"0"] count]+1)%3 == 0) {
            
            return  ([[deptbodyDic objectForKey:@"0"] count]+1)/3;
            
        } else {
            
            return ([[deptbodyDic objectForKey:@"0"] count]+1)/3 + 1;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell = @"SendWorkFlowUserCell";
    NSInteger index = indexPath.row;
    flag=tableView.tag;
    if([iscanArray count]>0){
     iscanChoose=[iscanArray objectForKey:[NSString stringWithFormat:@"%d",flag]];
    }
    
//    SendWorkFlowUserCell *cell = (SendWorkFlowUserCell *)[tableView dequeueReusableCellWithIdentifier:Cell];
//    if (cell == nil) {
      SendWorkFlowUserCell  *cell = [[SendWorkFlowUserCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:Cell];
//    }else{
//        [cell removeFromSuperview];
//    }
    NSInteger count = [[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",flag]] count];

   
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0,0, 76, 90)];
    UIButton * btn1=[[UIButton alloc] initWithFrame:CGRectMake(10,2, 60, 60)];
    UILabel *lb1=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 66.0, 76.0, 21.0)];
    lb1.textAlignment=NSTextAlignmentCenter;
    lb1.font=[UIFont boldSystemFontOfSize:14.0f];
    if(index*3 < count){
        
        NSMutableDictionary * dataUser =[[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",flag]] objectAtIndex:index*3];
        
        lb1.text= [dataUser objectForKey:@"name"];
        [btn1 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        NSInteger tag=(index*3)*10+tableView.tag;
        btn1.tag = tag;
        [btn1 addTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view1 addSubview:btn1];
        [view1 addSubview:lb1];
        [cell addSubview:view1];
        
    }else if(index*3 == count){
        if(iscanChoose==nil||[iscanChoose intValue]==0){
            //cell.btn1.hidden = YES;
            
        }else{
         //cell.btn1.hidden=NO;
          
            [btn1 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(photoWallAddAction:) forControlEvents:UIControlEventTouchUpInside];
           
            btn1.tag=tableView.tag;
            [view1 addSubview:btn1];
             [cell addSubview:view1];
        
        
        }
        
    }else{
        cell.view1.hidden = YES;
    }
    
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(76,0, 76, 90)];
    UIButton * btn2=[[UIButton alloc] initWithFrame:CGRectMake(10,2, 60, 60)];
    UILabel *lb2=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 66.0, 76.0, 21.0)];
     lb2.textAlignment=NSTextAlignmentCenter;
    lb2.font=[UIFont boldSystemFontOfSize:14.0f];
    if(index*3 + 1 < count){
        NSMutableDictionary * dataUser =[[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",flag]] objectAtIndex:index*3+1];
        
        lb2.text = [dataUser objectForKey:@"name"];
       // cell.lb2.hidden = NO;
        
        [btn2 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
        NSInteger tag=(index*3 + 1)*10+tableView.tag;
        btn2.tag = tag;
        
        [btn2 addTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view2 addSubview:btn2];
        [view2 addSubview:lb2];
        [cell addSubview:view2];
    }else if(index*3 + 1 == count){
        if(iscanChoose==nil||[iscanChoose intValue]==0){
            cell.btn2.hidden = YES;
            
        }else{
            
        [btn2 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
            
         btn2.tag=tableView.tag;
           //del_user=index*3 +1;
        [btn2 addTarget:self action:@selector(photoWallAddAction:) forControlEvents:UIControlEventTouchUpInside];
            
        [view2 addSubview:btn2];
        [cell addSubview:view2];
            
        }
    }else{
        //cell.view2.hidden = YES;
    }
    
    UIView *view3=[[UIView alloc] initWithFrame:CGRectMake(152,0, 76, 90)];
    UIButton * btn3=[[UIButton alloc] initWithFrame:CGRectMake(10,2, 60, 60)];
    UILabel *lb3=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 66.0, 76.0, 21.0)];
    lb3.textAlignment=NSTextAlignmentCenter;
    lb3.font=[UIFont boldSystemFontOfSize:14.0f];
    if(index*3 +2 < count){
       
        
        NSMutableDictionary * dataUser =[[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",flag]] objectAtIndex:index*3 +2];
        
        lb3.text = [dataUser objectForKey:@"name"];
        [btn3 setImage:[UIImage imageNamed:@"icon_user_del"] forState:UIControlStateNormal];
//       / NSString *tag=[NSString stringWithFormat:@"%d,%d",index*3 + 2,flag];
         NSInteger tag=(index*3 + 2)*10+tableView.tag;
         btn3.tag = tag;
        [btn3 addTarget:self action:@selector(photoWallDelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view3 addSubview:lb3];
        [view3 addSubview:btn3];
        [cell addSubview:view3];
        
    }else if(index*3 + 2 == count){
        if(iscanChoose==nil||[iscanChoose intValue]==0){
           // cell.btn3.hidden = YES;
            
        }else{
        [btn3 setImage:[UIImage imageNamed:@"image_add"] forState:UIControlStateNormal];
            
         btn3.tag=tableView.tag;
         
        [btn3 addTarget:self action:@selector(photoWallAddAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [view3 addSubview:btn3];
        [cell addSubview:view3];
    }else{
        
       // cell.view3.hidden = YES;
    }
    
    return cell;
    
}


#pragma mark -


- (void)photoWallAddAction:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    flag=btn.tag;
    
    ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
    
    vc.noti_name = @"notif_send_work_flow_user";
    
    NSString *key=[NSString stringWithFormat:@"%d",flag];
    
    vc.selectUserArray = [deptbodyDic objectForKey:key];
    vc.worktag=_workFlowTag;
    vc.stepid = stepId;
    vc.inboxid = _inboxId;
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
    [self.reviewText resignFirstResponder];
    
}


- (void)photoWallDelAction:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    
    int tag = btn.tag;
    del_user=tag/10;
    flag=tag%10;
    
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
            NSString *key=[NSString stringWithFormat:@"%d",flag];
            NSLog(@"%@",deptbodyDic);
            [[deptbodyDic objectForKey:key] removeObjectAtIndex:del_user];
            [self tableData];
        }
        
    }else{
        
    }
    
}



-(IBAction)returnBtnClick:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
}




-(IBAction) sendBtnClick:(id)sender{
    [self.reviewText resignFirstResponder];
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    
    NSMutableDictionary * reqHeader = [[NSMutableDictionary alloc]init];
    [reqHeader setObject:self.inboxId forKey:@"boxId"];
    
    NSMutableDictionary * reqBody = [[NSMutableDictionary alloc]init];
    NSString * leaveword = self.reviewText.text;
    if(leaveword == nil){
        leaveword = @"";
    }
    
    [reqBody setObject:leaveword forKey:@"leaveword"];
    
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = nil;
    
    if(self.workFlowTag == 1){
        //liuqj,2015-8-1,处理协办
        NSMutableArray * users = [[NSMutableArray alloc] init];
        NSMutableArray * userList =[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",0]];
        for (NSDictionary  *user in userList) {
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
        [reqBody setObject:users forKey:@"userIds"];
        [reqBody setObject:leaveword forKey:@"leaveword"];
        
        [params setObject:reqHeader forKey:@"reqHeader"];
        
        [params setObject:reqBody forKey:@"reqBody"];
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/special?boxId=%@",serverAddress,self.inboxId];
    }else if(self.workFlowTag == 2){
        //liuqj,2015-8-1,处理协办
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/specialBack?boxId=%@",serverAddress,self.inboxId];
        
    }else{
        
        NSMutableArray * fileSentStepVOs = [[NSMutableArray alloc] init];
        
        int count=0;
        NSLog(@"%@",deptbodyDic);
        for(int j=0;j< [deptbodyDic count];j++){
            NSMutableArray * userList =[deptbodyDic objectForKey:[NSString stringWithFormat:@"%d",j]];
            NSLog(@"%@",userList);
            
            if([userList count]>0){
                NSMutableArray * users = [[NSMutableArray alloc] init];
                for (int m=0;m<[userList count]; m++) {
                    NSMutableDictionary *user=[userList objectAtIndex:m];
                    if([userList count]>0)
                    {
                        count=1;
                    }
                    [users  addObject:[user objectForKey:@"id"]];
                }
                NSMutableDictionary * fileSentStepVo = [[NSMutableDictionary alloc] init];
                [fileSentStepVo setObject:users forKey:@"userIds"];
                NSString *stid=[stepID objectForKey:[NSString stringWithFormat:@"%d",j]] ;
                [fileSentStepVo setObject: stid forKey:@"stepId"];
                [fileSentStepVOs addObject:fileSentStepVo];
            }
            
            
        }
        
        if (count==0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:@"请选择下一步处理人"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:nil,nil];
            [alert show];
            
            return;
        }
        
        [reqBody setObject:fileSentStepVOs forKey:@"fileSentStepVOs"];
        [params setObject:reqHeader forKey:@"reqHeader"];
        [params setObject:reqBody forKey:@"reqBody"];
        
        urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/sent?boxId=%@",serverAddress,self.inboxId];
    }
    
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
    [SVProgressHUD dismissWithError:@"服务器连接失败"];
    NSString * notif_name = @"notif_login";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];

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


-(IBAction)chooseDeptName:(id)sender{
    [self.reviewText resignFirstResponder];
    
    SelectDeptViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectDeptViewController"];
    
    vc.selectUserArray = deptArray;
    vc.selectDeptDic = selectDeptDic;
    
    [self presentViewController:vc animated:YES completion:^(void){}];
    
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
