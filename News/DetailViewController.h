//
//  DetailViewController.h
//  News
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

