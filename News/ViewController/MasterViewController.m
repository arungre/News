//
//  MasterViewController.m
//  News
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 CTS. All rights reserved.
//

#import "MasterViewController.h"
#import "CustomNewsTableViewCell.h"
#import "JSONLoader.h"
#import "News.h"

#define cellIdentifier @"newsCustomCell"
#define ServiceURL @"https://dl.dropboxusercontent.com/s/g41ldl6t0afw9dv/facts.json"
#define kInconvinienceTitle @"Alert"
#define kInconvinienceAlert @"Sorry for inconvinience"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 220.0f
#define CELL_CONTENT_MARGIN 10.0f
#define CELL_TITLEHEIGHT 30.0f
#define CELL_IMAGEHEIGHT 100.0f
#define FONTNAME @"Arial"
#define noImg @"NoImg.png"

@interface MasterViewController ()
{
    NSMutableArray *titlesArray;

}
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
@end

@implementation MasterViewController
#pragma View Life Cycle
//ViewDidLoad method
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"News";
    UIBarButtonItem *refereshButton = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self action:@selector(refreshData:)];
    self.navigationItem.rightBarButtonItem = refereshButton;
    [self refreshData:self];
    [refereshButton release];
    
    
}
#pragma UserDefined Methods
//Referesh the data
-(void)refreshData:(id)sender
{
    
    JSONLoader *jsonLoader = [JSONLoader sharedCenter];
    
    //Remove all array data if exist
    [titlesArray removeAllObjects];
    titlesArray=nil;
    [self.tableView reloadData];
    
    //Adding Activity indicator
    self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    //Request the service using url
    NSURL *URL = [NSURL URLWithString:[ServiceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *requestURL = [[NSURLRequest alloc] initWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:requestURL
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         //stop animating activity indicator
         [self.activityIndicator stopAnimating];
         [self.activityIndicator setHidden:YES];
         
         //If data is null alert will be displayed
         if (data==NULL)
         {
             UIAlertView *alert =[[[UIAlertView alloc]initWithTitle:kInconvinienceTitle message:kInconvinienceAlert delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
             [alert show];
         }
         //parsing the data to jsonloader and save to array
         NSString *jsonString =[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
         titlesArray = [jsonLoader rowsFromJSONData:jsonString];
         [jsonString release];
         
         // Now that we have the data, reload the table data on the main UI thread
         [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
     }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//dealloc method
-(void)dealloc{
    [super dealloc];
}

#pragma mark -
#pragma mark === UITableViewDataSource ===
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //count of the array
    return titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = cellIdentifier;
    //Creating the custom cell
    CustomNewsTableViewCell *cell = (CustomNewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[CustomNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    //Type caste the array and populate the value
    News *news = [titlesArray objectAtIndex:indexPath.row];
    
    //Title of content
    cell.titleLabel.text = news.title;
    
    //Description of content
    if ([news.descripn isEqual:[NSNull null]])
    {
        cell.descriptionLabel.text =@"";
    }else
    {
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:FONTNAME size:FONT_SIZE]};
        
        CGRect rect=[news.descripn boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGFloat height = MAX(rect.size.height, 44.0f);
        height = (height < 110)?110:height;
        
        cell.descriptionLabel.frame=CGRectMake(10, 30, rect.size.width, height+(CELL_CONTENT_MARGIN * 2));
        cell.descriptionLabel.text= news.descripn;
        
    }
    
    
    //image for content
    cell.imageViewref.image = [UIImage imageNamed:noImg];
    
    if (![news.imagRef isEqual:[NSNull null]])
    {

        NSURL *url = [NSURL URLWithString:news.imagRef];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            cell.imageViewref.image = nil;
            /* Fetch the image from the server... */
                UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    /* This is the main thread again, where we set the tableView's image to
                     be what we just fetched. */
                    
                    cell.imageViewref.image = img;
                     [cell.imageViewref setNeedsDisplay];
                    [img release];
                    
                    
                });
        });
    }else
    {
        cell.imageViewref.image = [UIImage imageNamed:noImg];
        
    }
    
    return cell;
}

#pragma mark -
#pragma mark === UITableViewDelegate ===
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    News *news = [titlesArray objectAtIndex:indexPath.row];
    
    //Defining description size
    if (![news.descripn isEqual:[NSNull null]])
    {
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:FONTNAME size:FONT_SIZE]};
        
        CGRect rect=[news.descripn boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGFloat height = MAX(rect.size.height, 44.0f);
        //If description length is less then imageheight redefining the cell height
        height = (height < CELL_IMAGEHEIGHT)?CELL_IMAGEHEIGHT:height;
        
        return CELL_TITLEHEIGHT + height + (CELL_CONTENT_MARGIN * 2);
        
    }
    //if description is null and image is available
    if ([news.descripn isEqual:[NSNull null]] && ![news.imagRef isEqual:[NSNull null]]){
        return CELL_IMAGEHEIGHT;
    }
    if ([news.descripn isEqual:[NSNull null]] && [news.imagRef isEqual:[NSNull null]]){
        return 44;
    }
    return 0;
}


@end
