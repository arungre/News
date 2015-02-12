//
//  JSONLoader.m
//  JSONHandler
//
//  Created by Phillipus on 28/10/2013.
//  Copyright (c) 2013 Dada Beatnik. All rights reserved.
//

#import "JSONLoader.h"
#import "News.h"
@implementation JSONLoader

- (NSMutableArray *)rowsFromJSONData:(NSString *)data {
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    // Create a new array to hold the rows
    NSMutableArray *locations=nil;
    [locations autorelease];
    locations = [[NSMutableArray alloc] init];
    // Get an array of dictionaries with the key "rows"
    NSArray *array = [jsonDictionary objectForKey:@"rows"];
    // Iterate through the array of dictionaries
    for(NSDictionary *dict in array) {
        // Create a new title object for each one and initialise it with information in the dictionary
        if ([dict valueForKey:@"title"]!=[NSNull null]) {
            News *news =nil;
            [news autorelease];
            news=[[News alloc] initWithJSONDictionary:dict];
            // Add the Location object to the array
            [locations addObject:news];
        }
    }

    // Return the array of Location objects
    return locations;
}


@end
