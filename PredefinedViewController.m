//
//  AboutPredefinedViewController.m
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PredefinedViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
#import   "TimerViewController.h"
PredefinedViewController *predefinedextern=nil;

@implementation PredefinedViewController

@synthesize predefinedTrainerTableView;
@synthesize predefinedMyFavesTableView;
@synthesize predesignedWorkoutsViewController;
@synthesize indexnumber;
@synthesize MytrainerContents,saveRtnString;
@synthesize videoView;
@synthesize Buttonindex;



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
	
	predefinedextern=self;
	MytrainerContents=[[NSMutableArray alloc]init];
    trainerArray=[[NSMutableArray alloc]initWithArray:[self SelectTrainerData]];
	MyfavesContents=[[NSMutableArray alloc]init];
    predesignedWorkoutsViewController=[[PredesignedWorkoutsViewController alloc]initWithNibName:@"PredesignedWorkoutsViewController" bundle:[NSBundle mainBundle]];
    videoView=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	if([MyfavesContents count]>0)
	{
		[MyfavesContents removeAllObjects];
    }
	
    [MyfavesContents addObjectsFromArray:[self SelectMyData]];
	NSLog(@"%@",MyfavesContents);
    [predefinedMyFavesTableView reloadData];
}

-(NSArray *)SelectTrainerData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	
	NSError *err = NULL;
	NSArray *rows = [db rowsForExpression:@"SELECT * FROM WorkOut WHERE Faves_type='Trainer'" error:&err];
    [db release];
	return rows;
}

-(NSArray *)SelectMyData
{
    CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
    
    [db open:NULL];
    
    NSError *err = NULL;
    NSArray *rows = [db rowsForExpression:@"SELECT * FROM WorkOut WHERE Faves_type='My'" error:&err];
    [db release];
    return rows;
}
					 


-(IBAction)pushBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	if(tableView==predefinedTrainerTableView)
	{
	    return [trainerArray count];
	}
	if(tableView==predefinedMyFavesTableView)
	{
	   return [MyfavesContents count];
	}
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if(tableView==predefinedTrainerTableView)
	{
	   cell.textLabel.text=[[trainerArray objectAtIndex:indexPath.row] objectForKey:@"Workout_Name"];
	}
	if(tableView==predefinedMyFavesTableView)
	{
		cell.textLabel.text=[[MyfavesContents objectAtIndex:indexPath.row] objectForKey:@"Workout_Name"];
	}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [[predesignedWorkout doWorkout]setUserInteractionEnabled:YES];
	if(tableView==predefinedTrainerTableView)
	{
		indexnumber=indexPath.row;
        videoView.Workout_id=[[[trainerArray objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
        
		 	}
	
	if(tableView==predefinedMyFavesTableView)
	{
		indexnumber=indexPath.row;
//		predesignedWorkoutsViewController.Workout_id=[[[MyfavesContents objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
//		[self.navigationController pushViewController:predesignedWorkoutsViewController animated:YES]
        ;
       
        videoView.Workout_id=[[[MyfavesContents objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
        
	}
	
	[videoView setOwner:self];
    [videoView setExerciseId:0];
    [videoView setButtonindex:Buttonindex];
    [videoView setExerciseIndex:0];
    [[videoView DOWorkOutBtn] setUserInteractionEnabled:YES];
    [self.navigationController pushViewController:videoView animated:YES];
    
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
    [MytrainerContents release];
    [trainerArray release];
	[MyfavesContents release];
    [predesignedWorkoutsViewController release];
}


@end
