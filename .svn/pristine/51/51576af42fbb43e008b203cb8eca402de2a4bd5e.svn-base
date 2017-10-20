//
//  AddressViewController.m
//  OA
//
//  Created by admin on 14-6-3.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressDetailViewController.h"
#import "AddressCell.h"
#import "MainCenterViewController.h"


@interface AddressViewController (){
    NSString * deptName;
}
@property (nonatomic,strong) MainCenterViewController * mainCenterVc;
@end

@implementation AddressViewController

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
    self.topmeunview.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    self.mstableView.delegate = self;
    self.mstableView.dataSource = self;
    rememberdeptID = [[NSMutableArray alloc] init];
    NSMutableDictionary * fileSentStepVo = [[NSMutableDictionary alloc] init];
    [fileSentStepVo setObject:@"2" forKey:@"deptId"];
    [fileSentStepVo setObject:@"通迅录" forKey:@"deptName"];
    [rememberdeptID addObject:fileSentStepVo];
     [_btnbackname setHidden:YES];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self loadData];
}

-(void) loadData{
    
    
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/addressModule/deptNav?deptId=2",serverAddress];
    
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


#pragma mark - 列表

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if([rememberdeptID count]==1){
//        return [dataArray count]-1;
//    }else{
//        return [dataArray count];
//    }
    return [dataArray count];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    int index = indexPath.row;
    NSDictionary * data= [dataArray objectAtIndex:index];
    
    int type = [[data objectForKey:@"type"] integerValue];
    if (type == 0) {
        
        static NSString *CellIdentifier = @"AddressCell";
        AddressCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        NSString *deptname=[data objectForKey:@"name"];
        cell.deptname.text= deptname;

        
        UIView *lbl = [[UIView alloc] init];
        //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        NSLog(@"1....%f2....%f3....%f",cell.frame.origin.x,cell.frame.size.height-5,cell.frame.size.width);
        lbl.frame = CGRectMake(cell.frame.origin.x , 59, cell.frame.size.width, 1);
        lbl.backgroundColor =  [UIColor lightGrayColor];
        [cell.contentView addSubview:lbl];
        
        cell.tag = index;
        
        UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
        
        [oneFingerTwoTaps setNumberOfTapsRequired:1];
        [oneFingerTwoTaps setNumberOfTouchesRequired:1];
        
        [cell addGestureRecognizer:oneFingerTwoTaps];
        
        
        return  cell;
    }else{
        
        static NSString *newfilecell = @"userinfocell";
        UITableViewCell *cell = nil;
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:newfilecell];
            
//            NSString *deptname=[data objectForKey:@"name"];
//            if([deptname isEqualToString:@"超级用户"]){
//                return  cell;
//            }
            
            CGRect imageRect = CGRectMake(4, 15, 30, 30);
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
            NSString * sex=[data objectForKey:@"sex"];
            if([sex intValue]==1){
             imageView.image = [UIImage imageNamed:@"singlemanhead"];
            }else{
             imageView.image = [UIImage imageNamed:@"singlewomenhead"];
            }
            [cell.contentView addSubview:imageView];
            
            UIView *backview = [[UIView alloc] init];
            backview.frame=CGRectMake(35,3,280,55);
            
            CGRect imageRect1 = CGRectMake(0, 0, 280, 55);
            UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:imageRect1];
            imageView1.image = [UIImage imageNamed:@"bg_选项背景2"];
            
            
            CGRect nameRect = CGRectMake(10, 5, 90, 21);
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
            nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.text=[data objectForKey:@"name"];
            
            CGRect phoneRect = CGRectMake(10, 25, 90, 21);
            UILabel *phoneLabel = [[UILabel alloc]initWithFrame:phoneRect];
            phoneLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
            phoneLabel.textColor = [UIColor blackColor];
            phoneLabel.text=[data objectForKey:@"mobile"];
            
            CGRect phoneframe = CGRectMake(160, 10, 40, 33);
            UIButton *btnphone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnphone.frame = phoneframe;
            [btnphone setTitle:@"" forState: UIControlStateNormal];
            [btnphone setBackgroundImage:[UIImage imageNamed:@"button_phone_normal"] forState:UIControlStateNormal];
            btnphone.tag = index;
           	[btnphone addTarget:self action:@selector(mobilephone:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect msgframe = CGRectMake(220, 10, 40, 33);
            UIButton *btnmessage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnmessage.frame = msgframe;
            [btnmessage setTitle:@"" forState: UIControlStateNormal];
            [btnmessage setBackgroundImage:[UIImage imageNamed:@"sendmessage"] forState:UIControlStateNormal];
            btnmessage.tag = index;
           	[btnmessage addTarget:self action:@selector(sendmessage:) forControlEvents:UIControlEventTouchUpInside];
           	
            
            [backview addSubview:imageView1];
            [backview addSubview:nameLabel];
            [backview addSubview:phoneLabel];
            [backview addSubview:btnphone];
            [backview addSubview:btnmessage];
            
            [cell.contentView addSubview:backview];
             cell.backgroundColor=[UIColor clearColor];
            
            cell.tag = index;
            
            UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
            
            [oneFingerTwoTaps setNumberOfTapsRequired:1];
            [oneFingerTwoTaps setNumberOfTouchesRequired:1];
            
            [cell addGestureRecognizer:oneFingerTwoTaps];
            return  cell;
        }
    }
        
    return  nil;
}
- (IBAction)mobilephone:(id)sender {
    UIButton *mobliephone=(UIButton *)sender;
    int index =mobliephone.tag;
    NSDictionary * data = [dataArray objectAtIndex:index];
    NSString * phoneNumber=[data objectForKey:@"mobile"];
    if([self checkhphone:phoneNumber]==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phoneNumber]]];
    }
    
}

