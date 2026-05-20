//
//  BodyFatViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BodyFatViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
#import "FBController.h"
#import "iCodeOauthViewController.h"

@implementation BodyFatViewController
@synthesize bodyFatWeightTxt;
@synthesize bodyFatWristTxt;
@synthesize bodyFatWaistTxt;
@synthesize bodyFatHipsTxt;
@synthesize bodyFatforearmTxt;
@synthesize bodyFatCurrentBFlbl;
@synthesize bodyFatPreviousBFlbl;
@synthesize bodyFatDifferenceBFlbl;
@synthesize bodyFatEmailBtn;
@synthesize bodyFatPushBackBtn;
@synthesize BodyFatData;
@synthesize BodyFatTitle;
@synthesize genderImage;
@synthesize malebtn;
@synthesize femalebtn;




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
-(IBAction)EmailBtnPressed:(id)sender
{
	BodyFatTitle=@"Body fat Data";
	BodyFatData =[NSString stringWithFormat:
					  @"<b>Weight              : %@</b><br>"
					  @"<b>Wrist               : %@</b><br>"				
					  @"<b>Waist(at Narrowest) : %@</b><br>"
					  @"<b>Hips(at Widest)     : %@</b><br>"
					  @"<b>Forearm             :  %@</b><br>"
					  @"<b>Current BF(percent) : %@ </b><br>"
					  @"<b>Previous BF(percent): %@</b><br>"
					  @"<b>Difference BF(percent): %@</b><br>",
					  bodyFatWeightTxt.text,bodyFatWristTxt.text,bodyFatWaistTxt.text,
					  bodyFatHipsTxt.text,bodyFatforearmTxt.text,bodyFatCurrentBFlbl.text,
					  bodyFatPreviousBFlbl.text ,bodyFatDifferenceBFlbl.text];
	
	[app sendingMail:BodyFatTitle gettingBody:BodyFatData];
}  

-(IBAction)facebookBtnPressed:(id)sender
{
	NSString *fbcomment=[NSString stringWithFormat:
						 @"Weight: %@,Wrist: %@,Waist(at Narrowest): %@,Hips(at Widest): %@,Forearm: %@,Current BF%%: %@,Previous BF%%: %@,Difference BF%%: %@",
						 bodyFatWeightTxt.text,bodyFatWristTxt.text,bodyFatWaistTxt.text,
						 bodyFatHipsTxt.text,bodyFatforearmTxt.text,bodyFatCurrentBFlbl.text,
						 bodyFatPreviousBFlbl.text ,bodyFatDifferenceBFlbl.text];
	
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
	NSString *twtrcomment=[NSString stringWithFormat:
						   @"Weight: %@,Wrist: %@,Waist(at Narrowest): %@,Hips(at Widest): %@,Forearm: %@,Current BF%%: %@,Previous BF%%: %@,Difference BF%%: %@",
						   bodyFatWeightTxt.text,bodyFatWristTxt.text,bodyFatWaistTxt.text,
						   bodyFatHipsTxt.text,bodyFatforearmTxt.text,bodyFatCurrentBFlbl.text,
						   bodyFatPreviousBFlbl.text ,bodyFatDifferenceBFlbl.text];
    [icodeObj setTwitterMsg:twtrcomment];
	[self.navigationController pushViewController:icodeObj animated:NO];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	isMale=YES;
    [self configuration];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
	NSMutableArray *tempCurrentBFArr=[[NSMutableArray alloc]init];
	[tempCurrentBFArr addObjectsFromArray:[self getCurrentBodyFatData]];
	if ([tempCurrentBFArr count]>0) {
		bodyFatWeightTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"Weight"]];
        bodyFatWaistTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"Waist"]];
        if(isMale)
        {
            bodyFatWristTxt.text=NULL;
            bodyFatforearmTxt.text=NULL;
            bodyFatforearmTxt.text=NULL;
        }
        else{
	
		bodyFatWristTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"Height"]];
        bodyFatHipsTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"Hips"]];
        bodyFatforearmTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"Neck"]];
        }
		
		bodyFatCurrentBFlbl.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"CurrentBF"]];
	}
   
	NSMutableArray *tempPreviousBFArr=[[NSMutableArray alloc]init];
	[tempPreviousBFArr addObjectsFromArray:[self getPreviousBodyFatData]];
	if ([tempPreviousBFArr count]>0) {
	bodyFatPreviousBFlbl.text=[NSString stringWithFormat:@"%@",[[tempPreviousBFArr objectAtIndex:0] objectForKey:@"CurrentBF"]];
	[self calculateTotalDifference];
	}
	
	
	//[self valuesOfAllParameters];
	
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
            if(inputText!=bodyFatWeightTxt)
                [self valuesOfAllParameters];
        }
        else
        {
            NSLog(@"eeee%c",cString[i]);
            specialCharacterPresent= YES;
        }
        if(cString[i]=='.')
        {
            if(count==1)
            {
                specialCharacterPresent=NO;
                count=0;
            }
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
//    if(inputText==bodyFatWristTxt)
//    {
//    if(![bodyFatWristTxt.text isEqualToString:@""])
//    {
//        NSArray *separateNums=[bodyFatWristTxt.text componentsSeparatedByString:@"."];
//        
//        NSString *fractionstr;
//        int fraction=0;
//        if([separateNums count]>1)
//        {
//            fractionstr=[separateNums objectAtIndex:1];             
//            
//            fraction=[fractionstr intValue];
//            
//            if(fraction%10==0)
//                fraction =fraction/10;
//            
//            NSLog(@"fraction %d",fraction);
//            if (fraction>=0 && fraction<=11) 
//            {
//                
//                
//            }
//            else
//            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Enter Proper Height" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//                
//                [alert show];
//                [alert release];
//                [bodyFatWristTxt setText:nil];
//                return; 
//            }
//        }
//    }
//                    if (bodyFatWristTxt.text.length >4)
//            {
//                
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Enter Proper Height" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//                
//                            [alert show];
//                            [alert release];
//                [bodyFatWristTxt setText:nil];
//                return;
//            }
//    }
    
}




