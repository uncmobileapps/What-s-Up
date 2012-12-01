//
//  UMAAppDelegate.h
//  What's Up
//
//  Created by Chris Davis on 11/8/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <UIKit/UIKit.h>


@class UMATwitterController;

@interface UMAAppDelegate : UIResponder <UIApplicationDelegate> {
    UMATwitterController * _twitterController;
}
@property (nonatomic, readonly) UMATwitterController *twitterController;

@property (strong, nonatomic) UIWindow *window;

@end