- (IBAction)sendmessage:(id)sender {
    
    UIButton *mobliephone=(UIButton *)sender;
    int index =mobliephone.tag;
    NSDictionary * data = [dataArray objectAtIndex:index];
    NSString * phoneNumber=[data objectForKey:@"mobile"];
    if([self checkhphone:phoneNumber]==1){
       // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", phoneNumber]]];
    }
    
}
-(int)checkhphone:(NSString *)phone{
    if([phone isEqual:nil]||[phone isEqual:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"号码不存在"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:nil,nil];
        [alert show];
        return 0;
    }
    return 1;
}


-(void) cellClick:(UITapGestureRecognizer *)sender{
    int index = sender.view.tag;
    NSDictionary * data = [dataArray objectAtIndex:index];
    int type = [[data objectForKey:@"type"] integerValue];
    if (type  == 0) {
        [_btnbackname setHidden:NO];
        deptName = [data objectForKey:@"name"];
        NSString * deptId = [NSString stringWithFormat:@"%@",[data objectForKey:@"id"]];
        NSMutableDictionary * datanext=[rememberdeptID objectAtIndex:[rememberdeptID count]-1];
        if([deptId isEqualToString:[datanext objectForKey:@"deptId"]]){
            show_user=1;
            NSString * deptId = [NSString stringWithFormat:@"%@",[[rememberdeptID objectAtIndex:[rememberdeptID count]-2] objectForKey:@"deptId"]];
            NSString * deptName1 = [NSString stringWithFormat:@"%@",[[rememberdeptID objectAtIndex:[rememberdeptID count]-2] objectForKey:@"deptName"]];
            deptName=deptName1;
            self.mytitlelable.text=deptName1;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData2:deptId];
        }else{
            NSMutableDictionary * fileSentStepVo = [[NSMutableDictionary alloc] init];
            [fileSentStepVo setObject:deptId forKey:@"deptId"];
            [fileSentStepVo setObject:deptName forKey:@"deptName"];
            [rememberdeptID addObject:fileSentStepVo];
            self.mytitlelable.text=deptName;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData2:deptId];
        }
        [self.mstableView reloadData];
        
    }else{
        //查看详情
        AddressDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressDetailViewController"];
        vc.deptname=deptName;
        vc.AddressData = [dataArray objectAtIndex:index];
        [self.navigationController pushViewController:vc animated:YES  ];
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * data = [dataArray objectAtIndex:indexPath.row];
    int type = [[data objectForKey:@"type"] integerValue];
    if (type  == 0) {
         [_btnbackname setHidden:NO];
         deptName = [data objectForKey:@"name"];
         NSString * deptId = [NSString stringWithFormat:@"%@",[data objectForKey:@"id"]];
        NSMutableDictionary * datanext=[rememberdeptID objectAtIndex:[rememberdeptID count]-1];
        if([deptId isEqualToString:[datanext objectForKey:@"deptId"]]){
            show_user=1;
            NSString * deptId = [NSString stringWithFormat:@"%@",[[rememberdeptID objectAtIndex:[rememberdeptID count]-2] objectForKey:@"deptId"]];
            NSString * deptName1 = [NSString stringWithFormat:@"%@",[[rememberdeptID objectAtIndex:[rememberdeptID count]-2] objectForKey:@"deptName"]];
            deptName=deptName1;
             self.mytitlelable.text=deptName1;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData2:deptId];
        }else{
            NSMutableDictionary * fileSentStepVo = [[NSMutableDictionary alloc] init];
            [fileSentStepVo setObject:deptId forKey:@"deptId"];
            [fileSentStepVo setObject:deptName forKey:@"deptName"];
            [rememberdeptID addObject:fileSentStepVo];
            self.mytitlelable.text=deptName;
            [SVProgressHUD showWithStatus:@"加载中..."];
            [self loadData2:deptId];
        }
           [self.mstableView reloadData];
            
        }else{
            //查看详情
            AddressDetailViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressDetailViewController"];
            vc.deptname=deptName;
            vc.AddressData = [dataArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:vc animated:YES  ];
        }
        
        
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
    
    dataArray = rspBody;// [rspBody objectForKey:@"todoList"];
    
    [self.mstableView reloadData];
    [SVProgressHUD dismissWithSuccess:@""];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchBtnClick:(id)sender {
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

- (IBAction)btnback:(id)sender {
    if([rememberdeptID count]>1){
    NSString * deptId = [NSString stringWithFormat:@"%@",[[rememberdeptID objectAtIndex:[rememberdeptID count]-2] objectForKey:@"deptId"]];
    NSString * deptName1 = [NSString stringWithFormat:@"%@",[[rememberdeptID objectAtIndex:[rememberdeptID count]-2] objectForKey:@"deptName"]];
    deptName=deptName1;
     NSMutableDictionary * data=[rememberdeptID objectAtIndex:[rememberdeptID count]-1];
    [rememberdeptID removeObject:data];
    self.mytitlelable.text=deptName;
    [self loadData2:deptId];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    
    
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
    
    [self.mstableView reloadData];
    [SVProgressHUD dismissWithSuccess:@""];
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",[request error]);
    
    
    NSLog(@"服务器连接不上！");
    [SVProgressHUD dismissWithError:@"加载失败"];
}



- (IBAction)textFieldDoneediting:(id)sender {
    [sender resignFirstResponder];
}

@end
