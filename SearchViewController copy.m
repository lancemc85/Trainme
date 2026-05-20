//
//  SearchViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import   "ExerciseAppDelegate.h"
#import   "TouchSQL.h"

SearchViewController *externSearch=nil;

@implementation SearchViewController

@synthesize bodyImage;
@synthesize backBodyImagesArray;
@synthesize viewExercisesBtn;
@synthesize frontView;
@synthesize backView;
@synthesize labelofBodyPart;
@synthesize BodyPartInfotxtview;
@synthesize pickerOnView;
@synthesize picker;
@synthesize videoController;


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
	
	externSearch=self;
	frontBodyImagesArray=[[NSArray alloc]initWithObjects: @"front- pectorals.png",
														  @"front- core.png",
														  @"front- shoulders.png",
														  @"front- biceps.png",
						                                  @"front- Quads.png",
						                                  @"front- no selection.png",nil];
	
	backBodyImagesArray=[[NSArray alloc]initWithObjects: @"back- back.png",
														 @"back- calfs.png",
														 @"back- gluts.png",
														 @"back- hamstring.png",
														 @"back- triceps.png", 
														 @"back-shoulders.png",
						                                 @"back- no selection.png",nil];
	
	pickerExerciseArray = [[NSMutableArray alloc] init];
						   //@"             exercise1",
//						   @"             exercise2",
//						   @"             exercise3",
//						   @"             exercise4", 
//						   @"             exercise5", 
//						   @"             exercise6",nil];
	BodyPartsArray=[[NSMutableArray alloc]init];
	
	videoController=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
	
}

-(IBAction)chestBtnPressed:(id)sender
{
	bodyPartName=@"Pectorals";
	[self selectedBodyParts];	
}

-(IBAction)AbbsBtnPressed:(id)sender
{
	bodyPartName=@"Core";
	[self selectedBodyParts];	
}

-(IBAction)shouldersBtnPressed:(id)sender
{
	
	bodyPartName=@"Shoulders";
	[self selectedBodyParts];	
}

-(IBAction)bicepsBtnPressed:(id)sender
{
	bodyPartName=@"Biceps";
	[self selectedBodyParts];	
}

-(IBAction)tightsBtnPressed:(id)sender
{
	bodyPartName=@"Quads";
	[self selectedBodyParts];	
}

-(IBAction)back2backBtnPressed:(id)sender
{
	bodyPartName=@"Back";
	[self selectedBodyParts];	
}

-(IBAction)backCalfsBtnPressed:(id)sender
{
   	bodyPartName=@"Calfs";
	[self selectedBodyParts];	
}

-(IBAction)buttocksBtnPressed:(id)sender
{
   	bodyPartName=@"Gluts";
	[self selectedBodyParts];	
}

-(IBAction)hamstringBtnPressed:(id)sender
{
   	bodyPartName=@"Hamstring";
	[self selectedBodyParts];	
}

-(IBAction)backTricepsBtnPressed:(id)sender
{
	bodyPartName=@"Triceps";
	[self selectedBodyParts];	
}

-(IBAction)backShouldersBtnPressed:(id)sender
{
	
	bodyPartName=@"BackShoulders";
	[self selectedBodyParts];	
}


-(IBAction)backbodyBtnPressed:(id)sender
{

	backView.hidden=YES;
	frontView.hidden=NO;
	labelofBodyPart.text=@"Info";
	BodyPartInfotxtview.text=@"";
    bodyImage.image=[UIImage imageNamed: @"front- no selection.png"];
    [self.view bringSubviewToFront:frontView];
}

-(IBAction)frontbodyBtnPressed:(id)sender
{
	frontView.hidden=YES;
	backView.hidden=NO;
	labelofBodyPart.text=@"Info";
	BodyPartInfotxtview.text=@"";
	backbodyImage.image=[UIImage imageNamed:@"back- no selection.png"];
    [self.view bringSubviewToFront:backView];
}

-(IBAction)viewExercisesBtnPressed:(id)sender
{
	
	[self.view bringSubviewToFront:pickerOnView];
    [self showPicker];
	[self selectExerciseData];
}

