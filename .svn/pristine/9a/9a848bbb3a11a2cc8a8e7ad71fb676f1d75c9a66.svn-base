//
//  SelectDeptViewController.m
//  OA
//
//  Created by APPLE on 13-12-28.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "SelectDeptViewController.h"

@interface SelectDeptViewController ()

@end

@implementation SelectDeptViewController

@synthesize selectUserArray;

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
    //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"index_background.png"]];
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)returnBtnClick:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
}




#pragma mark - 列表

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
    return [selectUserArray count];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShowUserCell";
    
    
    int index = indexPath.row;
    
    ShowUserCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * data = [selectUserArray objectAtIndex:index];
    
    cell.userNameLabel.text = [data objectForKey:@"stepName"];
    
    if([self.selectDeptDic isEqual:data]){
        [cell.checkBtn setImage:[UIImage imageNamed:@"icon_打勾"]];
        //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_打勾"] forState:UIControlStateNormal];
        
    }else{
        [cell.checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"]];
        //[cell.checkBtn setImage:[UIImage imageNamed:@"icon_未打勾"] forState:UIControlStateNormal];
        
    }
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int index = indexPath.row;
    
    
    NSDictionary * data = [selectUserArray objectAtIndex:index];
    
    
    NSString * notif_name = @"notif_select_dept_user";
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:data];
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    

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