-(NSArray *)getCurrentBodyFatData;
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	
	NSString *Query = [NSString stringWithFormat:@"select * from BodyFat where rowid=(select MAX(rowid) from BodyFat)  "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	return rows;
}
-(NSArray *)getPreviousBodyFatData;
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from BodyFat where rowid=(select MAX(rowid)-1 from BodyFat)  "];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	return rows;
}


-(IBAction)saveCurrentWeightdata:(id)sender
{
    if([bodyFatWeightTxt.text isEqualToString:@""]||[bodyFatWaistTxt.text isEqualToString:@""])
	{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"All Active fields are required" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [alert release];

	}
    else
    {

	[self valuesOfAllParameters];
	NSString *gender;
	if(isMale)
	{
		gender=@"Male";
        
        CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
        [db open:NULL];	
        NSString *Query = [NSString stringWithFormat:@"insert into BodyFat (Gender,Weight,Height,Waist,Hips,Neck,CurrentBF) Values('%@','%@','%@','%@','%@','%@','%@')",gender,bodyFatWeightTxt.text,bodyFatWristTxt.text,bodyFatWaistTxt.text,
                           bodyFatHipsTxt.text,bodyFatforearmTxt.text,bodyFatCurrentBFlbl.text ];
        [db executeExpression:Query error:NULL];
        [self.navigationController popViewControllerAnimated:YES];
	}
	if(!isMale)
	{
		gender=@"Female";
        if(bodyFatHipsTxt.text==@""||bodyFatWristTxt.text==@""||bodyFatforearmTxt.text==@""||bodyFatHipsTxt.text==NULL||bodyFatWristTxt.text==NULL||bodyFatHipsTxt.text==NULL)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"All fields are required" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        else{
        CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
        [db open:NULL];	
        NSString *Query = [NSString stringWithFormat:@"insert into BodyFat (Gender,Weight,Height,Waist,Hips,Neck,CurrentBF) Values('%@','%@','%@','%@','%@','%@','%@')",gender,bodyFatWeightTxt.text,bodyFatWristTxt.text,bodyFatWaistTxt.text,
                           bodyFatHipsTxt.text,bodyFatforearmTxt.text,bodyFatCurrentBFlbl.text ];
        [db executeExpression:Query error:NULL];
            [self.navigationController popViewControllerAnimated:YES];
        }
	}
	
	}
}

-(IBAction)clearBtn:(id)sender
{
    bodyFatWeightTxt.text=@"";
    
    bodyFatWristTxt.text=@"";
    
    bodyFatWaistTxt.text=@"";
    
    bodyFatHipsTxt.text=@"";    
    bodyFatforearmTxt.text=@"";    
    bodyFatCurrentBFlbl.text=@""; 
    bodyFatPreviousBFlbl.text=@"";
    [self valuesOfAllParameters];
	[self calculateTotalDifference];
}

