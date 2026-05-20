//
//  WorkoutsViewController.m
//  Exercise
//
//  Created by raidu on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PredesignedWorkoutsViewController.h"
#import "PredefinedViewController.h"
#import "WorkoutViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
PredesignedWorkoutsViewController  *predesignedWorkout=nil;
@implementation PredesignedWorkoutsViewController

@synthesize exercisestableView;
@synthesize workoutViewController,Workoutname, Workout_id;;
@synthesize  doWorkout;


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
	workoutViewController=[[WorkoutViewController alloc] initWithNibName:@"WorkoutViewController" bundle:[NSBundle mainBundle]];
    [super viewDidLoad];
	predesignedWorkout=self;
	ExercisesName =[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated

{
	
	NSLog(@"id: %d",Workout_id);
	if([ExercisesName count]>0)
	
{
	[ExercisesName removeAllObjects];
}
	[ExercisesName addObjectsFromArray:[self SelectData]];
	[self.exercisestableView reloadData];
}

-(NSArray *)SelectData
{
	
	
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select Exercise.Exercise_Name from Exercise join Workout_Exercise on Exercise.id=Workout_Exercise.Exercise_id where Workout_Exercise.Workout_id=%d",Workout_id];
    NSArray *rows = [db rowsForExpression:Query error:nil];
	[db release];
	return rows;
	
	
}

-(IBAction)pushBackBtn:(id)sender
{
	
	
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)pushDoWorkoutBtn:(id)sender{
	
	[app setWorkout_id:Workout_id];
	[app setIsDirtyThirty:NO];
	[app startTimersUpdated];
	timerextern.isDoWorkout=YES;
    [doWorkout setUserInteractionEnabled:NO];
	//[self.navigationController pushViewController:workoutViewController animated:YES]; 
	//[workoutViewController loadData];
	//[timerextern.SecondsTimer invalidate];
	}

-(IBAction)plusBtn:(id)sender
{
    [self.navigationController pushViewController:workoutViewController animated:YES];
    [workoutViewController loadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return [ExercisesName count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	
	cell.textLabel.text=[[ExercisesName objectAtIndex:indexPath.row] objectForKey:@"Exercise_Name"];;
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    [workoutViewController release];
    [ExercisesName release];
}


@end
