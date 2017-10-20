//
//  AttachmentCell.h
//  OA
//
//  Created by APPLE on 13-12-25.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachmentCell : UITableViewCell


@property (nonatomic,strong) IBOutlet UILabel * subjectLabel;
 
@property (nonatomic,strong) IBOutlet UILabel * sizeLabel;

@property (nonatomic,strong) IBOutlet UIImageView * priorityIv;

@property (nonatomic,strong) IBOutlet UIImageView * fileTypeIv;



@end
