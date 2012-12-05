//
//  UMAFeedViewController.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMAFeedViewController.h"
#import "UMATweetViewController.h"
#import "UMAMapViewController.h"
#import "UMANavigationController.h"
#import "UMATweet.h"
#import "UMATwitterController.h"
#import "UMAAppDelegate.h"

@interface UMAFeedViewController () {
    NSMutableArray *_objects;
}

@end

@implementation UMAFeedViewController

@synthesize mapViewController;

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
    // Do any additional setup after loading the view from its nib.]]
   
    
    /**** Uncomment this section to use test data from Coordinates.plist instead of live data ****/
    
    /*
    // Find the Coordinates.plist and save it as an array of dictionaries
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Coordinates" ofType:@"plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSMutableArray *testTweets = [[plistDict objectForKey:@"Coordinates"] mutableCopy];
    
    // Initialize array to store tweets
    NSMutableArray *testUMATweets = [NSMutableArray array];
    
    for (NSDictionary *tweetasdict in testTweets) {
        UMATweet *tweet = [[UMATweet alloc] init];
        tweet.username = [tweetasdict objectForKey:@"username"];
        tweet.latitude = [tweetasdict objectForKey:@"latitude"];
        tweet.longitude = [tweetasdict objectForKey:@"longitude"];
        tweet.proximity = [tweetasdict objectForKey:@"proximity"];
        tweet.tweetID = [tweetasdict objectForKey:@"tweetID"];
        tweet.text = [tweetasdict objectForKey:@"tweet"];
        
        [testUMATweets addObject:tweet];
    }
   
    _objects = testUMATweets;
    */
    
    // Get a reference to our singleton twitter controller instance
    twitterController = [((UMAAppDelegate *)[[UIApplication sharedApplication] delegate]) twitterController];

    // Get the current list of tweets
    _objects = [twitterController getTweetsArray];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToMapInterface:(id)sender {
    
    // We only want to dismiss ourself if we have a reference to the map view controller.
    if (self.navigationController) {
        UMANavigationController *navigationController = (UMANavigationController *)self.navigationController;
        [navigationController.mapViewController dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];

    UILabel *handle = (UILabel *)[tweetCell viewWithTag:1];
    UILabel *tweet = (UILabel *)[tweetCell viewWithTag:2];
    UILabel *proximity = (UILabel *)[tweetCell viewWithTag:3];
    UILabel *time = (UILabel *)[tweetCell viewWithTag:4];
    
//    handle.text = @"username";
//    tweet.text = @"tweeeeeeeet";
//    proximity.text = @"close";
//    time.text = @"10PM";
    
    UMATweet *onetweet = _objects[indexPath.row];
    handle.text = onetweet.username;
    tweet.text = onetweet.text;
    proximity.text = [onetweet.proximity stringValue];
    time.text = @"10pm";
    
    return tweetCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTweet"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UMATweet *atweet = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:atweet];
    }
}

@end
