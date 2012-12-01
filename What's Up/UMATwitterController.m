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
    
    NSMutableArray *tweetsArray = [[NSArray alloc]init];
    NSMutableArray *tweetResultsArray = [twitterResultDict objectForKey:@"statuses"];
    
    for(int i=0; i<[tweetResultsArray count]-1; i++) {
        
        UMATweet *tweetObject = [[UMATweet alloc]init];
        
        NSDictionary *thisTweet = [tweetResultsArray objectAtIndex:i];

        //---------------Latitude and Longitude-----------------------
        // latitude and longitude are nullable in the tweet result we get from Twitter, so we must check if they exist before trying to access them
        
        //NOT SURE IF THIS IS CORRECT
        if ([[[thisTweet objectForKey:@"coordinates"] objectForKey:@"coordinates"] objectAtIndex:1]) {
            
            tweetObject.longitude = [NSNumber numberWithFloat:[[[[thisTweet objectForKey:@"coordinates"] objectForKey:@"coordinates"] objectAtIndex:1]floatValue]];
            tweetObject.latitude = [NSNumber numberWithFloat:[[[[thisTweet objectForKey:@"coordinates"] objectForKey:@"coordinates"] objectAtIndex:0]floatValue]];
        }
        else { //if "coordinates" key is null
            
            //do we want to set these to 0 or just not set them?  Implications? 
            tweetObject.longitude = [NSNumber numberWithFloat:0.0];
            tweetObject.latitude = [NSNumber numberWithFloat:0.0];
        }
        
        //-----------------Tweet Age----------------------------------
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        //    Twitter format: "Wed Aug 27 13:08:45 +0000 2008"
        [dateFormatter setDateFormat:@"EEE LLL d HH:mm:ss Z"];
        
        //convert tweet date from string to NSDate
        NSDate *tweetDate = [dateFormatter dateFromString:[thisTweet objectForKey:@"created_at"]];
        NSTimeInterval tweetAgeInSeconds = [tweetDate timeIntervalSinceNow];
        NSLog(@"Tweet Age: %@",[NSNumber numberWithInt:tweetAgeInSeconds]); //NOT SURE IF THIS IS CORRECT

        //---------------------Set Tweet object properties-----------------------
        tweetObject.tweetID = [NSNumber numberWithLongLong:[thisTweet objectForKey:@"id"]];
        tweetObject.text = [thisTweet objectForKey:@"text"];
        tweetObject.username = [[thisTweet objectForKey:@"user"] objectForKey:@"screen_name"];
        tweetObject.age = [NSNumber numberWithInt:tweetAgeInSeconds];
        //        tweetObject.proximity = [[locationService getProximityInMilesFromDeviceLatitude:deviceLatitude deviceLongitude:deviceLongitude toTweetLatitude:tweetObject.latitude tweetLongitude:tweetObject.longitude] floatValue];
        // latitude and longitude are set above
        
        //add this tweet to the array of all tweets in this results feed
        [tweetsArray addObject:tweetObject];

    } //end for count of tweetResultsArray
    
    return tweetsArray;
}

@end
