//
//  CustomNewsTableViewCell.m
//  JSONHandler
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 Dada Beatnik. All rights reserved.
//

#import "CustomNewsTableViewCell.h"

@implementation CustomNewsTableViewCell

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
