//
//  MyMeasurementsViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyMeasurementsViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
#import "FBController.h"
#import "iCodeOauthViewController.h"


@implementation MyMeasurementsViewController

@synthesize measureNeckTxt;
@synthesize measureShouldersTxt;
@synthesize measureChestTxt;
@synthesize measureCoreTxt;
@synthesize measureHipsTxt;
@synthesize measureThighTxt;
@synthesize measureCalfTxt;
@synthesize measureArmTxt;
@synthesize measureEmailBtn;
@synthesize measurePushBackBtn;
@synthesize MeasurementData;
@synthesize MeasurementTitle;


-(IBAction)pushGoBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
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
	
	//NSArray *settingData = [self getDataForQuery:@"SELECT title, value FROM settings WHERE groupid=1"];
//	NSLog(@"setting data is: %@",settingData);
//	
//	for (int row=0; row<[settingData count]; row++)
//	{
//		if([[settingData objectAtIndex:row]objectForKey:@"value"]!=[NSNull null])
//		{
//			if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Neck"])
//				neckstr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Shoulders"])
//				shouldersstr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Chest"])
//				cheststr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Core"])
//				corestr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Hips"])
//				hipsstr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Thighs"])
//				thighstr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Calf"])
//				calfstr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Arms"])
//				armsstr = [[settingData objectAtIndex:row]objectForKey:@"value"];
//		}
//	}
//	measureNeckTxt.text=neckstr;
//	measureShouldersTxt.text=shouldersstr;
//	measureChestTxt.text=cheststr;
//	measureCoreTxt.text=corestr;
//	measureHipsTxt.text=hipsstr;
//	measureThighTxt.text=thighstr;
//	measureCalfTxt.text=calfstr;
//	measureArmTxt.text=armsstr;
}

- (void)viewWillAppear:(BOOL)animated {
	NSMutableArray *tempArr=[[NSMutableArray alloc]init];
	[tempArr addObjectsFromArray:[self getMeasurementData]];
	if ([tempArr count]>0)
	{
		NSLog(@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Neck"]);
		measureNeckTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Neck"]];
		measureShouldersTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Shoulders"]];

		measureChestTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"chest"]];

		measureCoreTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"core"]];

		measureHipsTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Hips"]];

		measureThighTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Thigh"]];

		measureCalfTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"calf"]];
 
		measureArmTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Arm"]];

	}
	//[tempArr release];
}

-(NSArray *)getMeasurementData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from Measurement where rowid=(select MAX(rowid) from Measurement) "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	
	return rows;
}


-(IBAction)nonNumericValues:(id)sender
{
    UITextField *inputText=(UITextField *)sender;
    
    const char* cString = [inputText.text UTF8String]; 
    
    for (int i = 0; i < [inputText.text length]; i++)
    {
        
        if ((cString[i] >= '0' && cString[i] <= '9')||cString[i]=='.')
        {
            specialCharacterPresent=NO;
            NSLog(@"rr%c",cString[i]);
        }
        else
        {
            NSLog(@"eeee%c",cString[i]);
            specialCharacterPresent= YES;
        }
        if(cString[i]=='.')
        {
            count++;
            if(count>1)
                specialCharacterPresent=YES;
        }
    }  
    
    if(specialCharacterPresent)
    {
        if([inputText.text length]>0)
        {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter only Numeric Value." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
            inputText.text=@"";
            count=0;
        }
   
        
    }
    
    
}


-(IBAction)saveMeasurementdata:(id)sender
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];	
	NSString *Query = [NSString stringWithFormat:@"insert into Measurement (Neck,Shoulders,chest,core,Hips,Thigh,calf,Arm) Values('%@','%@','%@','%@','%@','%@','%@','%@')",measureNeckTxt.text,measureShouldersTxt.text,measureChestTxt.text,
					   measureCoreTxt.text,measureHipsTxt.text,measureThighTxt.text,
					   measureCalfTxt.text ,measureArmTxt.text];
	[db executeExpression:Query error:NULL];
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clearBtn:(id)sender
{
    measureNeckTxt.text=@"";   
    measureShouldersTxt.text=@"";    
    measureChestTxt.text=@"";
    
    measureCoreTxt.text=@"";    
    measureHipsTxt.text=@"";    
    measureThighTxt.text=@"";    
    measureCalfTxt.text=@"";    
    measureArmTxt.text=@"";
}

-(void)limitationsforTextfields
{
}


