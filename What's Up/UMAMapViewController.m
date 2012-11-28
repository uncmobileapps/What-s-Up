//
//  UMAMapViewController.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMAMapViewController.h"
#import "UMAFeedViewController.h"

@interface UMAMapViewController ()

@end

@implementation UMAMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // If we're preparing to view the feed interface, we need to assign
    // ourself to the feed view controller so that it can dismiss itself
    // when returning to the map interface.
    if ([[segue identifier] isEqualToString:@"viewFeedSegue"]) {
        UMAFeedViewController *feedViewController = [segue destinationViewController];
        feedViewController.mapViewController = self;
    }
    
}

@end
