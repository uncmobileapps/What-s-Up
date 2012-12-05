//
//  UMALocationService.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UMATweet.h"


@interface UMALocationService : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    
    double deviceLatitude;
    double deviceLongitude;

}

@property (nonatomic, strong) CLLocationManager *locationManager;

-(NSDictionary*)currentLocation;

@end