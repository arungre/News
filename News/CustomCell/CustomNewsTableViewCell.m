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
    if (self)
    {
        // Initialization code
        //Title Label
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)] autorelease];
        self.titleLabel.textColor = [UIColor blueColor];
        self.titleLabel.numberOfLines =0;
        [self.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
        [self addSubview:self.titleLabel];
        
        //Description Label
        self.descriptionLabel = [[[UILabel alloc] init] autorelease];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.numberOfLines=0;
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:self.descriptionLabel];
        
        //Description Label
        self.imageViewref = [[[UIImageView alloc] initWithFrame:CGRectMake(245, 30, 60, 60)] autorelease];
        [self addSubview:self.imageViewref];


    }
    return self;
}

@end
