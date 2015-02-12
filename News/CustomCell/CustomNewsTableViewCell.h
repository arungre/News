//
//  CustomNewsTableViewCell.h
//  JSONHandler
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 Dada Beatnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNewsTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UILabel *descriptionLbl;
@property(nonatomic,retain)IBOutlet UIImageView *imageViewref;

@end
