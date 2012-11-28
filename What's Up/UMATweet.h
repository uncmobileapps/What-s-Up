//
//  UMATweet.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMATweet : NSObject

@property (nonatomic, strong) NSNumber *tweetID;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *proximity;

@end
