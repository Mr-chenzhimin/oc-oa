//
//  NoticeListCell.h
//  OA
//
//  Created by dengfan on 13-12-15.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeListCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * subjectLabel;

@property (nonatomic,strong) IBOutlet UILabel * usernameLabel;

@property (nonatomic,strong) IBOutlet UILabel * timeLabel;

@property (nonatomic,strong) IBOutlet UIImageView * attachmentImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemback;

@end
