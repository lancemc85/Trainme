//
//  SwapViewController.m
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SwapViewController.h"
#import "ShuffleViewController.h"
#import "videoViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
SwapViewController *externswap=nil;
@implementation SwapViewController
@synthesize swapString,owner,bodyPart_id,selectedIndex;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	externswap=self;
	swapArray=[[NSMutableArray alloc]init];
   // checkRepeatState=[[NSMutableArray alloc]init ];
}


-(void)viewWillAppear:(BOOL)animated
{
    selectedPath=nil;
    [super viewWillAppear:animated];
	isSelect=NO;
	[self SelectData];
	[swapTableView reloadData];
}


-(void)SelectData
{
	NSLog(@"id is:%d",bodyPart_id);
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	NSMutableString *Query;
	[db open:NULL];
    if([owner isCalledFromDirty]){
	Query = [NSString stringWithFormat:@"SELECT Exercise_Name,id,isCardio FROM Exercise join Exercise_BodyPart on Exercise.id=Exercise_BodyPart.Exercise_id where BodyPart_id=%d order by Exercise_Name",bodyPart_id];
	}
    else
    {
        Query = [NSString stringWithFormat:@"SELECT  Ex.*,EB.*,WE.*   FROM  Workout_Exercise WE  INNER JOIN Exercise_BodyPart EB   ON  EB.Exercise_id=WE.Exercise_id  INNER JOIN Exercise  Ex    ON EB.Exercise_id=Ex.id WHERE EB.BodyPart_id=%d  GROUP BY Ex.id ORDER BY Ex.Exercise_Name",bodyPart_id];
    }
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"rows are:%@",rows);
	if([swapArray count]>0)
	{
		[swapArray removeAllObjects];
	}
	[swapArray addObjectsFromArray:rows];
	[swapTableView reloadData];
}


/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
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
	
    return [swapArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"Cell";
    static NSInteger ExerciseTag = 1;
    
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
        
        
        

        //[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(200, 8, 70, 30);
        [button setImage:[UIImage imageNamed:@"ex-button.png"] forState:UIControlStateNormal];
        button.tag=101;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ExchangeExerciseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
//        [cell setAccessoryType:UITableViewCellAccessoryNone];

        
        
    }
    
    UILabel *ExerciseLabel = (UILabel *) [cell.contentView viewWithTag:ExerciseTag];
    ExerciseLabel.font=[UIFont boldSystemFontOfSize:18];
    ExerciseLabel.backgroundColor=[UIColor clearColor];
   
    UIButton *button=(UIButton *)[cell.contentView viewWithTag:101];
    button.hidden=YES;
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
   
        
    
    if(selectedPath)
    if (selectedPath.row==indexPath.row) {
        button.hidden=NO;
        [cell setAccessoryType:UITableViewCellAccessoryNone];

    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];

        button.hidden=YES;
    }
    
	//cell.textLabel.font=[UIFont boldSystemFontOfSize:18];
	ExerciseLabel.text=[[swapArray objectAtIndex:indexPath.row] objectForKey:@"Exercise_Name"];
 	
     
    
    
	return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	//selectedIndex = indexPath.row;
	//isSelect=YES;
	video=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
	video.swapString=[[swapArray objectAtIndex:indexPath.row] objectForKey:@"Exercise_Name"];
	[video setExerciseId:[[[swapArray objectAtIndex:indexPath.row] objectForKey:@"id"]intValue]];
	[video setImageNamestr:[[swapArray objectAtIndex:indexPath.row] objectForKey:@"Photos"]];
	[video setVideoNamestr:[[swapArray objectAtIndex:indexPath.row] objectForKey:@"Videos"]];
	NSLog(@"imagenameinswap: %@",[[swapArray objectAtIndex:indexPath.row] objectForKey:@"Photos"]);
    [video setButtonindex:0];
	[video setOwner:self];
    
	[self .navigationController pushViewController:video animated:YES];
    
    
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//-(IBAction)ExchangeBtn:(id)sender{
//	[self ExchangeExercise];
//
//}

-(void)ExchangeExercise
{
	if(isSelect)
	{
		
		if([swapArray count]>0)
		{
			[owner swapExerciseWithData:[swapArray objectAtIndex:selectedIndex]];
			isSelect=NO;
			[owner setIsSwap:YES];
		}
	}
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{     
	//isSelect=YES;
	//	video=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
	//	video.swapString=[[swapArray objectAtIndex:indexPath.row] objectForKey:@"Exercise_Name"];
	//	video.path=indexPath;
	//	[video setOwner:self];
	//	[self .navigationController pushViewController:video animated:YES];
	NSLog(@"indexpath: %d", indexPath.row);

	selectedPath = [indexPath retain];
    [tableView reloadData];
    
}
//
//-(void)addExchangeButton:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [swapTableView cellForRowAtIndexPath:indexPath];
//   	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//	button.frame = CGRectMake(200, 8, 70, 30);
//	[button setImage:[UIImage imageNamed:@"ex-button.png"] forState:UIControlStateNormal];
//	button.tag=indexPath.row+100;
//   [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(ExchangeExerciseBtn:) forControlEvents:UIControlEventTouchUpInside];
//	[cell.contentView addSubview:button];
//   [cell setAccessoryType:UITableViewCellAccessoryNone];
//	
//}
//
//-(void)removeExchangeButton:(NSIndexPath *)indexPath
//{
//    NSLog(@"%d - %d", indexPath.row,indexPath.row);
//    UITableViewCell *oldCell = [swapTableView cellForRowAtIndexPath:indexPath];
//    UIButton *swapBtn = (UIButton *)[oldCell.contentView viewWithTag:indexPath.row+100];
//    NSLog(@"Button tag: %d", swapBtn.tag);
//    [swapBtn removeFromSuperview];
//    [oldCell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
//	
//}
//
//    

-(void)ExchangeExerciseBtn:(id)sender
{
    UIButton *button = (UIButton *)sender;
	NSIndexPath *indexPath =[swapTableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
	selectedIndex = indexPath.row;
	isSelect=YES;
	[self ExchangeExercise];
    [button removeFromSuperview];
}        

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
    [video release];
}


@end

