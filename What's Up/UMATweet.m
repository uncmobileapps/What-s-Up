//
//  UMATweet.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMATweet.h"

@implementation UMATweet


@synthesize tweetID;
@synthesize latitude;
@synthesize longitude;
@synthesize text;
@synthesize username;
@synthesize age;
@synthesize proximity;

-(CLLocationCoordinate2D)coordinate {
    
    CLLocationCoordinate2D myCoords;
    myCoords.latitude = self.latitude.doubleValue;
    myCoords.longitude = self.longitude.doubleValue;
    
    return myCoords;
    
}

@end
