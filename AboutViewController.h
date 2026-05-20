//
//  AboutViewController.h
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutDirtyThirtyViewController.h"
#import "AboutPredefinedViewController.h"


@interface AboutViewController : UIViewController {
	
	UITextView *Abouttextview;
	AboutDirtyThirtyViewController *aboutDirtyThirtyViewController;
    AboutPredefinedViewController  *aboutPredefinedViewController;
}

@property(nonatomic,retain)IBOutlet UITextView *Abouttextview;
@property(nonatomic,retain)	AboutDirtyThirtyViewController *aboutDirtyThirtyViewController;
@property(nonatomic,retain) AboutPredefinedViewController  *aboutPredefinedViewController;

-(IBAction)dirtyThirtyBtnPressed:(id)sender;
-(IBAction)predefinedBtnPressed:(id)sender;
-(IBAction)pushBackBtn:(id)sender;


@end
