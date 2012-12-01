//
//  UMATweet.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMATweet : NSObject

/*
 tweetID: 000000000000000000
 latitude: 43.000012
 longitude: -73.020483
 text: “I’m at #TopO for my birthday!”
 username: “sammy234”
 age: “93”
 proximity: “1.23”

Accessing these:
 tweetID: [tweetID numberWithLong:9999999999999999]
 latitude and longitude: [latitude floatValue]
 text: just a string
 age (in seconds): [age intValue]
 proximity (in fractions of a mile): [proximity floatValue]
 
*/

@property (nonatomic, strong) NSNumber *tweetID;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *proximity;

@end
