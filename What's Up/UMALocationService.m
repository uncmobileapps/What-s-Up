//
//  UMALocationService.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//


#import "UMALocationService.h"
#import "UMAMapViewController.h"

@implementation UMALocationService

@synthesize locationManager;


-(id)init {
    
    if ((self = [super init])) {
        [self startStandardUpdates];
    }
    
    return self;
}

-(NSDictionary *)currentLocation {
    
    NSDictionary *deviceLocationDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithDouble:deviceLatitude], @"latitude",
                                        [NSNumber numberWithDouble:deviceLongitude], @"longitude",
                                        nil];
    
    return deviceLocationDict;
}

- (void)startStandardUpdates{
    // Create the location manager if object does not already have one.
    if (nil == locationManager){
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = .05; //not sure if this is working
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    deviceLatitude = location.coordinate.latitude;
    deviceLongitude = location.coordinate.longitude;
}
/* NSDate* eventDate = location.timestamp;
 NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
 
 if (abs(howRecent) < 5.0) {
 If the event is recent, do something with it
 latitude = [NSNumber numberWithInteger: (NSInteger)location.coordinate.latitude];
 longitude = [NSNumber numberWithInteger: (NSInteger)location.coordinate.longitude];
 
 }*/



@end
