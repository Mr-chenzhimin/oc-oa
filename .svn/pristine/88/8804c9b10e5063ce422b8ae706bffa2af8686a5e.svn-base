//
//  EntrustViewController.m
//  
//
//  Created by admin on 15/12/28.
//
//

#import "EntrustViewController.h"
#import "JKAlertDialog.h"
#import "ShowUserViewController.h"
@interface EntrustViewController (){

    NSMutableDictionary * selectDeptDic;
    ASIHTTPRequest *request1;
    UIButton * checkBtn;
    int isAllfile;
}

@end

@implementation EntrustViewController
@synthesize list = _list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    NSArray *arry = [[NSArray alloc]initWithObjects:@"开始时间",@"结束时间",@"委托人员",@"未签收文件", nil];
    self.list = arry;
    
    selectUserArray = [[NSMutableArray alloc]init];
    selectDocArray = [[NSMutableArray alloc]init];
    NSString * notif_send_work_entrust_user = @"notif_send_entrust_user";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUserLabal:) name:notif_send_work_entrust_user object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    static NSString *newfilecell = @"newfilenamecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newfilecell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:newfilecell];
    }
    if (index == 0) {
        
        _startime = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth-40, 5, 35, 35)];
        [_startime setImage:[UIImage imageNamed:@"btn_day"]];
        [cell addSubview:_startime];
        
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 180, self.view.frame.size.width-40, 216)];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        self.datePicker.locale = locale;
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        
        _starLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 5, 250, 30)];
        _starLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:_starLabel];
//        _showLabel.hidden= YES;


    }
    else if (index == 1) {
        
        _endtime = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth-40, 5, 35, 35)];
        [_endtime setImage:[UIImage imageNamed:@"btn_day"]];
        [cell addSubview:_endtime];
        
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 180, self.view.frame.size.width-40, 216)];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        self.datePicker.locale = locale;
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        
        _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 5, 250, 30)];
        _endLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:_endLabel];
        //        _showLabel.hidden= YES;
        
        
    }
    else if(index == 2){
        _people = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth-40, 0, 35, 35)];
        [_people setImage:[UIImage imageNamed:@"btn_people"]];
        [cell addSubview:_people];
        
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth-90, 5, 80, 30)];
        _userLabel.textAlignment = NSTextAlignmentRight;

        [cell addSubview:_userLabel];
//        _userLabel.hidden =YES;
        checkBtn.hidden = YES;
    }else{
    
        checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth-40, 5, 30, 30)];
        [cell.contentView addSubview:checkBtn];
        
        NSDictionary * data = [self.list objectAtIndex:index];
        BOOL selected = [selectDocArray containsObject:data];
        
        
        if (selected) {
            [checkBtn setImage:[UIImage imageNamed:@"icon_打勾"]forState:UIControlStateNormal];
            isAllfile = 1;
            
        }else{
            [checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"]forState:UIControlStateNormal];
            isAllfile = 0;
        }
        

    }
    
    cell.textLabel.text = [self.list objectAtIndex:index];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if (index == 0) {
        _startime.hidden = YES;
        _starLabel.hidden = NO;
        JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"日期" message:@""];
        alert.contentView =  self.datePicker;
        [alert addButton:Button_OTHER withTitle:@"确定" handler:^(JKAlertDialogItem *item) {
            //NSDate格式转换为NSString格式
            NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
            NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
            [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
            //打印显示日期时间
            NSLog(@"格式化显示时间：%@",dateString);
            _starLabel.text = dateString;
            
        }];
    
        [alert addButton:Button_OTHER withTitle:@"取消" handler:^(JKAlertDialogItem *item) {
            if (_starLabel.text==nil) {
                _starLabel.hidden = NO;
            }
            
            
        }];;
        
        [alert show];
        
    }
    else if (index == 1) {
        _endtime.hidden = YES;
        _endLabel.hidden = NO;
        JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"日期" message:@""];
        alert.contentView =  self.datePicker;
        [alert addButton:Button_OTHER withTitle:@"确定" handler:^(JKAlertDialogItem *item) {
            //NSDate格式转换为NSString格式
            NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
            NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
            [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
            //打印显示日期时间
            NSLog(@"格式化显示时间：%@",dateString);
            _endLabel.text = dateString;
            
        }];
        
        [alert addButton:Button_OTHER withTitle:@"取消" handler:^(JKAlertDialogItem *item) {
            if (_endLabel.text==nil) {
                _endtime.hidden = NO;
            }
            
            
        }];;
        
        [alert show];
        
    }
    else if(index ==2){
        OALog(@"委托人员");
        _people.hidden= YES;
        _userLabel.hidden = NO;
        ShowUserViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowUserViewController"];
        vc.noti_name = @"notif_send_entrust_user";
        vc.selectUserArray = selectUserArray;
        
        [self presentViewController:vc animated:YES completion:^(void){}];
   
    }
    else{
        
        NSDictionary * data = [self.list objectAtIndex:index];
        BOOL selected = [selectDocArray containsObject:data];
        
        if (selected) {
            [selectDocArray removeObject:data];
        }else{
            [selectDocArray addObject:data];
        }
        // 刷新未签收文件cell
        [self.tabview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    }
  
}

