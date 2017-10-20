//
//  MeetCreateViewController.h
//  OA
//
//  Created by admin on 16/7/29.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "RKTabView.h"
@interface MeetCreateViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NIDropDownDelegate,RKTabViewDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextView *meetName;
@property (strong, nonatomic) IBOutlet UILabel *mytitleLabel;
//@property (strong, nonatomic) IBOutlet UITextField *meetName;
@property (strong, nonatomic) IBOutlet UILabel *applicant;
@property (strong, nonatomic) IBOutlet UIButton *meetRoom;
@property (strong, nonatomic) IBOutlet UITextField *startDay;
@property (strong, nonatomic) IBOutlet UITextField *endDay;


@property (strong, nonatomic) IBOutlet UITextView *contact;
@property (strong, nonatomic) IBOutlet UITextField *company;
@property (strong, nonatomic) IBOutlet UIButton *hoster;
@property (strong, nonatomic) IBOutlet UIButton *meetType;
@property (strong, nonatomic) IBOutlet UIButton *summaryUser;
@property (strong, nonatomic) IBOutlet UILabel *meetSer;
@property (strong, nonatomic) IBOutlet UITextField *userNum;

@property (strong, nonatomic) IBOutlet UIScrollView *CreateScrollView;
@property (strong, nonatomic) UICollectionView *joinUserCollectView;
@property (strong, nonatomic) UICollectionView *meetserCollectView;

@property (nonatomic,strong)  RKTabView *titledTabsView;
@property (strong, nonatomic) NSMutableArray *joinUserArry;
@property (strong, nonatomic) NSMutableArray *hosterArry;
@property (strong, nonatomic) NSMutableArray *summaryArry;

@property (strong, nonatomic) UIButton *sendsms;
- (IBAction)bgClick:(id)sender;

- (IBAction)roomClick:(id)sender;


- (IBAction)back:(id)sender;

@end


