//
//  UMAMapViewController.m
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import "UMAMapViewController.h"
#import "UMAFeedViewController.h"
#import "UMATwitterController.h"
#import "UMAAppDelegate.h"

@interface UMAMapViewController ()

@end

#define METERS_PER_MILE 1609.344


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

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self plotPoints];
    
}

-(void)plotPoints {
    
    UMATwitterController *twitterController = [((UMAAppDelegate *)[[UIApplication sharedApplication] delegate]) twitterController];
    NSArray *tweets = [twitterController getTestTweetsArray];
    
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    [_mapView addAnnotations:tweets];
    [UMAMapViewController zoomMapViewToFitAnnotations:_mapView animated:YES];
    
}
#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)

#define ANNOTATION_REGION_PAD_FACTOR 1.15

#define MAX_DEGREES_ARC 360

//size the mapView region to fit its annotations

+ (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated

{
    
    NSArray *annotations = mapView.annotations;
    
    int count = [mapView.annotations count];
    
    if ( count == 0) { return; } //bail if no annotations
    
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    
    MKMapPoint points[count]; //C array of MKMapPoint struct
    
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
        
    {
        
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        
        points[i] = MKMapPointForCoordinate(coordinate);
        
    }
    
    //create MKMapRect from array of MKMapPoint
    
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    
    //convert MKCoordinateRegion from MKMapRect
    
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    
    
    //add padding so pins aren't scrunched on the edges
    
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    
    //but padding can't be bigger than the world
    
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    
    
    //and don't zoom in stupid-close on small samples
    
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    
    if( count == 1 )
        
    {
        
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
        
    }
    
    [mapView setRegion:region animated:animated];
    
}



- (void)viewWillAppear:(BOOL)animated

{
    
    [UMAMapViewController zoomMapViewToFitAnnotations:self.mapView animated:animated];
    
    //or maybe you would do the call above in the code path that sets the annotations array
    
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
