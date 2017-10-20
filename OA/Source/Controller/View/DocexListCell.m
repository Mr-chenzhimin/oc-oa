//
//  DocexListCell.m
//  hongdabaopo
//
//  Created by admin on 14-7-29.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexListCell.h"

@implementation DocexListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
