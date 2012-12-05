//
//  UMAFeedViewController.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UMAMapViewController;
@class UMATwitterController;

@interface UMAFeedViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate> {
    
    UMATwitterController *twitterController;
    
}

- (IBAction)returnToMapInterface:(id)sender;

@property (nonatomic, weak) UMAMapViewController *mapViewController;

@end
