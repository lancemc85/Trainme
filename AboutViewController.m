//
//  AboutViewController.m
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutDirtyThirtyViewController.h"
#import "AboutPredefinedViewController.h"

@implementation AboutViewController

@synthesize Abouttextview;
@synthesize aboutDirtyThirtyViewController;
@synthesize aboutPredefinedViewController;


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
	aboutDirtyThirtyViewController=
	[[AboutDirtyThirtyViewController alloc] initWithNibName:@"AboutDirtyThirtyViewController" bundle:[NSBundle mainBundle]];
    
	aboutPredefinedViewController =
	[[AboutPredefinedViewController alloc] initWithNibName:@"AboutPredefinedViewController" bundle:[NSBundle mainBundle]];
}



-(IBAction)dirtyThirtyBtnPressed:(id)sender
{
	[self.navigationController pushViewController:aboutDirtyThirtyViewController animated:YES];
}

-(IBAction)predefinedBtnPressed:(id)sender
{
	[self.navigationController pushViewController:aboutPredefinedViewController animated:YES];
}

-(IBAction)pushBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
	[aboutDirtyThirtyViewController release];
	[aboutPredefinedViewController release];


}


@end
