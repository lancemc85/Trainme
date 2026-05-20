//
//  WorkoutViewController.m
//  Exercise
//
//  Created by raidu on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WorkoutViewController.h"
#import "SwapViewController.h"
#import "SaveViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
WorkoutViewController *externworkout=nil;
@implementation WorkoutViewController

@synthesize workoutTableView,ExchangeString,isSwap,workoutsdict;;


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
	externworkout=self;
	isSwap=NO;
	workoutsArray=[[NSMutableArray alloc] init];
	save=[[SaveViewController alloc]initWithNibName:@"SaveViewController" bundle:[NSBundle mainBundle]];	
	save.view.frame=CGRectMake(10, 12, 300, 390);
}


-(void)loadData
{
	if([workoutsArray count]>0)
	{
		[workoutsArray removeAllObjects];
	}
	[self SelectData];

	NSLog(@"data: %@",workoutsArray);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[workoutTableView reloadData];
	NSLog(@"data here is: %@",workoutsArray);

}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	
	if(selectedPath)
	{
		UITableViewCell *oldCell = [workoutTableView cellForRowAtIndexPath:selectedPath];
		UIButton *swapBtn = (UIButton *)[oldCell.contentView viewWithTag:selectedPath.row+1];
		[swapBtn removeFromSuperview];
		[oldCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
		
	}
	//[workoutsdict removeAllObjects];
}


-(NSArray *)SelectData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select Exercise.id,Exercise.Exercise_Name from Exercise join Workout_Exercise on Exercise.id=Workout_Exercise.Exercise_id where Workout_Exercise.Workout_id=%d",predesignedWorkout.Workout_id];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	
	NSLog(@"rows: %@",rows);
	[workoutsArray addObjectsFromArray:rows];
	[workoutTableView reloadData];
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
	
    return[workoutsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
	
	cell.textLabel.text=[[workoutsArray objectAtIndex:indexPath.row] objectForKey:@"Exercise_Name"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath

{
	
	if(selectedPath)
	{
		UITableViewCell *oldCell = [workoutTableView cellForRowAtIndexPath:selectedPath];
		UIButton *swapBtn = (UIButton *)[oldCell.contentView viewWithTag:selectedPath.row+1];
		[swapBtn removeFromSuperview];
		[oldCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
		
	}
	
	UITableViewCell *cell = [workoutTableView cellForRowAtIndexPath:indexPath];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(200, 8, 70, 30);
	[button setImage:[UIImage imageNamed:@"swap-button.png"] forState:UIControlStateNormal];
	button.tag=[indexPath row]+1;
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(referenceTime:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:button];
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	
	
	selectedPath = indexPath;
	
		
}
-(void)referenceTime:(id)sender{
	UIButton *button = (UIButton *)sender;
	NSIndexPath *indexPath =[workoutTableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
	//   NSUInteger row = indexPath.row;
	path=indexPath;
	swap=[[SwapViewController alloc]initWithNibName:@"SwapViewController" bundle:[NSBundle mainBundle]];
	swap.swapString=[[workoutsArray objectAtIndex:indexPath.row] objectForKey:@"Exercise_Name"];
	[swap setOwner:self];
	[self.navigationController pushViewController:swap animated:YES];
	[button removeFromSuperview];
}

-(void)swapExerciseWithData:(NSDictionary *)newData
{

	[workoutsArray replaceObjectAtIndex:path.row withObject:newData];
}

-(IBAction)AddMyFaves:(id)sender
{
	if (isSwap) {
	

	save=[[SaveViewController alloc]initWithNibName:@"SaveViewController" bundle:[NSBundle mainBundle]];	
	save.view.frame=CGRectMake(10, 20, 320, 390);
	[save setOwner:self];
	[self.view addSubview:save.view];
	[save saveExercisesAsMYfaves:workoutsArray];
	}
}


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
