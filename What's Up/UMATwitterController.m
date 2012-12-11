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

- (id)init {
    
    if ((self = [super init])) {
        locationService = [[UMALocationService alloc] init];
    }
    
    return self;
}

- (void)searchComplete:(NSDictionary*)statusesDict {
    
        twitterResultDict = statusesDict;
        self.searchDone=TRUE;
}

//returns array of UMATweet objects
- (NSMutableArray*)getTweetsArray {
    
    self.searchDone=FALSE;
    
    //get current location coordinates of device from Core Location, and set to deviceLatitude and deviceLongitude
    NSDictionary *deviceLocationDict = [locationService currentLocation];
    double deviceLatitude = [[deviceLocationDict objectForKey:@"latitude"] doubleValue];
    double deviceLongitude = [[deviceLocationDict objectForKey:@"longitude"] doubleValue];
    
    UMATwitterAPI *twitterAPI = [[UMATwitterAPI alloc] init];
    [twitterAPI searchTwitterWithLatitude:deviceLatitude longitude:deviceLongitude radius:10.0 delegate:self];
    
    //pause getTweetsArray until it has gotten the statusesDict from TwitterAPI
    while(!self.searchDone) {}
    
    NSMutableArray *tweetsArray = [[NSMutableArray alloc]init];
    NSMutableArray *tweetResultsArray = [twitterResultDict objectForKey:@"statuses"];
    
    //see if there are 0 tweets found
    if([[twitterResultDict objectForKey:@"statuses"] count] == 0){
        
        return nil;
    }
    
    else {
        

    for(int i=0; i<[tweetResultsArray count]-1; i++) {
        
        UMATweet *tweetObject = [[UMATweet alloc]init];

        NSDictionary *thisTweet = [tweetResultsArray objectAtIndex:i];
        
//        NSLog(@"%@",[tweetResultsArray objectAtIndex:i]);

        //---------------Latitude and Longitude-----------------------
        // latitude and longitude are nullable in the tweet result we get from Twitter, so we must check if they exist before trying to access them

        if ([thisTweet objectForKey:@"coordinates"] != [NSNull null]) {
            
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
        [dateFormatter setDateFormat:@"EEE LLL d HH:mm:ss Z y"];
        
        //convert tweet date from string to NSDate
        NSDate *tweetDate = [dateFormatter dateFromString:[thisTweet objectForKey:@"created_at"]];
        NSTimeInterval tweetAgeInSeconds = [tweetDate timeIntervalSinceNow];
//        NSLog(@"Tweet Age: %@",[NSNumber numberWithInt:tweetAgeInSeconds]); //NOT SURE IF THIS IS CORRECT

        //---------------------Set Tweet object properties-----------------------
        tweetObject.tweetID = [NSNumber numberWithLongLong:[thisTweet objectForKey:@"id"]];
        tweetObject.text = [thisTweet objectForKey:@"text"];
        tweetObject.username = [[thisTweet objectForKey:@"user"] objectForKey:@"screen_name"];
        tweetObject.age = [NSNumber numberWithInt:fabs(tweetAgeInSeconds)];
        //tweetObject.proximity = [[locationService getProximityInMilesFromDeviceLatitude:deviceLatitude deviceLongitude:deviceLongitude toTweetLatitude:tweetObject.latitude tweetLongitude:tweetObject.longitude] floatValue];
        
        if ([tweetObject.latitude isEqualToNumber:@0.0f])
            tweetObject.proximity = [NSNumber numberWithFloat:0.0];
        else {
            tweetObject.proximity = [self getProximityInMilesFromDeviceLatitude:deviceLatitude deviceLongitude:deviceLongitude toTweetLatitude:tweetObject.latitude tweetLongitude:tweetObject.longitude];
        }
        // latitude and longitude are set above
        
        //add this tweet to the array of all tweets in this results feed
        [tweetsArray addObject:tweetObject];
        


    } //end for count of tweetResultsArray

    return tweetsArray;
    }
}

- (NSMutableArray*)getTestTweetsArray {
    
    /**** Uncomment this section to use test data from Coordinates.plist instead of live data ****/
    
     // Find the Coordinates.plist and save it as an array of dictionaries
     NSBundle *bundle = [NSBundle mainBundle];
     NSString *plistPath = [bundle pathForResource:@"Coordinates" ofType:@"plist"];
     NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
     NSMutableArray *testTweets = [[plistDict objectForKey:@"Coordinates"] mutableCopy];
     
     // Initialize array to store tweets
     NSMutableArray *testUMATweets = [NSMutableArray array];
    
    NSDictionary *deviceLocationDict = [locationService currentLocation];
    double deviceLatitude = [[deviceLocationDict objectForKey:@"latitude"] doubleValue];
    double deviceLongitude = [[deviceLocationDict objectForKey:@"longitude"] doubleValue];
     
     for (NSDictionary *tweetasdict in testTweets) {
         UMATweet *tweet = [[UMATweet alloc] init];
         tweet.username = [tweetasdict objectForKey:@"username"];
         tweet.latitude = [tweetasdict objectForKey:@"latitude"];
         tweet.longitude = [tweetasdict objectForKey:@"longitude"];
         tweet.proximity = [self getProximityInMilesFromDeviceLatitude:deviceLatitude deviceLongitude:deviceLongitude toTweetLatitude:tweet.latitude tweetLongitude:tweet.longitude];
         tweet.tweetID = [tweetasdict objectForKey:@"tweetID"];
         tweet.text = [tweetasdict objectForKey:@"tweet"];
         tweet.age = [tweetasdict objectForKey:@"age"];
     
         [testUMATweets addObject:tweet];
         
     }
    
    return testUMATweets;
}

- (NSNumber*)getProximityInMilesFromDeviceLatitude:(float)deviceLatitude deviceLongitude:(float)deviceLongitude toTweetLatitude:(NSNumber*)tweetLatitude tweetLongitude:(NSNumber*)tweetLongitude {
    
    //placeholder until this method is updated to actually calculate distance
    NSNumber *distance = [NSNumber numberWithInt:5];
    
    // square root ((lat-lat)^2 + (long-long)^2)
    
    // take difference for lat and long
    float latdiff = deviceLatitude - [tweetLatitude floatValue];
    float longdiff = deviceLongitude - [tweetLongitude floatValue];
    
    // square differences
    float latsquared = powf(latdiff, 2);
    float longsquared = powf(longdiff, 2);
    
    // square root of sum of lat/long and muliply by conversion factor for decimal degrees to km to miles
    float floatmiles = sqrtf(latsquared + longsquared) * (10000 / 90) * .621371;
        
    distance = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%.2f", floatmiles] floatValue]];
    
    
    
    return distance;
    
}

@end
