//
//  DocexOptionCell.m
//  hongdabaopo
//
//  Created by admin on 14-8-1.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexOptionCell.h"

@implementation DocexOptionCell

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
