//
//  meetlistViewCell.h
//  OA
//
//  Created by admin on 16/7/26.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface meetlistViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titile;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *chairPerson;
@property (strong, nonatomic) IBOutlet UILabel *meetRoom;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *notifyStatus;
@property (strong, nonatomic) IBOutlet UILabel *usertype;

@end
