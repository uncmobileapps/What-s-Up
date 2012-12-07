//
//  UMATweetViewController.h
//  What's Up
//
//  Created by Lecture on 11/28/12.
//  Copyright (c) 2012 University of North Carolina - Chapel Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMATweet.h"

@interface UMATweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *handle;
@property (weak, nonatomic) IBOutlet UILabel *tweet;
@property (weak, nonatomic) IBOutlet UILabel *proximity;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) UMATweet *detailItem;

@end
