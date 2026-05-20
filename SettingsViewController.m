//
//  SettingsViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "TouchSQL.h"
#import "ExerciseAppDelegate.h"


@implementation SettingsViewController

@synthesize settingsLoseWeightOptionBtn;
@synthesize settingsToneMuscleOptionBtn;
@synthesize settingsGainMuscleOptionBtn;
@synthesize settingsEmailAddressTxt;
@synthesize settingsSaveBtn;
@synthesize settingsPushGoBackBtn;



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
	NSUserDefaults *standardUserDefault=[NSUserDefaults standardUserDefaults];

	repetionText = [[NSString alloc]init];
//	NSArray *settingData = [self getDataForQuery:@"SELECT title,value FROM settings WHERE groupid=0"];
//	NSLog(@"setting data is: %@",settingData);
////		NSLog(@"%@",[[settingData objectAtIndex:1]objectForKey:@"value"]);
//	for (int row=0; row<[settingData count]; row++) {
//		if([[settingData objectAtIndex:row]objectForKey:@"value"]!=[NSNull null])
//		{
//			if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Purpose"])
//				purpose = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			else 
//			{
//				if([[[settingData objectAtIndex:row]objectForKey:@"title"] isEqualToString:@"Email"]);
//					emailid = [[settingData objectAtIndex:row]objectForKey:@"value"];
//			}
//		}
//	}
//	

    
	settingsEmailAddressTxt.text=[standardUserDefault objectForKey:@"EmailId"];
    repetionLabel.text =[standardUserDefault objectForKey:@"REPETION"];


//	NSLog(@"purpose: %@", purpose);
//	if(purpose)
	
	if([[standardUserDefault objectForKey:@"PURPOSE"] isEqualToString:@"Lose Weight"])
	{
		[settingsLoseWeightOptionBtn setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
	}
	else if([[standardUserDefault objectForKey:@"PURPOSE"] isEqualToString:@"Tone Muscle"])
	{
		[settingsToneMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
	}
	else if([[standardUserDefault objectForKey:@"PURPOSE"] isEqualToString:@"Gain Muscle"])
	{
		[settingsGainMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
	}

}

-(void)viewWillAppear:(BOOL)animated{
//    NSString *tempStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"REPETION"];
//    
//    repetionLabel.text = tempStr;
//    NSLog(@"ftwufkw %@",tempStr);
}
//-(NSArray *)getDataForQuery:(NSString *)Query
//{
//	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
//	[db open:NULL];
//	NSArray *data = [db rowsForExpression:Query error:nil];
//	NSLog(@"data: %@",data);
//	[db release];
//	return data;
//}
//
//
//-(BOOL)setDataForQuery:(NSString *)Query
//{
//	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
//	[db open:NULL];
//	BOOL result = [db executeExpression:Query error:nil];
//	[db release];
//	NSLog(@"%d",result);
//	return result;
//}

-(IBAction)savebtnInSettings:(id)sender
{
	emailid=settingsEmailAddressTxt.text;
	NSLog(@"%@",emailid);
	NSUserDefaults *standardUserDefault=[NSUserDefaults standardUserDefaults];
	if(standardUserDefault)
	{
		[standardUserDefault setObject:emailid forKey:@"EmailId"];
		[standardUserDefault setObject:purpose forKey:@"PURPOSE"];
        [standardUserDefault setObject:repetionText forKey:@"REPETION"];

		[standardUserDefault synchronize];
	}
	NSLog(@"%@",[standardUserDefault objectForKey:@"EmailId"]);
    [self.navigationController popViewControllerAnimated:YES];
    
//    [[NSUserDefaults standardUserDefaults]setObject:repetionLabel.text forKey:@"REPETION"];
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"REPETION"]);
//
	//[self setDataForQuery:[NSString stringWithFormat:@"UPDATE settings SET value = '%@' WHERE title='Purpose'",purpose]];
	//[self setDataForQuery:[NSString stringWithFormat:@"UPDATE settings SET value = '%@' WHERE title='Email'",emailid]];
}

-(IBAction)loseWeightBtnPressed:(id)sender
{
   [settingsLoseWeightOptionBtn setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
   [settingsToneMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
   [settingsGainMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
   purpose=@"Lose Weight";
    repetionText = @"25";
    repetionLabel.text =repetionText;
//    [[NSUserDefaults standardUserDefaults]setObject:repetionText forKey:@"REPETION"];
}

-(IBAction)ToneMuscleBtnPressed:(id)sender
{
	[settingsToneMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
	[settingsLoseWeightOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
	[settingsGainMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
	purpose=@"Tone Muscle";
      repetionText = @"15";
    repetionLabel.text =repetionText;
//    [[NSUserDefaults standardUserDefaults]setObject:repetionText forKey:@"REPETION"];
}

-(IBAction)GainMuscleBtnPressed:(id)sender
{
	[settingsGainMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
	[settingsLoseWeightOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
	[settingsToneMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
    purpose=@"Gain Muscle";
      repetionText = @"10";
    repetionLabel.text =repetionText;
//    [[NSUserDefaults standardUserDefaults]setObject:repetionText forKey:@"REPETION"];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)clearBtn:(id)sender
{
    [settingsLoseWeightOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
    [settingsToneMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
    [settingsGainMuscleOptionBtn setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
    purpose=@"";
    settingsEmailAddressTxt.text=@"";
    
     repetionText = nil;
    repetionLabel.text =@"";
   
 }

- (void)setViewMovedUp:(BOOL)movedUp{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.0];
	// Make changes to the view's frame inside the animation block. They will be animated instead
	// of taking place immediately.
	CGRect rect = self.view.frame;
	//CGRect rect = NewUserNotes.frame;
	if (movedUp)
	{
		viewIsAlreadyUp=YES;
		// If moving up, not only decrease the origin but increase the height so the view 
		// covers the entire screen behind the keyboard.
		rect.origin.y -= 200-80;
		//rect.size.height += kOFFSET_FOR_KEYBOARD;
	}
	else
	{
		viewIsAlreadyUp=NO;
		// If moving down, not only increase the origin but decrease the height.
		rect.origin.y += 200-80;
		//rect.size.height -= kOFFSET_FOR_KEYBOARD;
	}
	self.view.frame = rect;
	[UIView commitAnimations];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(viewIsAlreadyUp==YES)
	[self setViewMovedUp:NO];
    
    
  
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(viewIsAlreadyUp==NO)
	[self setViewMovedUp:YES];


}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    
    [textField resignFirstResponder];

    return  YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [settingsEmailAddressTxt resignFirstResponder];
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
    [repetionText release];
}


@end
