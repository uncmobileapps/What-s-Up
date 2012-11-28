//
//  UMAFeedViewController.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UMAMapViewController;

@interface UMAFeedViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

- (IBAction)returnToMapInterface:(id)sender;

@property (nonatomic, weak) UMAMapViewController *mapViewController;

@end
