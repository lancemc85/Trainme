//
//  HomeViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuffleViewController.h"
#import "AboutViewController.h"
#import "PredefinedViewController.h"
#import "videoViewController.h"

@interface HomeViewController : UIViewController {
	
	ShuffleViewController *shuffleViewController;
    AboutViewController   *aboutViewController;
	PredefinedViewController *aboutPredefinedViewController;
    videoViewController *videoView;
    IBOutlet UIButton *DirtyThirtyButton;
    IBOutlet UIButton *PredesignedButton;
}

@property(nonatomic,retain)	ShuffleViewController *shuffleViewController;
@property(nonatomic,retain) AboutViewController   *aboutViewController;
@property(nonatomic,retain)	PredefinedViewController *aboutPredefinedViewController;
@property(nonatomic,retain) videoViewController *videoView;
@property(nonatomic,retain) IBOutlet UIButton *DirtyThirtyButton;
@property(nonatomic,retain) IBOutlet UIButton *PredesignedButton;


-(IBAction)DirtythirtybtnPressed:(id)sender;
-(IBAction)PredefinedbtnPressed:(id)sender;
-(IBAction)AboutbtnPressed:(id)sender;


@end
