//
//  ShuffleViewController.m
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShuffleViewController.h"
#import "SwapViewController.h"
#import "SaveViewController.h"
#import "ExerciseAppDelegate.h"
#import "TimerViewController.h"
#import "TouchSQL.h"

ShuffleViewController *externshuffle=nil;

@implementation ShuffleViewController
@synthesize ExchangeString,isSwap;
@synthesize shuffleTable,owner;
@synthesize videoController;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	isSwap=NO;
	externshuffle=self;
	shuffleArray=[[NSMutableArray alloc]init];
    BodypartArr=[[NSMutableArray alloc]init];
	timer=[[TimerViewController alloc]initWithNibName:@"TimerViewController" bundle:[NSBundle mainBundle]];
	}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([BodypartArr count]>0)
		
	{
		[BodypartArr removeAllObjects];
	}
	[shuffleTable reloadData]; 
}


-(void)loadData
{
	
if([shuffleArray count]>0)
		
	{
		[shuffleArray removeAllObjects];
	}
	
	
	
	[self SelectData];
	
	}


-(NSArray *)SelectData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [self getRandomExerciseQuery];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	
	NSLog(@"rows: %@",rows);
	[shuffleArray addObjectsFromArray:rows];
	[shuffleTable reloadData];
	
	return rows;
}

-(NSString *)getRandomExerciseQuery
{
    NSMutableString *query = [[NSMutableString alloc] init];
    for (int idx=0; idx < 13; idx++)
    {
        if(idx > 0)
            [query appendString:@" UNION ALL "];
        if((idx % 2) == 0)
        {
            [query appendString:@"select * from (SELECT * FROM Exercise AS e INNER JOIN Exercise_BodyPart AS eb on eb.Exercise_id = e.id WHERE eb.BodyPart_id= "];
            switch (idx)
            {
                case 0: [query appendString:@"9"]; break;
                case 2: [query appendString:@"6"]; break;
                case 4: [query appendString:@"1"]; break;
                case 6: [query appendString:@"3"]; break;
                case 8: [query appendString:@"10"]; break;
                case 10: [query appendString:@"4"]; break;
                case 12: [query appendString:@"2"]; break;
                    
                    
            }
            [query appendString:@" AND e.isCardio isNull ORDER BY RANDOM() LIMIT 1)"];
        }
        else
        {
            [query appendString:@"select * from (SELECT * FROM Exercise AS e INNER JOIN Exercise_BodyPart AS eb on eb.Exercise_id = e.id WHERE e.isCardio=1 ORDER BY RANDOM() LIMIT 1)"];
        }
    }
    return query;
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//	if(selectedPath)
//	{
//		UITableViewCell *oldCell = [shuffleTable cellForRowAtIndexPath:selectedPath];
//		UIButton *swapBtn = (UIButton *)[oldCell.contentView viewWithTag:selectedPath.row+1000];
//		[swapBtn removeFromSuperview];
//		[oldCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
//		
//	}
}

