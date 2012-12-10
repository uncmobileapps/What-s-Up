//
//  UMATweetViewController.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMATweetViewController.h"
#import "UMATweet.h"
#import "UMAAppDelegate.h"
#import "UMATwitterController.h"


@interface UMATweetViewController ()
- (void)configureView;
@end

@implementation UMATweetViewController
@synthesize handle;
@synthesize tweet;
@synthesize proximity;
@synthesize time;

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
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(UMATweet *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        
        handle.text = [self.detailItem valueForKey:@"username"];
        tweet.text = [self.detailItem valueForKey:@"text"];
        proximity.text = [NSString stringWithFormat:@"%@ feet away", [self.detailItem valueForKey:@"proximity"]];
        time.text = [NSString stringWithFormat:@"%@ seconds ago", [self.detailItem valueForKey:@"age"]];
        
    }
}



- (void)viewDidUnload {
    
    [super viewDidUnload];
}

@end
