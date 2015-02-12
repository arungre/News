//
//  DetailViewController.m
//  News
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 CTS. All rights reserved.
//

#import "DetailViewController.h"
#import "News.h"
@interface DetailViewController ()
@property (retain, nonatomic) IBOutlet UILabel *titleTxt;
@property (retain, nonatomic) IBOutlet UITextView *detailDescriptionLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;            
        // Update the view.
        self.titleTxt = nil;
        self.detailDescriptionLabel=nil;
        self.imageView=nil;
        
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        News *detailNews=_detailItem;
        self.titleTxt.text=detailNews.title;
        if ([detailNews.descripn isEqual:[NSNull null]]) {
            self.detailDescriptionLabel.text =@"";
        }else{
            self.detailDescriptionLabel.text = detailNews.descripn;
        }

        self.imageView.image = [UIImage imageNamed:@"NoImg.png"];
        
        if (![detailNews.imagRef isEqual:[NSNull null]]) {
            self.imageView.image = [UIImage imageNamed:@"NoImg.png"];
            NSURL *url = [NSURL URLWithString:detailNews.imagRef];
            dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(q, ^{
                /* Fetch the image from the server... */
                
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *img = [[UIImage alloc] initWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    /* This is the main thread again, where we set the tableView's image to
                     
                     be what we just fetched. */
                    
                    self.imageView.image = img;
                    [img release];
                });
                
            });
        }else{
            self.imageView.image = [UIImage imageNamed:@"NoImg.png"];
            
        }

    
    }
}
#pragma ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    [super viewDidUnload];
    self.titleTxt=nil;
    self.detailDescriptionLabel=nil;
    self.imageView =nil;
}
-(void)dealloc{
    [super dealloc];
}

@end
