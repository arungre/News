//
//  News.h
//  JSONHandler
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 Dada Beatnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *descripn;
@property (nonatomic,retain) NSString *imagRef;

@end
