//
//  WeightCalculatorViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeightCalculatorViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
#import "FBController.h"
#import "iCodeOauthViewController.h"


@implementation WeightCalculatorViewController

@synthesize weightCalcCurrentWeightTxt;
@synthesize weightCalcPreviousWeightTxt;
@synthesize weightCalcTotalDifferenceTxt;
@synthesize weightCalcEmailBtn;
@synthesize weightCalcPushBackBtn;
@synthesize WeightCalData;
@synthesize WeightCalTitle;




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
- (void)viewDidLoad
{
    [super viewDidLoad];
	temp=@"";
}

-(void)viewWillAppear:(BOOL)animated
{
	NSMutableArray *tempCurrentweightArr=[[NSMutableArray alloc]init];
	[tempCurrentweightArr addObjectsFromArray:[self getCurrentweightData]];
	if ([tempCurrentweightArr count]>0) {
	weightCalcCurrentWeightTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentweightArr objectAtIndex:0] objectForKey:@"Currentweight"]];	
	}
	NSMutableArray *tempPreviousweightArr=[[NSMutableArray alloc]init];
	[tempPreviousweightArr addObjectsFromArray:[self getPreviousweightData]];
	if ([tempPreviousweightArr count]>0) {
		weightCalcPreviousWeightTxt.text=[NSString stringWithFormat:@"%@",[[tempPreviousweightArr objectAtIndex:0] objectForKey:@"Currentweight"]];	
	}
	
	
	//weightCalcPreviousWeightTxt.text=temp;
//	NSString *currentwght=weightCalcCurrentWeightTxt.text;
//	temp=currentwght;
	if([weightCalcPreviousWeightTxt.text isEqualToString:@""])
	{
		int differnce=[weightCalcCurrentWeightTxt.text intValue]-0;
			weightCalcTotalDifferenceTxt.text=[NSString stringWithFormat:@"%d",differnce];
		
	}
	else{
		int differnce=[weightCalcCurrentWeightTxt.text intValue]-[weightCalcPreviousWeightTxt.text intValue];
			weightCalcTotalDifferenceTxt.text=[NSString stringWithFormat:@"%d",differnce];
	}


}



-(NSArray *)getCurrentweightData;
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from WeightCal where rowid=(select MAX(rowid) from WeightCal)  "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	return rows;
}
-(NSArray *)getPreviousweightData;
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from WeightCal where rowid=(select MAX(rowid)-1 from WeightCal)  "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	return rows;
}


-(IBAction)saveCurrentWeightdata:(id)sender
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];	
	NSString *Query = [NSString stringWithFormat:@"insert into WeightCal (Currentweight) Values('%@')", weightCalcCurrentWeightTxt.text];
	[db executeExpression:Query error:NULL];
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clearBtn:(id)sender
{
    weightCalcCurrentWeightTxt.text=@"";
    weightCalcPreviousWeightTxt.text=@"";
    if([weightCalcPreviousWeightTxt.text isEqualToString:@""])
	{
		int differnce=[weightCalcCurrentWeightTxt.text intValue]-0;
        weightCalcTotalDifferenceTxt.text=[NSString stringWithFormat:@"%d",differnce];
		
	}
	else{
		int differnce=[weightCalcCurrentWeightTxt.text intValue]-[weightCalcPreviousWeightTxt.text intValue];
        weightCalcTotalDifferenceTxt.text=[NSString stringWithFormat:@"%d",differnce];
	}

	
}

-(IBAction)EmailBtnPressed:(id)sender
{
	WeightCalTitle=@"Weight Calculator Data";
	WeightCalData =[NSString stringWithFormat:
					  @"<b>Current Weight          : %@</b><br>"
					  @"<b>Previous Weight         : %@</b><br>"				
					  @"<b>Total Difference        : %@</b><br>",
					  weightCalcCurrentWeightTxt.text,weightCalcPreviousWeightTxt.text,
					  weightCalcTotalDifferenceTxt.text];
						
	[app sendingMail:WeightCalTitle gettingBody:WeightCalData];
	

}

-(IBAction)facebookBtnPressed:(id)sender
{
	NSString *fbcomment=[NSString stringWithFormat:@"Current Weight: %@,Previous Weight: %@,Total Difference: %@",
						 weightCalcCurrentWeightTxt.text,weightCalcPreviousWeightTxt.text,
						 weightCalcTotalDifferenceTxt.text];
	
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

-(IBAction)twitterBtnPressed:(id)sender
{
	iCodeOauthViewController *icodeObj=[[iCodeOauthViewController alloc]init];
	NSString *twtrcomment=[NSString stringWithFormat:@"Current Weight: %@,Previous Weight: %@,Total Difference: %@",
						   weightCalcCurrentWeightTxt.text,weightCalcPreviousWeightTxt.text,
						   weightCalcTotalDifferenceTxt.text];
	[icodeObj setTwitterMsg:twtrcomment];
	[self.navigationController pushViewController:icodeObj animated:NO];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


- (void)textFieldDidBeginEditing:(UITextField *)textField
{ 
		 count=0;
    [self setViewMovedUp:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
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
		rect.origin.y -= 230-160;
		//rect.size.height += kOFFSET_FOR_KEYBOARD;
	}
	else
	{
		
		// If moving down, not only increase the origin but decrease the height.
		rect.origin.y += 230-160;
		//rect.size.height -= kOFFSET_FOR_KEYBOARD;
	}
	self.view.frame = rect;
	[UIView commitAnimations];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [weightCalcCurrentWeightTxt resignFirstResponder];
	[weightCalcPreviousWeightTxt resignFirstResponder];
	[weightCalcTotalDifferenceTxt resignFirstResponder];
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
