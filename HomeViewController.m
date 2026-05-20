//
//  HomeViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "ShuffleViewController.h"
#import "AboutViewController.h"
#import "PredefinedViewController.h"
#import "ExerciseAppDelegate.h"
#import   "TimerViewController.h"
#import "TouchSQL.h"
@implementation HomeViewController

@synthesize   shuffleViewController;
@synthesize   aboutViewController;
@synthesize   aboutPredefinedViewController;
@synthesize  videoView;
@synthesize  DirtyThirtyButton,PredesignedButton;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	shuffleViewController=[[ShuffleViewController alloc]initWithNibName:@"ShuffleViewController" bundle:[NSBundle mainBundle]];
	aboutViewController=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    aboutPredefinedViewController=[[PredefinedViewController alloc]initWithNibName:@"PredefinedViewController" bundle:[NSBundle mainBundle]];
    videoView=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
}



-(IBAction)DirtythirtybtnPressed:(id)sender
{
    [timerextern setDirtyThirtyIndex:DirtyThirtyButton.tag];
   // [timerextern TimerConfiguration];
    [timerextern stopTheTimer];
	[videoView setOwner:self];
    [videoView setExerciseId:0];
    [videoView setButtonindex:DirtyThirtyButton.tag];
    [videoView setExerciseIndex:0];
    [[videoView DOWorkOutBtn] setUserInteractionEnabled:YES];
	[self.navigationController pushViewController:videoView animated:YES];
   
	//[shuffleViewController loadData];
}

-(IBAction)PredefinedbtnPressed:(id)sender
  
{
    	//[self.navigationController pushViewController:videoView animated:YES];
    [timerextern setDirtyThirtyIndex:PredesignedButton.tag];
    [timerextern stopTheTimer];
    aboutPredefinedViewController.Buttonindex=PredesignedButton.tag;
	[self.navigationController pushViewController:aboutPredefinedViewController animated:YES];
}



-(IBAction)AboutbtnPressed:(id)sender
{
	[self.navigationController pushViewController:aboutViewController animated:YES];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [shuffleViewController release];
	[aboutViewController release];
    [aboutPredefinedViewController release];
}


@end
