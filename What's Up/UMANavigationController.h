//
//  UMANavigationControllerViewController.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UMAMapViewController;

@interface UMANavigationController : UINavigationController

@property (nonatomic, weak) UMAMapViewController *mapViewController;

@end
