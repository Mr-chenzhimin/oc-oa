//
//  WorkLogAddViewController.h
//  OA
//
//  Created by admin on 16/7/8.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "RKTabView.h"

@interface WorkLogAddViewController : UIViewController<RKTabViewDelegate,UITextViewDelegate,UITextFieldDelegate,NIDropDownDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{

     IBOutlet UIButton *shareRange;
    NIDropDown *dropDown;
}
@property (nonatomic,strong)  RKTabView *titledTabsView;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (nonatomic,strong) NSMutableDictionary * worklogData;
- (IBAction)defalutshareuser:(id)sender;

- (IBAction)shareRangeClick:(id)sender;

@property (nonatomic) int worklogTag;  //日志内容内容提交时状态， 根据后台逻辑日志内容新增或修改状态都为修改  0 为新增  1 为修改

@property (strong, nonatomic) NSMutableArray *shareUserArry;

@property (nonatomic) int contentId; // 明细id

@property (nonatomic,strong) NSString *workLogId;  //日志id

@property (nonatomic,strong) NSString *name;

@property (nonatomic) int status;   //日志状态  1 发布 0 暂存 3 新建（无）

@property (nonatomic,strong) NSString *logday;

@property (nonatomic,strong) NSString *titleStr;
@property (strong, nonatomic) IBOutlet UIButton *shareuserimg;

@property (strong, nonatomic) IBOutlet UILabel *titile;
@property (strong, nonatomic) IBOutlet UITextView *content;

@property (strong, nonatomic) IBOutlet UIButton *right1;
@property (strong, nonatomic) IBOutlet UIButton *right2;
@property (strong, nonatomic) IBOutlet UITextField *titletText;

@property (strong, nonatomic) IBOutlet UITextField *workHour;
@property (strong, nonatomic) IBOutlet UITextField *pace;

@property (strong, nonatomic) IBOutlet UITextField *keepUser;

@property (strong, nonatomic) IBOutlet UIButton *shareRange;

@property (strong, nonatomic) IBOutlet UICollectionView *shareUserCollectView;


@property (strong, nonatomic) IBOutlet UIView *bodyView;


- (IBAction)bgClick:(id)sender;


- (IBAction)addBtn:(id)sender;

- (IBAction)backBtn:(id)sender;
- (void)rel;
@end