/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)pushBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [shuffleArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	static NSInteger ExerciseTag = 1;
	
  
	static NSInteger RepsTag = 2;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		CGRect frame;
		frame.origin.x =10;
		frame.origin.y =10;
		frame.size.height =25;
		frame.size.width =200;
		
        UILabel *ExerciseLabel = [[UILabel alloc] initWithFrame:frame];
		ExerciseLabel.tag = ExerciseTag;
		[cell.contentView addSubview:ExerciseLabel];
	    [ExerciseLabel release];
		
        frame.origin.x =200;
		frame.origin.y =12;
		frame.size.height =20;
		frame.size.width =200; //this is used to show the another label on to the cell of table
		
        UILabel *RepsLabel = [[UILabel alloc] initWithFrame:frame];
		RepsLabel.tag = RepsTag;
		[cell.contentView addSubview:RepsLabel];
		[RepsLabel release];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(200, 8, 70, 30);
        [button setImage:[UIImage imageNamed:@"swap-button.png"] forState:UIControlStateNormal];
        button.tag=1001;            	
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(referenceTime:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        //[cell setAccessoryType:UITableViewCellAccessoryNone];
        
    }
    UIButton *button=(UIButton *)[cell.contentView viewWithTag:1001];
    button.hidden=YES;
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    if(selectedPath)
    {
        
        if (selectedPath.row==indexPath.row) {
            button.hidden=NO;
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }
        else
        {
            [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            
            button.hidden=YES;
        }
    }	
	 UILabel *ExerciseLabel = (UILabel *) [cell.contentView viewWithTag:ExerciseTag];
	 ExerciseLabel.font=[UIFont boldSystemFontOfSize:18];
	 ExerciseLabel.backgroundColor=[UIColor clearColor];

	 UILabel *RepsLabel = (UILabel*) [cell.contentView viewWithTag:RepsTag];
	 RepsLabel.font=[UIFont systemFontOfSize:10];
	 RepsLabel.backgroundColor=[UIColor clearColor];
     RepsLabel.textColor=[UIColor grayColor];
	 
		
     ExerciseLabel.text =[[shuffleArray objectAtIndex:indexPath.row] objectForKey:@"Exercise_Name"];
	 RepsLabel.text=[NSString stringWithFormat:@"%@ reps",[[shuffleArray objectAtIndex:indexPath.row] objectForKey:@"Reps"]];
	
     return cell;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
//	if(selectedPath)
//	{
//		UITableViewCell *oldCell = [shuffleTable cellForRowAtIndexPath:selectedPath];
//		UIButton *swapBtn = (UIButton *)[oldCell.contentView viewWithTag:selectedPath.row+1000];
//		[swapBtn removeFromSuperview];
//	    [oldCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
//	}
//	
//	UITableViewCell *cell = [shuffleTable cellForRowAtIndexPath:indexPath];
//	//static NSInteger BtnTag = 3;
//	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//	button.frame = CGRectMake(200, 8, 70, 30);
//	[button setImage:[UIImage imageNamed:@"swap-button.png"] forState:UIControlStateNormal];
//	button.tag=[indexPath row]+1000;
//	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//	[button addTarget:self action:@selector(referenceTime:) forControlEvents:UIControlEventTouchUpInside];
//	[cell.contentView addSubview:button];
//	[cell setAccessoryType:UITableViewCellAccessoryNone];
	selectedPath = [indexPath retain];
    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    videoController=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
    
    videoController.swapString=[[shuffleArray objectAtIndex:indexPath.row]objectForKey:@"Exercise_Name"];
    [videoController setExerciseId:[[[shuffleArray objectAtIndex:indexPath.row] objectForKey:@"id"]intValue]];
    [self.navigationController pushViewController:videoController animated:YES];

}
-(IBAction)doWorkoutBtnPressed:(id)sender
{
	
	[app setIsDirtyThirty:YES];
	if([app.DirtyThirtyExerciseArray count]>0)
	{
		[app.DirtyThirtyExerciseArray removeAllObjects];
	}
    NSLog(@"shuffle array is %@:",shuffleArray);
	[app.DirtyThirtyExerciseArray addObjectsFromArray:shuffleArray];
	[app startTimers];
	timerextern.isDoWorkout=YES;
    
}


-(void)referenceTime:(id)sender{
	
	//UIButton *button = (UIButton *)sender;
	
    NSIndexPath *indexPath =[shuffleTable indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
   
	path=indexPath;
	swap=[[SwapViewController alloc]initWithNibName:@"SwapViewController" bundle:[NSBundle mainBundle]];
	swap.swapString=[[shuffleArray objectAtIndex:indexPath.row] objectForKey:@"Exercice_Name"];
    CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
    NSLog(@"id is %@",[[shuffleArray objectAtIndex:indexPath.row] objectForKey:@"id"]);
    NSInteger bodrPart_id=[[[shuffleArray objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
	NSString *Query = [NSString stringWithFormat:@"select BodyPart_id from Exercise_BodyPart where Exercise_id=%d",bodrPart_id];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
    NSLog(@"wwwwwwwwww .....%@",rows);
	[BodypartArr addObjectsFromArray:rows];

   // if([BodypartArr count])
	swap.bodyPart_id=[[[BodypartArr  objectAtIndex:0] objectForKey:@"BodyPart_id"] intValue];
	[swap setOwner:self];
	[self.navigationController pushViewController:swap animated:YES];
	
	//[button removeFromSuperview];
	}

-(void)swapExerciseWithData:(NSDictionary *)newData
{
	
	[shuffleArray replaceObjectAtIndex:path.row withObject:newData];
     selectedPath=nil;
    [shuffleTable reloadData];
	NSLog(@"%@",shuffleArray);
}


-(IBAction)AddMyFaves:(id)sender
{
	
	if(isSwap)
	{
	
	save=[[SaveViewController alloc]initWithNibName:@"SaveViewController" bundle:[NSBundle mainBundle]];	


	save.view.frame=CGRectMake(10, 12, 300, 390);

	[save setOwner:self];

	[UIView beginAnimations:@"" context:NULL];
	[UIView setAnimationDuration:2.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:save.view cache:YES];
	[UIView commitAnimations];
		
	[self.view addSubview:save.view];
		[save viewWillAppear:YES];
	[save saveExercisesAsMYfaves:shuffleArray];
	}
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [shuffleArray release];
    [BodypartArr release];
	[timer release];
    [swap release];
    [save release];
}


@end

