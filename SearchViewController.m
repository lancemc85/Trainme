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
@synthesize backbodyImage;
@synthesize backBodyImagesArray;
@synthesize viewExercisesBtn;
@synthesize frontView;
@synthesize backView;
@synthesize labelofBodyPart;
@synthesize BodyPartInfotxtview;
@synthesize pickerOnView;
@synthesize picker;

@synthesize    exerciseid;
@synthesize pagesviewcontroller;
@synthesize pickerText;





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
	BodyPartsArray=[[NSMutableArray alloc]init];
	
	pagesviewcontroller=[[pagesViewController alloc]initWithNibName:@"pagesViewController" bundle:[NSBundle mainBundle]];
	
	[self.view bringSubviewToFront:frontView];
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
   	bodyPartName=@"Glutes";
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
	BodyPartInfotxtview.text=@"You can view Muscles corresponding information by clicking on a body part.";
    bodyImage.image=[UIImage imageNamed: @"front- no selection.png"];
    [self.view bringSubviewToFront:frontView];
//    [pickerExerciseArray removeAllObjects];
//    [picker reloadAllComponents];
    bodyPartId=0;
}

-(IBAction)frontbodyBtnPressed:(id)sender
{
	frontView.hidden=YES;
	backView.hidden=NO;
	labelofBodyPart.text=@"Info";
	BodyPartInfotxtview.text=@"You can view Muscles corresponding information by clicking on a body part.";
	backbodyImage.image=[UIImage imageNamed:@"back- no selection.png"];
    [self.view bringSubviewToFront:backView];
//    [pickerExerciseArray removeAllObjects];
//    [picker reloadAllComponents];
    bodyPartId=0;
}

-(IBAction)viewExercisesBtnPressed:(id)sender
{
  //  if ([pickerExerciseArray count]>0)
    {
        [self.view bringSubviewToFront:pickerOnView];
        [self showPicker];
        [self selectExerciseData];
    }
}

-(void)selectedBodyParts
{
	if([BodyPartsArray count]>0)
	{
		[BodyPartsArray removeAllObjects];
	}
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * From Body where Body_Part_Name='%@' order by Body_Part_Name ASC;",bodyPartName];
	
    NSArray *rows = [db rowsForExpression:Query error:nil];
	
	[BodyPartsArray addObjectsFromArray:rows];
    
    NSLog(@"BodyPartsArray ::::%@",BodyPartsArray);
	
	//NSString *ImageString=[frontBodyImagesArray objectAtIndex:0];
	if(frontView)
	{
	    bodyImage.image=[UIImage imageNamed:[[BodyPartsArray objectAtIndex:0]objectForKey:@"Body_Part_Image"]];
	}
	if(backView)
	{
		backbodyImage.image=[UIImage imageNamed:[[BodyPartsArray objectAtIndex:0]objectForKey:@"Body_Part_Image"]];
	}
	bodyPartId=[[[BodyPartsArray objectAtIndex:0] objectForKey:@"id"] intValue];
	labelofBodyPart.text=[[BodyPartsArray objectAtIndex:0]objectForKey:@"Body_Part_Name"];
	BodyPartInfotxtview.text=[[BodyPartsArray objectAtIndex:0] objectForKey:@"Body_Part_Info"];
}

-(NSArray *)selectExerciseData
{
	if ([pickerExerciseArray count]>0) 
	{
		[pickerExerciseArray removeAllObjects];
	}
	NSLog(@"%d",bodyPartId);
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select Exercise.Exercise_Name,Exercise.id,Exercise.Photos,Exercise.Videos From Exercise join Exercise_BodyPart on Exercise.id=Exercise_BodyPart.Exercise_id where BodyPart_id=%d order by Exercise.Exercise_Name",bodyPartId];
	NSArray *rows = [db rowsForExpression:Query error:nil];

	[pickerExerciseArray addObjectsFromArray:rows];
	NSLog(@"pickerExerciseArray %@",pickerExerciseArray);
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
    
    if([pickerExerciseArray count]>0)
    {
        pickerText = [[pickerExerciseArray objectAtIndex:row] objectForKey:@"Exercise_Name"];
        titleLabel.text = pickerText;
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = font;
        selectedrow=[pickerView selectedRowInComponent:0];
        titleLabel.opaque = NO;
        if(selectedrow == row)
        {
            //[pagesviewcontroller setPageOwner:self];
            
            exerciseid=[[[pickerExerciseArray objectAtIndex:row] objectForKey:@"id"]intValue];
            
            titleLabel.textColor = [UIColor blueColor];
            checkmarkImageView.image = [UIImage imageNamed:@"tick.png"];
        }
        else
        {
            titleLabel.textColor = [UIColor blackColor];
            checkmarkImageView.image = nil;
        }
        [rowView addSubview:checkmarkImageView];
        [rowView addSubview:titleLabel];
        
        [titleLabel release];
        [checkmarkImageView release];
    }
	
	return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	[pickerView reloadAllComponents];
	//videoController.swapString=[[pickerExerciseArray objectAtIndex:row]objectForKey:@"Exercise_Name"];
	//[videoController setExerciseId:[[[pickerExerciseArray objectAtIndex:row] objectForKey:@"id"]intValue]];
    //[videoController setImageNamestr:[[pickerExerciseArray objectAtIndex:row] objectForKey:@"Photos"]];
	//[videoController setVideoNamestr:[[pickerExerciseArray objectAtIndex:row] objectForKey:@"Videos"]];
}



-(IBAction)viewExampleBtnpressed:(id)sender
{
    if([pickerExerciseArray count]>0)
    {
        selectedrow=[picker selectedRowInComponent:0];

        videoViewController *videoController=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
        
        videoController.swapString=[[pickerExerciseArray objectAtIndex:selectedrow]objectForKey:@"Exercise_Name"];
        [videoController setExerciseId:[[[pickerExerciseArray objectAtIndex:selectedrow] objectForKey:@"id"]intValue]];
        [videoController setImageNamestr:[[pickerExerciseArray objectAtIndex:selectedrow] objectForKey:@"Photos"]];
        [videoController setVideoNamestr:[[pickerExerciseArray objectAtIndex:selectedrow] objectForKey:@"Videos"]];
        [videoController setButtonindex:0];
        [self.navigationController pushViewController:videoController animated:YES];
        [videoController release];
    //  [pagesviewcontroller viewWillAppear:YES];
   }
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
	[pickerOnView setFrame:CGRectMake(0,175, 339, 650)];
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
