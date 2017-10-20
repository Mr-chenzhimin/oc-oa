//
//  AppListViewController.h
//  OA
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *TopMenuView;
@property (strong, nonatomic) IBOutlet UILabel *MyTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *RefreshBtn;
@property (strong, nonatomic) IBOutlet UIButton *BackBtn;
@property (strong, nonatomic) IBOutlet UICollectionView *AppCollectView;

- (IBAction)backBtn:(id)sender;


@property (strong, nonatomic)NSMutableArray *listData;// 数据源
@property (assign, nonatomic) NSInteger type;
@end
