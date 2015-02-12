//
//  MasterViewController.m
//  News
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 CTS. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CustomNewsTableViewCell.h"
#import "JSONLoader.h"
#import "News.h"

#define cellIdentifier @"newsCustomCell"
#define ServiceURL @"https://dl.dropboxusercontent.com/s/g41ldl6t0afw9dv/facts.json"

@interface MasterViewController ()
{
    NSMutableArray *_locations;

}
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation MasterViewController
#pragma View Life Cycle
//ViewDidLoad method
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self action:@selector(refreshData:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    [self refreshData:self];
    
    
}
#pragma UserDefined Methods
//Referesh the data
-(void)refreshData:(id)sender{
    JSONLoader *jsonLoader = [[JSONLoader alloc] init];
    if (self.activityIndicator==nil) {
        [self.view addSubview:self.activityIndicator];
    }
    
    [self.activityIndicator startAnimating];
    NSURL *URL = [NSURL URLWithString:[ServiceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *requestURL = [[NSURLRequest alloc] initWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:requestURL
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         [self.activityIndicator stopAnimating];
         [self.activityIndicator removeFromSuperview];
         
         NSString *jsonString =[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
         if (data==NULL) {
             UIAlertView *alert =[[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Sorry for inconvinience" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
             [alert show];
         }
         _locations = [jsonLoader rowsFromJSONData:jsonString];
         
         // Now that we have the data, reload the table data on the main UI thread
         [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
     }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        News *newsObject =[_locations objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:newsObject];
    }
}

#pragma mark - Table View
#pragma mark - Table View Controller Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = cellIdentifier;
    
    CustomNewsTableViewCell *cell = (CustomNewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //NSDate *object = _objects[indexPath.row];
    
    if(cell == nil)
    {
        cell = [[[CustomNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        // expected identifier
    }
    
    News *news = [_locations objectAtIndex:indexPath.row];
    
    cell.titleLbl.text = news.title;
    if ([news.descripn isEqual:[NSNull null]]) {
        cell.descriptionLbl.text =@"";
    }else{
        cell.descriptionLbl.text= news.descripn;
    }
    cell.imageViewref.image = [UIImage imageNamed:@"NoImg.png"];
    
    if (![news.imagRef isEqual:[NSNull null]]) {
        NSURL *url = [NSURL URLWithString:news.imagRef];
        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(q, ^{
            /* Fetch the image from the server... */
            
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /* This is the main thread again, where we set the tableView's image to
                 
                 be what we just fetched. */
                
                cell.imageViewref.image = img;
                [img release];
            });
            
        });
    }else{
        cell.imageViewref.image = [UIImage imageNamed:@"NoImg.png"];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 100;
}


@end
