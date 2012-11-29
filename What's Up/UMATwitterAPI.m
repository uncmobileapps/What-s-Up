//
//  UMATwitterAPI.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMATwitterAPI.h"
#import "UMALocationService.h"
#import "UMATwitterController.h"


@implementation UMATwitterAPI

//method for getting location-based query via core location data

-findLocation{
    
    
    
}



- (void)searchTwitterWithLatitude:(float)latitude
                        longitude:(float)longitude
                           radius:(float)radius
                         delegate:(UMATwitterController *)receiver {
    
}




ACAccountStore *accountStore = [[ACAccountStore alloc] init];
ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
[accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
    
    //if account authenticates
    if (granted) {
        NSArray *accounts = [accountStore accountsWithAccountType:accountType];
        if (accounts.count) {
            
            //twitter api calls -(void)searchComplete:NSDictionary *dict)
            
            
            
            //if user has multiple Twitter accounts, use the first one
            ACAccount *twitterAccount = [accounts objectAtIndex:0];
            NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
            
            //set search params
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            [parameters setObject:queryText forKey:@"q"];
            [parameters setObject:latitude, longitude, radius forKey:@"geocode"];
            [parameters setObject:@"5" forKey:@"count"];
            
            
            
            TWRequest *request [[TWRequest alloc] initWithURL: url parameters requestMethod:
                                TWRequestMethodGET];
            [request setAccount:twitterAccount];
            [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError * error) ] {
                // handler code
                //if Twitter responds and we have a value for responseData
                
                //set dataSource array to the Twitter JSON feed
                NSMutableDictionary *statusesDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                
                self.dataSource = [statusesDict objectForKey:@"statuses"];
                NSLog(@"number of tweets: %d",self.dataSource.count);
                
                if(responseData){
                    
                    NSError *error = nil;
                    searchComplete(statusesDict);
                }
                
                
                
                
                
                //twitter controller
            } //end if(responseData)
        }]; //end performRequestWithHandler
    } //end if accounts.count
} //end if granted
 else {
     NSLog(@"The user does not grant us permission to access its Twitter account(s).");
 }
 
 
 //separate method for dataModel, i.e., searchComplete, contains dictionary of tweets
 
 
 }]; // end requestAccessToAccountsWithType
}


@end