-(void)valuesOfAllParameters
{
    if(isMale){
	if([bodyFatWeightTxt.text isEqualToString:@""]||[bodyFatWaistTxt.text isEqualToString:@""])
	{
		bodyFatCurrentBFlbl.text=@"";
	}
        else
        {
            float wrist=[bodyFatWristTxt.text floatValue];
            float hips=[bodyFatHipsTxt.text floatValue];//shiva interchanged waist and hips
            float waist=[bodyFatWaistTxt.text floatValue];//shiva
            float forearm=[bodyFatforearmTxt.text floatValue];
            float weight=[bodyFatWeightTxt.text floatValue];
            
            NSLog(@"Weight %f",weight);
            NSLog(@"Wrist %f",wrist);
            NSLog(@"Waist %f",waist);
            NSLog(@"Hips %f ",hips);
            NSLog(@"neck %f",forearm);
           bodyfat=((weight-(((weight*1.082)+94.42)-(waist*4.15)))*100)/weight;  
        }
    }
            else
            {
                if([bodyFatWristTxt.text isEqualToString:@""]||[bodyFatforearmTxt.text isEqualToString:@""]||[bodyFatHipsTxt.text isEqualToString:@""]||[bodyFatWaistTxt.text isEqualToString:@""]||[bodyFatWeightTxt.text isEqualToString:@""])
                {
                    bodyFatCurrentBFlbl.text=@"";
                }

            else
            {
                
                float wrist=[bodyFatWristTxt.text floatValue];
                float hips=[bodyFatHipsTxt.text floatValue];//shiva interchanged waist and hips
                float waist=[bodyFatWaistTxt.text floatValue];//shiva
                float forearm=[bodyFatforearmTxt.text floatValue];
                float weight=[bodyFatWeightTxt.text floatValue];
                
                NSLog(@"Weight %f",weight);
                NSLog(@"Wrist %f",wrist);
                NSLog(@"Waist %f",waist);
                NSLog(@"Hips %f ",hips);
                NSLog(@"neck %f",forearm);
                bodyfat=((weight-(((((weight*.732)+8.987+(wrist/3.14))-(waist*.157))-(hips*.249))+(forearm*.434)))*100)/weight;	

        }
            
	}
	bodyFatCurrentBFlbl.text=[NSString stringWithFormat:@"%.2f",bodyfat];
		[self calculateTotalDifference];
	
	
}

// added by puneet
-(void)configuration
{
  if(isMale)
  {
      
      [bodyFatWristTxt setUserInteractionEnabled:NO];
      bodyFatWristTxt.text=NULL;
       [bodyFatHipsTxt setUserInteractionEnabled:NO];
       bodyFatHipsTxt.text=NULL;
       [bodyFatforearmTxt setUserInteractionEnabled:NO];
       bodyFatforearmTxt.text=NULL;
      bodyFatHipslbl.textColor=[UIColor grayColor];
        bodyFatWristlbl.textColor=[UIColor grayColor];
        bodyFatforearmlbl.textColor=[UIColor grayColor];
  }
    else
    {
        NSLog(@"wriststr is %@:",wriststr);
        [bodyFatWristTxt setUserInteractionEnabled:YES];
        bodyFatWristTxt.text=wriststr;
        [bodyFatHipsTxt setUserInteractionEnabled:YES];
        bodyFatHipsTxt.text=hipsstr;
        [bodyFatforearmTxt setUserInteractionEnabled:YES];
        bodyFatforearmTxt.text=forearmstr;
        bodyFatHipslbl.textColor=[UIColor blackColor];
        bodyFatWristlbl.textColor=[UIColor blackColor];
        bodyFatforearmlbl.textColor=[UIColor blackColor];
        
    }
    
    
}

-(void)calculateTotalDifference{
	//float currentBf=[bodyFatCurrentBFlbl.text floatValue];	
//	float PreviousBf=[bodyFatPreviousBFlbl.text floatValue];
	
	
	if([bodyFatPreviousBFlbl.text isEqualToString:@""])
	{
		float TotalDifference=[bodyFatCurrentBFlbl.text floatValue]-0;
	bodyFatDifferenceBFlbl.text=[NSString stringWithFormat:@"%.2f",TotalDifference];
		
	}
	else{
		float TotalDifference=[bodyFatCurrentBFlbl.text floatValue]-[bodyFatPreviousBFlbl.text floatValue];
		bodyFatDifferenceBFlbl.text=[NSString stringWithFormat:@"%.2f",TotalDifference];
}

}
-(IBAction)malebtnPressed:(id)sender
{
	genderImage.image=[UIImage imageNamed:@"male-switch.png"];
	isMale=YES;
     [self configuration];
[self valuesOfAllParameters];
    MFlbl.text = @"Waist (At Navel)";
    

}

-(IBAction)femalebtnPressed:(id)sender
{
	genderImage.image=[UIImage imageNamed:@"female-switch.png"];
	isMale=NO;
     [self configuration];
    [self valuesOfAllParameters];
   MFlbl.text = @"Waist (At Narrowest)";

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
if(textField == bodyFatWristTxt){
    wriststr=[bodyFatWristTxt.text retain];
    
}
if(textField == bodyFatHipsTxt){
    hipsstr=[bodyFatHipsTxt.text retain];
}
if(textField == bodyFatforearmTxt){
    forearmstr=[bodyFatforearmTxt.text retain];
}



	[self setViewMovedUp:NO];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
       
    return YES;
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
		rect.origin.y -= 230-180;
		//rect.size.height += kOFFSET_FOR_KEYBOARD;
	}
	else
	{
		
		// If moving down, not only increase the origin but decrease the height.
		rect.origin.y += 230-180;
		//rect.size.height -= kOFFSET_FOR_KEYBOARD;
	}
	self.view.frame = rect;
	[UIView commitAnimations];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [bodyFatWeightTxt resignFirstResponder];
	[bodyFatWristTxt resignFirstResponder];
	[bodyFatWaistTxt  resignFirstResponder];
	[bodyFatHipsTxt resignFirstResponder];
	[bodyFatforearmTxt resignFirstResponder];
}

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
