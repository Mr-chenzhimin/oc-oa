//
//  DocexOptionCell.h
//  hongdabaopo
//
//  Created by admin on 14-8-1.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocexOptionCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * titlelbl;

@property (nonatomic,strong) IBOutlet UILabel * usernamelbl;

@property (nonatomic,strong) IBOutlet UILabel * timelbl;

@property (nonatomic,strong) IBOutlet UIImageView * headImage;

@property (weak, nonatomic) IBOutlet UIButton *attatchbtn;


@end
