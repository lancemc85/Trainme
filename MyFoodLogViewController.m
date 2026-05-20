//
//  MyFoodLogViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyFoodLogViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
#import "FBController.h"
#import "iCodeOauthViewController.h"


@implementation MyFoodLogViewController

@synthesize myFoodLogTotaltxtfld;
@synthesize myFoodLogProteinTxt;
@synthesize myFoodLogCarbohydratesTxt;
@synthesize myFoodLogSugarTxt;
@synthesize myFoodLogFatTxt;
@synthesize myFoodLogClearBtn;
@synthesize myFoodLogNotesTxtView;
@synthesize myFoodLogEmailBtn;
@synthesize myFoodLogPushBackBtn;
@synthesize MyFoodData;
@synthesize MyFoodTitle;




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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
	NSMutableArray *tempArr=[[NSMutableArray alloc]init];
	[tempArr addObjectsFromArray:[self getFoodLogData]];
	if ([tempArr count]>0) 
	{
		myFoodLogTotaltxtfld.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"calories"]];
		myFoodLogProteinTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"protein"]];
		myFoodLogCarbohydratesTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"carbohydrates"]];
		myFoodLogSugarTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"sugar"]];
        myFoodLogFatTxt.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"fat"]];
		myFoodLogNotesTxtView.text=[NSString stringWithFormat:@"%@",[[tempArr objectAtIndex:0] objectForKey:@"Notes"]];
	
	
	
	}
	
}

-(NSArray *)getFoodLogData;
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from FoodLog where rowid=(select MAX(rowid) from FoodLog)  "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	return rows;
}


-(IBAction)saveMyFoodLogdata:(id)sender
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];	
	NSString *Query = [NSString stringWithFormat:@"insert into FoodLog (calories,protein,carbohydrates,sugar,Notes,fat) Values('%@','%@','%@','%@','%@','%@')", myFoodLogTotaltxtfld.text,myFoodLogProteinTxt.text,myFoodLogCarbohydratesTxt.text,myFoodLogSugarTxt.text,myFoodLogNotesTxtView.text,myFoodLogFatTxt.text];
	[db executeExpression:Query error:NULL];
	[self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)pushClearBtn:(id)sender
{
	myFoodLogTotaltxtfld.text=@"";
    myFoodLogProteinTxt.text=@"";
	myFoodLogCarbohydratesTxt.text=@"";
	myFoodLogSugarTxt.text=@"";
    myFoodLogFatTxt.text=@"";
}


-(IBAction)pushEmailBtn:(id)sender
{
	MyFoodTitle=@"MyFood Data";
	MyFoodData =[NSString stringWithFormat:
					  @"<b>Calories         : %@</b><br>"
					  @"<b>Proteins         : %@</b><br>"				
					  @"<b>Carbohydrates    : %@</b><br>"
				      @"<b>Sugar            : %@</b><br>"
                      @"<b>Notes            : %@</b><br>",
				 myFoodLogTotaltxtfld.text,myFoodLogProteinTxt.text,
				 myFoodLogCarbohydratesTxt.text,
				 myFoodLogSugarTxt.text,myFoodLogNotesTxtView.text];	
	
	[app sendingMail:MyFoodTitle gettingBody:MyFoodData];
}

-(IBAction)facebookBtnPressed:(id)sender
{
	NSString *fbcomment=[NSString stringWithFormat:@"Calories: %@,Proteins: %@,Carbohydrates: %@,Sugar: %@,Notes: %@",
						 myFoodLogTotaltxtfld.text,myFoodLogProteinTxt.text,
						 myFoodLogCarbohydratesTxt.text,myFoodLogSugarTxt.text,myFoodLogNotesTxtView.text];
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
	NSString *twtrcomment=[NSString stringWithFormat:@"Calories: %@,Proteins: %@,Carbohydrates: %@,Sugar: %@,Notes: %@",
						   myFoodLogTotaltxtfld.text,myFoodLogProteinTxt.text,
						   myFoodLogCarbohydratesTxt.text,myFoodLogSugarTxt.text,myFoodLogNotesTxtView.text]; 
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if((textField ==myFoodLogFatTxt) || (textField ==myFoodLogSugarTxt))
	     [self setViewMovedUp:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if((textField ==myFoodLogFatTxt) || (textField ==myFoodLogSugarTxt))
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
		rect.origin.y -= 230-105;
		//rect.size.height += kOFFSET_FOR_KEYBOARD;
	}
	else
	{
		
		// If moving down, not only increase the origin but decrease the height.
		rect.origin.y += 230-105;
		//rect.size.height -= kOFFSET_FOR_KEYBOARD;
	}
	self.view.frame = rect;
	[UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if([text isEqualToString:@"\n"])
	{
		[myFoodLogNotesTxtView resignFirstResponder];
	}
	return YES;
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[self setViewMovedUp:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	[self setViewMovedUp:NO];
}

-(IBAction)changeValue:(id)sender
{
	
    UITextField *inputText=(UITextField *)sender;
    
    const char* cString = [inputText.text UTF8String]; 
    
    for (int i = 0; i < [inputText.text length]; i++)
    {
        
        if ((cString[i] >= '0' && cString[i] <= '9')||cString[i]=='.')
        {
            specialCharacterPresent=NO;
            
            NSLog(@"rr%c",cString[i]);
            //[self valueForAllParameters];
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

-(void)viewWillDisappear:(BOOL)animated
{
    [myFoodLogTotaltxtfld resignFirstResponder];
	[myFoodLogProteinTxt resignFirstResponder];
	[myFoodLogCarbohydratesTxt resignFirstResponder];
	[myFoodLogSugarTxt resignFirstResponder];
    [myFoodLogFatTxt resignFirstResponder];
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
