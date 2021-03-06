//
//  UMATwitterAPI.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UMATwitterController;

@interface UMATwitterAPI : NSObject

- (void)searchTwitterWithLatitude:(float)latitude longitude:(float)longitude radius:(float)radius delegate:(UMATwitterController *)receiver;

@end
