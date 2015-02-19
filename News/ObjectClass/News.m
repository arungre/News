//
//  News.m
//  JSONHandler
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 Dada Beatnik. All rights reserved.
//

#import "News.h"

@implementation News
@synthesize title;
@synthesize descripn;
@synthesize imagRef;
//Extracting dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init])
    {
        self.title=nil;
        self.descripn=nil;
        self.imagRef=nil;
        // Assign all properties with keyed values from the dictionary
        if([jsonDictionary objectForKey:@"title"]!=NULL){
            self.title = [jsonDictionary objectForKey:@"title"];
        }else{
            self.title=[NSString stringWithFormat:@""];
        }
        if([jsonDictionary objectForKey:@"description"]!=NULL){
            self.descripn = [jsonDictionary objectForKey:@"description"];
        }else{
            self.descripn=[NSString stringWithFormat:nil];
        }
        
        if([jsonDictionary objectForKey:@"imageHref"]!=NULL){
            self.imagRef = [jsonDictionary objectForKey:@"imageHref"];
        }else{
            self.imagRef=[NSString stringWithFormat:nil];
        }
        
    }
    
    return [self autorelease];
}
//dealloc method
-(void)dealloc
{
    [super dealloc];
}

@end