-(IBAction)pushEmailBtn:(id)sender
{
	if([measureNeckTxt.text length]==0 ||[measureShouldersTxt.text length]==0 || [measureChestTxt.text length]==0 || [measureCoreTxt.text length]==0 || 
	   [measureHipsTxt.text length]==0 ||[measureThighTxt.text length]==0 || [measureCalfTxt.text length]==0 || [measureArmTxt.text length]==0)
	{
		
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Enter complete information" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
		[alert show];
		[alert release];
	}
	else
	{
	    MeasurementTitle=@"Measurements Data";
		MeasurementData =[NSString stringWithFormat:
						  @"<b>Neck              : %@</b><br>"
						  @"<b>Shoulders         : %@</b><br>"				
						  @"<b>Chest             : %@</b><br>"
						  @"<b>Core(at Naval)    : %@</b><br>"
						  @"<b>Hips(at Buttocks)  : %@</b><br>"
						  @"<b>Thigh(at MidPoint)  : %@</b><br>"
						  @"<b>Calf(at MidPoint)  : %@</b><br>"
						  @"<b>Arm(at MidPoint)  : %@</b><br>",
						  measureNeckTxt.text,measureShouldersTxt.text,measureChestTxt.text,
						  measureCoreTxt.text,measureHipsTxt.text,measureThighTxt.text,
						  measureCalfTxt.text ,measureArmTxt.text];
		NSLog(@"%@",MeasurementData);
		[app sendingMail:MeasurementTitle gettingBody:MeasurementData];
	}
}

-(IBAction)facebookComment:(id)sender
{

	NSString *fbcomment=[NSString stringWithFormat:@"Neck: %@,Shoulders: %@,Chest: %@,Core(at Naval): %@,Hips(at Buttocks): %@,Thigh(at MidPoint): %@,Calf(at MidPoint): %@,Arm(at MidPoint): %@",
						 measureNeckTxt.text,measureShouldersTxt.text,measureChestTxt.text,
						 measureCoreTxt.text,measureHipsTxt.text,measureThighTxt.text,
						 measureCalfTxt.text ,measureArmTxt.text];
	
	FBController *FBC=[FBController sharedInstance];
	NSMutableDictionary    *otherInfo = [[NSMutableDictionary alloc]init];
	
	[otherInfo setObject:@"" forKey:@"caption"];
	[otherInfo setObject:fbcomment forKey:@"description"];
	[FBC setTextToPublish:@""];
	[FBC setOtherInformation:otherInfo]; 
	[FBC setImageDataToPublish:NULL]; 
	[FBC doPostToFaceBookAndRspondTo:[self retain]];
	[otherInfo release];
	
	
}

-(IBAction)twitterTweet:(id)sender
{
	//[self performSelectorInBackground:@selector(startAnimation) withObject:nil];
	iCodeOauthViewController *icodeObj=[[iCodeOauthViewController alloc]init];
	NSString *twtrcomment=[NSString stringWithFormat:@"Neck:%@,Shoulders: %@,Chest: %@,Core(at Naval): %@,Hips(at Buttocks): %@,Thigh(at MidPoint): %@,Calf(at MidPoint): %@,Arm(at MidPoint): %@",
						   measureNeckTxt.text,measureShouldersTxt.text,measureChestTxt.text,
						   measureCoreTxt.text,measureHipsTxt.text,measureThighTxt.text,
						   measureCalfTxt.text ,measureArmTxt.text];
	
    [icodeObj setTwitterMsg:twtrcomment];
	[self.navigationController pushViewController:icodeObj animated:NO];
	//[Indicator stopAnimating];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)textFieldDidBeginEditing:(UITextField *)textField
{  
    
    count=0;
    //inputString=textField.text;
if((textField != measureNeckTxt )&&( textField !=measureShouldersTxt) &&( textField !=measureChestTxt)&&( textField !=measureCoreTxt))
		[self setViewMovedUp:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if((textField != measureNeckTxt )&&( textField !=measureShouldersTxt) &&( textField !=measureChestTxt)&&( textField !=measureCoreTxt))
       [self setViewMovedUp:NO];

}

- (void)setViewMovedUp:(BOOL)movedUp{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:NO];
	// Make changes to the view's frame inside the animation block. They will be animated instead
	// of taking place immediately.
	CGRect rect = self.view.frame;
	//CGRect rect = NewUserNotes.frame;
	if (movedUp)
	{
		
		// If moving up, not only decrease the origin but increase the height so the view 
		// covers the entire screen behind the keyboard.
		rect.origin.y -= 230-110;
		//rect.size.height += kOFFSET_FOR_KEYBOARD;
	}
	else
	{
		
		// If moving down, not only increase the origin but decrease the height.
		rect.origin.y += 230-110;
		//rect.size.height -= kOFFSET_FOR_KEYBOARD;
	}
	self.view.frame = rect;
	[UIView commitAnimations];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [measureNeckTxt resignFirstResponder];
    [measureShouldersTxt resignFirstResponder];
   [measureChestTxt resignFirstResponder];
    [measureCoreTxt resignFirstResponder];
    [measureHipsTxt resignFirstResponder];
    [measureThighTxt  resignFirstResponder];
    [measureCalfTxt resignFirstResponder];
    [measureArmTxt resignFirstResponder];
    
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
