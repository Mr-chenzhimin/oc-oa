//
//  DocexCreateViewController.m
//  OA
//
//  Created by admin on 15-3-20.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import "DocexCreateViewController.h"
#import "DocexSentViewController.h"

@interface DocexCreateViewController ()

@end

@implementation DocexCreateViewController


- (void)viewDidLoad {
    
    self.itional.tag = 1;
    self.share.tag = 1;
    self.conrem.tag = 1;
    [super viewDidLoad];
    
    UIImage *docex = [Constant scaleToSize:[UIImage imageNamed:@"bt41_1"] size:CGSizeMake(50, 55)];
    UIImage *docex_1 = [Constant scaleToSize:[UIImage imageNamed:@"bt41_2"] size:CGSizeMake(50, 55)];
    RKTabItem * docexTabItem = [RKTabItem createUsualItemWithImageEnabled:docex_1 imageDisabled:docex];
    docexTabItem.titleString = @"";
    
    self.titledTabsView.darkensBackgroundForEnabledTabs = NO;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
//    self.titledTabsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view背景.png"]];
    self.titledTabsView.delegate = self;
    self.titledTabsView.frame = CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48);
    self.titledTabsView.tabItems = @[docexTabItem];
    
}
#pragma mark - RKTabViewDelegate
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    [tabView swtichTab:tabItem];
    if (index == 0) {
        if( [self checknull]){
           DocexSentViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DocexSentViewController"];
            vc.additional=[NSString stringWithFormat:@"%ld",(long)self.itional.tag];
            vc.conrem=[NSString stringWithFormat:@"%ld",(long)self.conrem.tag];
            vc.share=[NSString stringWithFormat:@"%ld",(long)self.share.tag];
            vc.docex_context=self.docex_content.text;
            vc.docex_title=self.docex_title.text;
        [self.navigationController pushViewController:vc animated:YES  ];
         }
        }else{
          [self.docex_title resignFirstResponder];
          [self.docex_content resignFirstResponder];
          [self.navigationController popViewControllerAnimated:YES];
        
         }
 
    
    
}

- (IBAction)returnbtnclick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)checknull{
    
    NSString * tilte=self.docex_title.text;
    
    if([tilte isEqualToString:@""]|| tilte==nil){
       UIAlertView * alert = [[UIAlertView alloc]
                           initWithTitle:@"错误"
                           message:@"标题不能为空！"
                           delegate:self
                           cancelButtonTitle:@"确定"
                           otherButtonTitles:nil];
      [alert show];
        return false;
    }
    NSString * content=self.docex_content.text;

    if([content isEqualToString:@""]||content==nil){
    UIAlertView * alert = [[UIAlertView alloc]
                           initWithTitle:@"错误"
                           message:@"内容不能为空！"
                           delegate:self
                           cancelButtonTitle:@"确定"
                           otherButtonTitles:nil];
    [alert show];
        return false;
    }
    return true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)additional:(id)sender {
    if(self.itional.tag == 1){
        [self.itional setImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
        self.itional.tag = 0;
        
        
    }else{
        [self.itional setImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
        self.itional.tag = 1;
        
    }
    
}
- (IBAction)conrem:(id)sender{
    if(self.conrem.tag == 1){
        [self.conrem setImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
        self.conrem.tag = 0;
        
        
    }else{
        [self.conrem setImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
        self.conrem.tag = 1;
        
    }
    
}
- (IBAction)share:(id)sender{
    if(self.share.tag == 1){
        [self.share setImage:[UIImage imageNamed:@"icon_打勾.png"] forState:UIControlStateNormal];
        self.share.tag = 0;
        
        
    }else{
        [self.share setImage:[UIImage imageNamed:@"icon_未打勾.png"] forState:UIControlStateNormal];
        self.share.tag = 1;
        
    }
    
}
- (IBAction)backgroundclick:(id)sender {
    [self.docex_title resignFirstResponder];
    [self.docex_content resignFirstResponder];
}
@end
