//
//  UMAMapViewController.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface UMAMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

+ (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated;

@end
