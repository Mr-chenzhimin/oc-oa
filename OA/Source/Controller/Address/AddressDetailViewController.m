//
//  AddressDetailViewController.m
//  OA
//
//  Created by admin on 14-6-4.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "AddressDetailViewController.h"

@interface AddressDetailViewController ()

@end

@implementation AddressDetailViewController

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
    self.topmeunview.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    NSString * sex = [self.AddressData objectForKey:@"sex"];
    if([sex intValue]==1){
    self.imagepeohead.image = [UIImage imageNamed:@"peoheadman"];
    }else{
    self.imagepeohead.image = [UIImage imageNamed:@"peoheadwoman"];
    }
    self.txtpeoname.text=[self.AddressData objectForKey:@"name"];
    self.txtpeoduty.text=self.deptname;
    self.txtpeodept.text=[self.AddressData objectForKey:@"position"];
    self.txtmobliephone.text=[self.AddressData objectForKey:@"mobile"];
    self.txttelphone.text=[self.AddressData objectForKey:@"officephone"];
    self.txtemail.text=[self.AddressData objectForKey:@"email"];
    self.txtbirthday.text=[self.AddressData objectForKey:@"birthday"];
    
    
    // 纯代码重写个人详情页
 /*
    UITableView *tablevew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStyleGrouped];
    tablevew.delegate =self;
    tablevew.dataSource=self;
    tablevew.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:tablevew];
    
    UIImageView *topview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 200)];
    topview.image=[UIImage imageNamed:@"通讯录09"];
    
    UIImageView *userimage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    userimage.image=[UIImage imageNamed:@"peoheadman"];
    userimage.center=topview.center;
    [topview addSubview:userimage];
    
    UILabel *username =[[UILabel alloc]initWithFrame:CGRectMake(userimage.frame.origin.x, userimage.frame.origin.y+60, 60, 20)];
    username.text =[self.AddressData objectForKey:@"name"];
    username.textAlignment =NSTextAlignmentCenter;
    [topview addSubview:username];
    
    tablevew.tableHeaderView =topview;
    
    
    UIImage *img1 = [Constant scaleToSize:[UIImage imageNamed:@"通讯录-发消息"] size:CGSizeMake(40, 40)];
    UIImage *img_1 = [Constant scaleToSize:[UIImage imageNamed:@"通讯录-发消息"] size:CGSizeMake(40, 40)];
    RKTabItem * emailItem = [RKTabItem createUsualItemWithImageEnabled:img1 imageDisabled:img_1];
    emailItem.titleString = @"";
    
    UIImage *img2 = [Constant scaleToSize:[UIImage imageNamed:@"zg_phone"] size:CGSizeMake(40, 40)];
    UIImage *img2_1 = [Constant scaleToSize:[UIImage imageNamed:@"zg_phone"] size:CGSizeMake(40, 40)];
    RKTabItem * phoneItem = [RKTabItem createUsualItemWithImageEnabled:img2 imageDisabled:img2_1];
    phoneItem.titleString = @"";
    
    _titledTabsView =[[RKTabView alloc]initWithFrame:CGRectMake(0, UIScreenHeight-50, UIScreenWidth, 50)];
    _titledTabsView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_titledTabsView];
    self.titledTabsView.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    self.titledTabsView.delegate = self;
    self.titledTabsView.tabItems = @[emailItem,phoneItem];
    
    UIImage *backbtnimg = [Constant scaleToSize:[UIImage imageNamed:@"L"] size:CGSizeMake(40, 40)];
    UIButton *backbtn =[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    backbtn.backgroundColor=[UIColor colorWithPatternImage:backbtnimg];
    [backbtn addTarget:self action:@selector(btnback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
*/
    
}

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    if (index ==0) {
        NSString * phoneNumber=[self.AddressData objectForKey:@"mobile"];
        if([self checkhphone:phoneNumber]==1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNumber]]];
        }
    }else{
        NSString * officephone=[self.AddressData objectForKey:@"officephone"];
        if([self checkhphone:officephone]==1){
            // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",officephone]]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", officephone]]];
        }
    
    }

}
#pragma mark - 数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 2;
}

// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section ==0) {
        if (indexPath.row==0) {
            
            UILabel *lab1 =[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 70,30)];
            lab1.text =@"手机";
            [cell.contentView addSubview:lab1];
            
            UILabel *mobile =[[UILabel alloc]initWithFrame:CGRectMake(100, 15, 200, 30)];
            mobile.text =[self.AddressData objectForKey:@"mobile"];
            [cell.contentView addSubview:mobile];
            
        }else if (indexPath.row==1){
            
            UILabel *lab1 =[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 70,30)];
            lab1.text =@"邮箱";
            [cell.contentView addSubview:lab1];
            
            UILabel *email =[[UILabel alloc]initWithFrame:CGRectMake(100, 15, 200, 30)];
            email.text =[self.AddressData objectForKey:@"email"];
            [cell.contentView addSubview:email];
        }
    }else{
    
        if (indexPath.row==0) {
            
            UILabel *lab1 =[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 70,30)];
            lab1.text =@"部门";
            [cell.contentView addSubview:lab1];
            
            UILabel *deptname =[[UILabel alloc]initWithFrame:CGRectMake(100, 15, 200, 30)];
            deptname.text =self.deptname;
            [cell.contentView addSubview:deptname];
            
        }else if (indexPath.row==1){
            
            UILabel *lab1 =[[UILabel alloc]initWithFrame:CGRectMake(12, 12, 70,30)];
            lab1.text =@"职位";
            [cell.contentView addSubview:lab1];
            
            UILabel *position =[[UILabel alloc]initWithFrame:CGRectMake(100, 12, 200, 30)];
            position.text =[self.AddressData objectForKey:@"position"];
            [cell.contentView addSubview:position];
        }
    
    }
    
    
    return cell;
}

#pragma mark - 代理方法
/**
 *  设置行高
 */
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 60;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return  20;
//}
//// 添加每组的组头
//- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//}
//
//// 返回每组的组尾
//- (UIView *)tableView:(nonnull UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//}

// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"选中didSelectRowAtIndexPath row = %ld", indexPath.row);
}

// 取消选中某行cell会调用 (当我选中第0行的时候，如果现在要改为选中第1行 - 》会先取消选中第0行，然后调用选中第1行的操作)
- (void)tableView:(nonnull UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSLog(@"取消选中 didDeselectRowAtIndexPath row = %ld ", indexPath.row);
}

\


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

- (IBAction)btnmobliephone:(id)sender {
    NSString * phoneNumber=[self.AddressData objectForKey:@"mobile"];
    if([self checkhphone:phoneNumber]==1){
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]]];
    }
}

- (IBAction)btntelphone:(id)sender {
    NSString * officephone=[self.AddressData objectForKey:@"officephone"];
     if([self checkhphone:officephone]==1){
       // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",officephone]]];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", officephone]]];
    }

}

- (IBAction)btnsendmessage:(id)sender {
    NSString * phoneNumber=[self.AddressData objectForKey:@"mobile"];
     if([self checkhphone:phoneNumber]==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNumber]]];
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
- (IBAction)btnback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)contactBtn:(id)sender {
    NSString * phoneNumber=[self.AddressData objectForKey:@"mobile"];
    if([self checkhphone:phoneNumber]==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phoneNumber]]];
    }
    
}
@end
