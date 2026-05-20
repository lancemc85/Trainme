//
//  SaveViewController.m
//  Exercise
//
//  Created by Dev Team on 2/8/11.
//  Copyright 2011 CopperMobile Inc. All rights reserved.
//

#import "SaveViewController.h"
#import "PredesignedWorkoutsViewController.h"
#import "WorkoutViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
@implementation SaveViewController
@synthesize owner,isDirtythirty;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	savedWorkouts=[[NSMutableArray alloc]init];
	self.view.frame=CGRectMake(10, 12, 300, 390);
	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	if([savedWorkouts count]>0)
		
	{
		[savedWorkouts removeAllObjects];
	}
	[savedWorkouts addObjectsFromArray:[self SelectData]];
	[saveTableView reloadData];
	[self SelectData];
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)pushBackBtn:(id)sender
{
	[self.view removeFromSuperview];
}

-(NSArray *)SelectData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select Workout_Name from WorkOut where Faves_type='My'"];
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"%@",rows);
	return rows;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return [savedWorkouts count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.text=[[savedWorkouts objectAtIndex:indexPath.row] objectForKey:@"Workout_Name"];
	
		return cell;
}

-(IBAction)saveMyFaves:(id)sender{
	
	
    
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
    
    [db open:NULL];
   
    
    BOOL result;
    NSString *Query = [NSString stringWithFormat:@"INSERT INTO WorkOut(Workout_Name,Faves_type) VALUES ('Workout %d','My')",[savedWorkouts count]+1];
    result=[db executeExpression:Query error:NULL];
    if(result)
    {
        NSLog(@"save Arr is %d",[saveArray count]);
		for (int i=0; i<[saveArray count];i++)
		{
            NSString *Query ;
         //for DirtyThirty Workouts.............
         
            if(isDirtythirty)
           {
               NSString *tempString = [[NSUserDefaults standardUserDefaults]valueForKey:@"REPETION"];
               if(tempString==NULL)
               {
                if([[saveArray objectAtIndex:i] objectForKey:@"isCardio"] ==[NSNull null])
                {
                    Query= [NSString stringWithFormat:@"INSERT INTO Workout_Exercise(Workout_id,Exercise_id,REPS,IsWorkoutCardio) VALUES ((select max(id) from WorkOut),%d,%@,%@)",[[[saveArray objectAtIndex:i] objectForKey:@"id"] intValue],NULL,NULL]; 
                }
                   else
                   {
                       Query= [NSString stringWithFormat:@"INSERT INTO Workout_Exercise(Workout_id,Exercise_id,REPS,IsWorkoutCardio) VALUES ((select max(id) from WorkOut),%d,%@,%@)",[[[saveArray objectAtIndex:i] objectForKey:@"id"] intValue],NULL,@"1"]; 
                       
                   }}
               else
               {
                   if([[saveArray objectAtIndex:i] objectForKey:@"isCardio"] ==[NSNull null])
                   {
                       Query= [NSString stringWithFormat:@"INSERT INTO Workout_Exercise(Workout_id,Exercise_id,REPS,IsWorkoutCardio) VALUES ((select max(id) from WorkOut),%d,%@,%@)",[[[saveArray objectAtIndex:i] objectForKey:@"id"] intValue],tempString,NULL]; 
                   }
                   else
                   {
                       Query= [NSString stringWithFormat:@"INSERT INTO Workout_Exercise(Workout_id,Exercise_id,REPS,IsWorkoutCardio) VALUES ((select max(id) from WorkOut),%d,%@,%@)",[[[saveArray objectAtIndex:i] objectForKey:@"id"] intValue],tempString,@"1"]; 
                       
                   }}

            }
        //for predefined Workouts.............    
           else
            {
            NSLog(@"save is %@",[[saveArray objectAtIndex:i] objectForKey:@"IsWorkoutCardio"]);
            if([[saveArray objectAtIndex:i] objectForKey:@"IsWorkoutCardio"] ==[NSNull null])
            {
               
         Query= [NSString stringWithFormat:@"INSERT INTO Workout_Exercise(Workout_id,Exercise_id,REPS,IsWorkoutCardio) VALUES ((select max(id) from WorkOut),%d,%@,%@)",[[[saveArray objectAtIndex:i] objectForKey:@"id"] intValue],[[saveArray objectAtIndex:i] objectForKey:@"REPS"],NULL];
        }
            else
            {
                 Query= [NSString stringWithFormat:@"INSERT INTO Workout_Exercise(Workout_id,Exercise_id,REPS,IsWorkoutCardio) VALUES ((select max(id) from WorkOut),%d,%@,%@)",[[[saveArray objectAtIndex:i] objectForKey:@"id"] intValue],NULL,@"1"];
            }
           
            }
result=[db executeExpression:Query error:NULL];
            
			
		}
	}
		
		[owner setIsSwap:NO];
	
	
	[self.view removeFromSuperview];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)saveExercisesAsMYfaves:(NSArray *)NewArr
{
  saveArray=[[NSMutableArray alloc]initWithArray:NewArr];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [saveArray release];
	[savedWorkouts release];
}


@end