-(void)selectedBodyParts{
	
	
	if([BodyPartsArray count]>0)
		
	{
		[BodyPartsArray removeAllObjects];
		
	}
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * From Body where Body_Part_Name='%@';",bodyPartName];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	
	[BodyPartsArray addObjectsFromArray:rows];
	
	//NSString *ImageString=[frontBodyImagesArray objectAtIndex:0];
		if(frontView){
	bodyImage.image=[UIImage imageNamed:[[BodyPartsArray objectAtIndex:0]objectForKey:@"Body_Part_Image"]];
		}
	 if(backView){
		backbodyImage.image=[UIImage imageNamed:[[BodyPartsArray objectAtIndex:0]objectForKey:@"Body_Part_Image"]];
	}
	bodyPartId=[[[BodyPartsArray objectAtIndex:0]objectForKey:@"id"] integerValue];
     labelofBodyPart.text=[[BodyPartsArray objectAtIndex:0]objectForKey:@"Body_Part_Name"];
	BodyPartInfotxtview.text=[[BodyPartsArray objectAtIndex:0] objectForKey:@"Body_Part_Info"];
	}

-(NSArray *)selectExerciseData{
	
	if ([pickerExerciseArray count]>0) {
		[pickerExerciseArray removeAllObjects];
	}
	NSLog(@"%d",bodyPartId);
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
     [db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select Exercise.Exercise_Name,Exercise.id from Exercise join BodyPart_Exercises on Exercise.id=BodyPart_Exercises.Exercise_id where BodyPart_Exercises.BodyPart_id=%d",bodyPartId];
	NSArray *rows = [db rowsForExpression:Query error:nil];

	[pickerExerciseArray addObjectsFromArray:rows];
	[picker reloadAllComponents];
	return rows;
	}




-(IBAction)pickerDoneButtonClicked
{
	
	[self hidePicker];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return[pickerExerciseArray count];
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//	//return [pickerExerciseArray objectAtIndex:row];
//}

- (UIView *)pickerView:(UIPickerView *)pickerView
			viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component
		   reusingView:(UIView *)view {
	
	
	UIView *rowView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 44)] autorelease];
	rowView.backgroundColor = [UIColor clearColor];
	rowView.userInteractionEnabled = NO;
	UIImageView *checkmarkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 24, 19)];
	
	UIFont *font = [ UIFont boldSystemFontOfSize:18];
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 240, 44) ];
	NSString *pickerText = [[pickerExerciseArray objectAtIndex:row] objectForKey:@"Exercise_Name"];
	titleLabel.text = pickerText;
	titleLabel.textAlignment = UITextAlignmentLeft;
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = font;
	selectedrow=[pickerView selectedRowInComponent:0];
	titleLabel.opaque = NO;
	if (selectedrow == row) {
		videoController.swapString=[[pickerExerciseArray objectAtIndex:row]objectForKey:@"Exercise_Name"];
		titleLabel.textColor = [UIColor blueColor];
		checkmarkImageView.image = [UIImage imageNamed:@"tick.png"];
	}else {
		titleLabel.textColor = [UIColor blackColor];
		checkmarkImageView.image = nil;
	}
	[rowView addSubview:checkmarkImageView];
    [rowView addSubview:titleLabel];
	
    [titleLabel release];
    [checkmarkImageView release];
	
	return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	[pickerView reloadAllComponents];
	//selectedrow=[pickerView selectedRowInComponent:0];
	videoController.swapString=[[pickerExerciseArray objectAtIndex:row]objectForKey:@"Exercise_Name"];
}



-(IBAction)viewExampleBtnpressed:(id)sender
{
	[self.navigationController pushViewController:videoController animated:YES];
}


-(void)hidePicker
{
	[UIView beginAnimations:@"" context:NULL];
	[pickerOnView setFrame:CGRectMake(0,429, 339, 650)];
	[UIView setAnimationDuration:5.0];
	[UIView setAnimationDelay:UIViewAnimationCurveEaseIn];
	[UIView commitAnimations];
}


-(void)showPicker
{
	[UIView beginAnimations:@"" context:NULL];
	[pickerOnView setFrame:CGRectMake(0,160, 339, 650)];
	[UIView setAnimationDuration:5.0];
	[UIView setAnimationDelay:UIViewAnimationCurveEaseIn];
	[UIView commitAnimations];
	
}


#pragma mark =============== outlets Functions ===============





/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)viewWillDisappear:(BOOL)animated
{
	[self hidePicker];
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
