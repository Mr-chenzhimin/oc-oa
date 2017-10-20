//
//  DocexSentViewController.h
//  OA
//
//  Created by admin on 15-3-20.
//  Copyright (c) 2015年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocexSentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray * selectUserArray;
    NSMutableArray * selectDeptArray;
    UIImage *image;
    float filesize;
    NSString * filecontent;
}

@property (strong, nonatomic) IBOutlet  UITableView * userTableView;
- (IBAction)returnback:(id)sender;

@property (strong, nonatomic) IBOutlet  UITableView * deptTableView;
- (IBAction)checkfile:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *filenametxt;
- (IBAction)docexsent:(id)sender;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;

@property (nonatomic,strong) IBOutlet UIButton * returnBtn;

@property (nonatomic,strong) NSString * docex_title;
@property (nonatomic,strong) NSString * additional;
@property (nonatomic,strong) NSString * conrem;
@property (nonatomic,strong) NSString * share;
@property (nonatomic,strong) NSString * docex_context;
@end
