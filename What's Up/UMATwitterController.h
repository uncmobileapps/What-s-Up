//
//  UMATwitterController.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMATwitterController : NSObject

@property (nonatomic, assign) BOOL searchDone;
@property (nonatomic, strong) NSDictionary * twitterResultDict;

/* This method will return the tweets for a given query in the format that we need for this app.

 This is how other controllers can access it:
 UMATwitterController *twController = [[UIApplication mainApplication] twitterController]; 
 NSArray *tweets = [twController getTweetsArray];
*/
- (NSMutableArray*)getTweetsArray;

//UMATwitterAPI calls this within searchTwitterWithLatitude once it gets a result
- (void)searchComplete:(NSDictionary*)twitterResultDict;

@end
