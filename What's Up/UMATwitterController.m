//
//  UMATwitterController.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMATwitterController.h"

@implementation UMATwitterController

- (NSArray*)getTweetsArray {
    
    self.searchDone=FALSE;
    
    //get current location coordinates of device from Core Location, and set to deviceLatitude and deviceLongitude
    
    float *deviceLatitude;
    float *deviceLongitude;
    
    //[twitterAPI searchTwitterWithLatitude:deviceLatitude longitude:deviceLongitude radius:10.0 delegate:self];
    
    //that search returns an NSDictionary
    
    while(!self.searchDone) {}
    
    //parse the nasty NSDictionary from Twitter into distinct UMATweet objects
    
    //put each UMATweet object into the array
    NSArray *tweetsArray;
    
    return tweetsArray;
}

@end
