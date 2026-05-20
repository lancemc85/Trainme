//
//  ReportViewController.m
//  Exercise
//
//  Created by Dev Team on 3/7/11.
//  Copyright 2011 CopperMobile. All rights reserved.
//

#import "ReportViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"

@implementation ReportViewController

@synthesize necklbl;
@synthesize shoulderslbl;
@synthesize chestlbl;
@synthesize corelbl;
@synthesize hipslbl;
@synthesize thighlbl;
@synthesize calflbl;
@synthesize armlbl;
@synthesize bodyweightlbl;
@synthesize bodyfatlbl;
@synthesize BMRlbl;
@synthesize Query1Arr;
@synthesize Query2Arr;
@synthesize Query3Arr;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated
{
	NSMutableArray *tempArr=[[NSMutableArray alloc]init];
	Query1Arr=[[NSMutableArray alloc]init];
	Query2Arr=[[NSMutableArray alloc]init];
	Query3Arr=[[NSMutableArray alloc]init];

	[tempArr addObjectsFromArray:[self getMeasurementData]];
	[Query1Arr  addObjectsFromArray:[self getBodyWeightData]];
	[Query2Arr addObjectsFromArray:[self getBodyFatData]];
	[Query3Arr addObjectsFromArray:[self getBMRData]];
	
	NSLog(@"Query1Arr is:%@",Query1Arr);
	NSLog(@"Query2Arr is:%@",Query2Arr);
	NSLog(@"Query3Arr is:%@",Query3Arr);

	
	if ([tempArr count]>0)
	{
		necklbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Neck"]];
		shoulderslbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Shoulders"]];
		chestlbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"chest"]];
		corelbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"core"]];
		hipslbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Hips"]];
		thighlbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Thigh"]];
		calflbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"calf"]];
		armlbl.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Arm"]];
	}
	
	if ([Query1Arr count]>0)
	bodyweightlbl.text=[NSString stringWithFormat:@"%@",[[Query1Arr objectAtIndex:0] objectForKey:@"Currentweight"]];
	
	if ([Query2Arr count]>0)
	bodyfatlbl.text=[NSString stringWithFormat:@"%@",[[Query2Arr objectAtIndex:0] objectForKey:@"CurrentBF"]];
	
	if ([Query3Arr count]>0)
    BMRlbl.text=[NSString stringWithFormat:@"%@",[[Query3Arr objectAtIndex:0] objectForKey:@"CurrentBMR"]];
	
}


-(NSArray *)getMeasurementData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	
	NSString *Query  = [NSString stringWithFormat:@"select * from Measurement where rowid=(select MAX(rowid) from Measurement) "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	
	return rows;
}

-(NSArray *)getBMRData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	
	NSString *Query = [NSString stringWithFormat:@"select CurrentBMR from BMR where rowid=(select MAX(rowid) from BMR) "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
		
	NSLog(@"row is:%@",rows);
		
	
	return rows;
}

-(NSArray *)getBodyFatData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select CurrentBF from BodyFat where rowid=(select MAX(rowid) from BodyFat) "];
	NSArray *rows = [db rowsForExpression:Query error:nil];
	
	NSLog(@"row is:%@",rows);
	
	
	return rows;
}

-(NSArray *)getBodyWeightData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	
	NSString *Query = [NSString stringWithFormat:@"select Currentweight from WeightCal where rowid=(select MAX(rowid) from WeightCal) "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	
	NSLog(@"row is:%@",rows);
	
	
	return rows;
}




-(IBAction)pushBackbutton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
}


@end