- (void)reloadUserLabal:(NSNotification * )notiData{
    
    NSDictionary * dataDic = notiData.userInfo;
    
    NSMutableArray * data = [dataDic objectForKey:@"select_user_array"];
    
    selectUserArray = data;
    
    if ([data count] != 0) {
        NSString *username=[[data objectAtIndex:0] objectForKey:@"name"];
        _userLabel.text =username;
        
    }else{
        _userLabel.text =nil;
        _people.hidden= NO;
    }
    


    
    
    
}



- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (IBAction)sendClick:(id)sender {
    
    //    NSLog(@"=======>count:%d",count);
    
    //开始时间
    NSString * star = self.starLabel.text;
    //结束时间
    NSString * end = self.endLabel.text;
 
    if (star ==nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"温馨提示"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"请输入开始时间",nil];
        [alert show];
        return ;
    }
    if (end ==nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"温馨提示"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"请输入结束时间",nil];
        [alert show];
        return ;
    }
    
    NSInteger count = [selectUserArray count];
    if (count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"温馨提示"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"请选择委托人",nil];
        [alert show];
        return ;
    }
    
    int userids = [[[selectUserArray objectAtIndex:0]objectForKey:@"id"]intValue];
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    NSInteger userid = [[Utils getCacheForKey:@"userId"]intValue];

    if (userid == userids) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"温馨提示"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"当前用户不能选择",nil];
        [alert show];
        return ;
    }
    
    NSString *flowIds = nil;
    for (NSMutableDictionary *flowid in _selectEntArray) {
        NSString *flow = [flowid objectForKey:@"id"];
        if(flowIds == nil){
            flowIds = flow;
        }else{
            flowIds = [NSString stringWithFormat:@"%@,%@", flowIds, flow];
        }
    }
//        [params setObject:[flowid objectForKey:@"id"] forKey:[NSString stringWithFormat:@"%d",[[flowid objectForKey:@"id"] intValue]]];
    
    
//        NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/message/saveMessage",serverAddress];
        NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/workflowModule/workflowfiles/agentFile?startdate=%@&flowids=%@&userids=%d&enddate=%@&isAllFile=%d",serverAddress,star,flowIds,userids,end,isAllfile];
        urlAddress =  [urlAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        [headers setObject:@"application/json" forKey:@"Content-type"];
        
        NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
        [headers setObject:tokenId forKey:@"token"];
        
         request1 = [ASIHTTPRequest requestWithURL:url];
        [request1 setRequestHeaders:headers];
        
        [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
        
        [request1 setDelegate:self];
//        [request setDidFinishSelector:@selector(GetResult:)];
//        [request setDidFailSelector:@selector(GetErr:)];
        [request1 startAsynchronous];
    
    [request1 setDidFinishSelector:@selector(GetResult:)];
    [request1 setDidFailSelector:@selector(GetErr:)];
}


- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    
    NSMutableDictionary *rspBody = [result objectForKey:@"rspBody"];
    
    NSInteger status = [[rspHeader objectForKey:@"code"] integerValue];
    NSString * msg = [rspHeader objectForKey:@"msg"];
    
    if (status == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:msg
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 10;
        
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
    
    if (alertView.tag == 10) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}

- (IBAction)refresh:(id)sender {
}
@end
