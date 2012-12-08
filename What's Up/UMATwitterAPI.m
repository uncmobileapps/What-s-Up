//
//  UMATwitterAPI.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMATwitterAPI.h"
#import "UMATwitterController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>


@implementation UMATwitterAPI

//for the data model
- (void)searchTwitterWithLatitude:(float)latitude
                        longitude:(float)longitude
                           radius:(float)radius
                         delegate:(UMATwitterController *)receiver {
    // setting values manually for testing
    //latitude = 37.781157f;
    //longitude = -122.398720f;
    //radius = 10.0f;
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        
        //if account authenticates
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            if (accounts.count) {
                
                //if user has multiple Twitter accounts, use the first one
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                
                //piece together the parameter value for the geocode parameter
                NSString *geoCodeParam = [NSString stringWithFormat:@"%f,%f,%fmi", latitude, longitude, radius];

//                NSLog(@"%@", geoCodeParam);
                
                //set search params
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//                 [parameters setObject:@"chapel hill" forKey:@"q"];
                [parameters setObject:geoCodeParam forKey:@"geocode"];
                // [parameters setObject:@"50" forKey:@"count"];  // by default, we should get 15 results
                
                //send search request to Twitter
                TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:parameters requestMethod:TWRequestMethodGET];
                [request setAccount:twitterAccount];
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    
                    //if Twitter responds and we have a value for responseData
                    if (responseData) {
                        NSError *error = nil;
                        
                        //set dataSource array to the Twitter JSON feed
                        NSMutableDictionary *statusesDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                        
                        /** Uncomment this block if you want to see the json version of the twitter search results 
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:statusesDict
                                                                           options:NSJSONWritingPrettyPrinted error:&error];
                        NSString *showmejson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        NSLog(@"%@", showmejson);
                        NSLog(@"Number of results: %d", [[statusesDict allKeys] count]);
                        **/
                        
                        
                        /*** Tell data model we're done searching and send results ***/
                        [receiver searchComplete:statusesDict];
                    
                        
//                        if (self.dataSource) {
//                            [self.tableView reloadData];
                            
                            //show tableview and hide activityIndicator
//                            [self.tableView setHidden:NO];
//                            [self.activityIndicatorView stopAnimating];
//                        } else {
//                            NSLog(@"Error %@ with user info %@.", error, error.userInfo);
//                        }
                        
                    } //end if(responseData)
                }]; //end performRequestWithHandler
            } //end if accounts.count
        } //end if granted
        else {
            NSLog(@"The user does not grant us permission to access its Twitter account(s).");
        }
    }]; // end requestAccessToAccountsWithType

    
}


@end