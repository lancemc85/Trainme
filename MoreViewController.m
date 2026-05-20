//
//  MoreViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "SettingsViewController.h"
#import "MyMeasurementsViewController.h"
#import "WeightCalculatorViewController.h"
#import "BodyFatViewController.h"
#import "BMRViewController.h"
#import "MyFoodLogViewController.h"
#import "LinksViewController.h"

@implementation MoreViewController

@synthesize moreTabTableView;
@synthesize settingsViewController;
@synthesize myMeasurementsViewController;
@synthesize weightCalculatorViewController;
@synthesize bodyFatViewController;
@synthesize bMRViewController;
@synthesize myFoodLogViewController;
@synthesize linksViewController;
@synthesize reportViewController;



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
    
	contents=[[NSArray alloc]initWithObjects:@"Settings",
					   @"My Measurements",
					   @"Weight Calculator",
					   @"Body Fat",
					   @"Basal Metabolic Rate(BMR)",
					   @"My Food Log",
					   @"Links",
			           @"Reports",nil];
	
	settingsViewController        =[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
	myMeasurementsViewController  =[[MyMeasurementsViewController alloc] initWithNibName:@"MyMeasurementsViewController" bundle:[NSBundle mainBundle]];	
	weightCalculatorViewController=[[WeightCalculatorViewController alloc] initWithNibName:@"WeightCalculatorViewController" bundle:[NSBundle mainBundle]];
	bodyFatViewController         =[[BodyFatViewController alloc] initWithNibName:@"BodyFatViewController" bundle:[NSBundle mainBundle]];
	bMRViewController             =[[BMRViewController alloc] initWithNibName:@"BMRViewController" bundle:[NSBundle mainBundle]];
	myFoodLogViewController       =[[MyFoodLogViewController alloc] initWithNibName:@"MyFoodLogViewController" bundle:[NSBundle mainBundle]];
	linksViewController           =[[LinksViewController alloc] initWithNibName:@"LinksViewController" bundle:[NSBundle mainBundle]];
	reportViewController          =[[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:[NSBundle mainBundle]];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contents count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text=[contents objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont fontWithName:@"Skia Bold" size:24];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
	{
		case 0:
			[self.navigationController pushViewController:settingsViewController animated:YES];
			break;
		case 1:
			[self.navigationController pushViewController:myMeasurementsViewController animated:YES];
			break;
		case 2:
			[self.navigationController pushViewController:weightCalculatorViewController animated:YES];
			break;
		case 3:
		    [self.navigationController pushViewController:bodyFatViewController animated:YES];
		    break;
		case 4:
			[self.navigationController pushViewController:bMRViewController animated:YES];
			break;
		case 5:
			[self.navigationController pushViewController:myFoodLogViewController animated:YES];
			break;
		case 6:
			[self.navigationController pushViewController:linksViewController animated:YES];
			break;
		case 7:
			[self.navigationController pushViewController:reportViewController animated:YES];
			break;
		default:
			break;
	}	
	
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
}


@end
