//
//  UMATwitterController.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMATwitterController.h"
#import "UMATweet.h"
#import "UMATwitterAPI.h"
#import "UMALocationService.h"

@implementation UMATwitterController

@synthesize twitterResultDict;

- (void)searchComplete:(NSDictionary*)statusesDict {
    
    if(twitterResultDict) {
        twitterResultDict = statusesDict;
        self.searchDone=TRUE;
    }
}

//returns array of UMATweet objects
- (NSArray*)getTweetsArray {
    
    self.searchDone=FALSE;
    
    //get current location coordinates of device from Core Location, and set to deviceLatitude and deviceLongitude
    UMALocationService *locationService = [[UMALocationService alloc]init];
    //NSDictionary *deviceLocationDict = [locationService currentLocation];
    //float *deviceLatitude = [deviceLocationDict objectForKey:@"latitude"];
    //float *deviceLongitude = [deviceLocationDict objectForKey:@"longitude"];
    
//    UMATwitterAPI *twitterAPI = [[UMATwitterAPI alloc] init];
//    [twitterAPI searchTwitterWithLatitude:deviceLatitude longitude:deviceLongitude radius:10.0 delegate:self];
    
    //pause getTweetsArray until it has gotten the statusesDict from TwitterAPI
    while(!self.searchDone) {}
    
    NSArray *tweetsArray = [[NSArray alloc]init];
    
    //parse the NSDictionary from Twitter into distinct UMATweet objects
    NSMutableArray *tweetResultsArray = [twitterResultDict objectForKey:@"statuses"];
    
    //loop through each tweet dictionary and put relevant info into UMATweet object. Then, load UMATweet objects into array.
    for(int i=0; i<[tweetResultsArray count]-1; i++) {
        
        UMATweet *tweetObject = [[UMATweet alloc]init];
        
        NSDictionary *thisTweet = [tweetResultsArray objectAtIndex:i];
        tweetObject.tweetID = [NSNumber numberWithLongLong:[thisTweet objectForKey:@"id"]];
        tweetObject.text = [thisTweet objectForKey:@"text"];
        tweetObject.username = [[thisTweet objectForKey:@"user"] objectForKey:@"screen_name"];
        
        /*
         
         INCOMPLETE - check if this tweet has coordinates or if that key is null!
         
         latitude and longitude are nullable in the tweet result we get from Twitter, so we must check if they exist before trying to access them
         */
        tweetObject.latitude = [NSNumber numberWithFloat:[[[[thisTweet objectForKey:@"coordinates"] objectForKey:@"coordinates"] objectAtIndex:1]floatValue]];
        tweetObject.latitude = [NSNumber numberWithFloat:[[[[thisTweet objectForKey:@"coordinates"] objectForKey:@"coordinates"] objectAtIndex:0]floatValue]];
        
        //calculate the age of the tweet (how long ago it was tweeted, relative to current time)
        //Twitter format: "Wed Aug 27 13:08:45 +0000 2008"
        
        //set up a date formatter to specify the format
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE LLL d HH:mm:ss Z"];
        
        //convert tweet date from string to NSDate
        NSDate *tweetDate = [dateFormatter dateFromString:[thisTweet objectForKey:@"created_at"]];
        NSTimeInterval tweetAgeInSeconds = [tweetDate timeIntervalSinceNow];
        
        tweetObject.age = [NSNumber numberWithInt:tweetAgeInSeconds];
        
        NSLog(@"Tweet Age: %@",tweetObject.age); //NOT SURE IF THIS IS CORRECT
        
        //get the proximity of the tweet (how many miles (float) from device location was the tweet sent?)
//        tweetObject.proximity = [[locationService getProximityInMilesFromDeviceLatitude:deviceLatitude deviceLongitude:deviceLongitude toTweetLatitude:tweetObject.latitude tweetLongitude:tweetObject.longitude] floatValue];

        //add this tweet to the array of all tweets in this results feed
        [tweetResultsArray addObject:tweetObject];

    } //end for count of tweetResultsArray
    
    return tweetsArray;
}

@end
