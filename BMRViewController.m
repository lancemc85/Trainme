//
//  BMRViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BMRViewController.h"
#import "ExerciseAppDelegate.h"
#import "FBController.h"
#import "iCodeOauthViewController.h"
#import "TouchSQL.h"
@implementation BMRViewController

@synthesize bmrViewWeightTxt;
@synthesize bmrViewHeightTxt;
@synthesize bmrViewAgeTxt;
@synthesize bmrViewCurrentBMRTxt;
@synthesize bmrViewPreviousBMRTxt;
@synthesize bmrViewDifferenceBMRTxt;
@synthesize bmrViewGenderSwch;
@synthesize bmrViewEmailBtn;
@synthesize bmrViewPushBackBtn;
@synthesize bmrViewPushNextBtn;
@synthesize genderImage;


-(IBAction)pushGoBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)malebtnPressed:(id)sender
{
	genderImage.image=[UIImage imageNamed:@"male-switch.png"];
	isMale=YES;
    [self valueForAllParameters];

}

-(IBAction)femalebtnPressed:(id)sender
{
	genderImage.image=[UIImage imageNamed:@"female-switch.png"];
	isMale=NO;
    [self valueForAllParameters];

}

-(void)viewWillAppear:(BOOL)animated
{
	NSMutableArray *tempCurrentBFArr=[[NSMutableArray alloc]init];
	[tempCurrentBFArr addObjectsFromArray:[self getCurrentBMRData]];
	if ([tempCurrentBFArr count]>0) {
		bmrViewWeightTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"weight"]];
		
		bmrViewHeightTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"height"]];
		
		bmrViewAgeTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"Age"]];
		
          bmrViewCurrentBMRTxt.text=[NSString stringWithFormat:@"%@",[[tempCurrentBFArr objectAtIndex:0] objectForKey:@"CurrentBMR"]];
	}
	NSMutableArray *tempPreviousBFArr=[[NSMutableArray alloc]init];
	[tempPreviousBFArr addObjectsFromArray:[self getPreviousBMRData]];
	if ([tempPreviousBFArr count]>0) {
		bmrViewPreviousBMRTxt.text=[NSString stringWithFormat:@"%@",[[tempPreviousBFArr objectAtIndex:0] objectForKey:@"CurrentBMR"]];
		[self calculateTotalDifference];
	}
	
}
	

-(IBAction)EmailBtnPressed:(id)sender
{
	BMRTitle=@"Basal Metabolic Rate(BMR) Data";
	BMRData =[NSString stringWithFormat:
				  @"<b>Weight              : %@</b><br>"
				  @"<b>Height              : %@</b><br>"				
				  @"<b>Age                 : %@</b><br>"
				  @"<b>Current BMR        : %@</b><br>"
				  @"<b>Previous BMR       : %@</b><br>"
				  @"<b>Difference BMR     : %@</b><br>",
				  bmrViewWeightTxt.text,bmrViewHeightTxt.text,bmrViewAgeTxt.text,
				  bmrViewCurrentBMRTxt.text,bmrViewPreviousBMRTxt.text ,bmrViewDifferenceBMRTxt.text];
	
	[app sendingMail:BMRTitle gettingBody:BMRData];
}  


-(IBAction)facebookBtnPressed:(id)sender
{
	NSString *fbcomment=[NSString stringWithFormat:
						 @"Weight: %@,Height: %@,Age: %@,Current BMR: %@,Previous BMR: %@,Difference BMR: %@",
						 bmrViewWeightTxt.text,bmrViewHeightTxt.text,bmrViewAgeTxt.text,
						 bmrViewCurrentBMRTxt.text,bmrViewPreviousBMRTxt.text ,bmrViewDifferenceBMRTxt.text];
	
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
            if(inputText!=bmrViewHeightTxt)
                [self valueForAllParameters];
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
        if(inputText==bmrViewHeightTxt)
        {
        if(![bmrViewHeightTxt.text isEqualToString:@""])
        {
            NSArray  *separateNums=[bmrViewHeightTxt.text componentsSeparatedByString:@"."];
         
            
            int fraction=0;
            
            if([separateNums count]>1)
            {
                fraction=[[separateNums objectAtIndex:1] intValue];
                if(fraction%10==0)
                    fraction =fraction/10;
                
                NSLog(@"fraction %d",fraction);
                if (fraction>=0 && fraction<=11) 
                {
                    NSLog(@"here");
                    
                }
                            else
                            {
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Enter Proper Height" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                               
                                [alert show];
                                [alert release];
                                [bmrViewHeightTxt setText:nil];
                                // bodyFatHeightTxt.text = nil;
                                return ;
                            }
            }}
       
        
            
                if (bmrViewHeightTxt.text.length >4)
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Enter Proper Height" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                    
                    [alert show];
                    [alert release];
                    [bmrViewHeightTxt setText:nil];
                    return;
                }
        }
            
        

}



-(NSArray *)getCurrentBMRData;
{
	NSString *Query;
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	if(isMale){
	Query = [NSString stringWithFormat:@"select * from BMR where rowid=(select MAX(rowid) from BMR) and Gender='Male' "];
	}
	else{
		Query = [NSString stringWithFormat:@"select * from BMR where rowid=(select MAX(rowid) from BMR) and Gender='Female' "];
	}
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	return rows;
}
-(NSArray *)getPreviousBMRData;
{
	
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];

	NSString *Query = [NSString stringWithFormat:@"select * from BMR where rowid=(select MAX(rowid)-1 from BMR)"];
	
	
	
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	NSLog(@"row is:%@",rows);
	return rows;
}



-(IBAction)saveCurrentBMRdata:(id)sender
{
	[self valueForAllParameters];
	NSString *gender;
	if(isMale)
	{
		gender=@"Male";
	}
	else
	{
		gender=@"Female";
	}
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];	
NSString *Query = [NSString stringWithFormat:@"insert into BMR (Gender,weight,height,Age,CurrentBMR) Values('%@','%@','%@','%@','%@')",gender,bmrViewWeightTxt.text,bmrViewHeightTxt.text,bmrViewAgeTxt.text,bmrViewCurrentBMRTxt.text];
    [db executeExpression:Query error:NULL];
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clearBtn:(id)sender
{
    bmrViewWeightTxt.text=@"";
    
    bmrViewHeightTxt.text=@"";
    
    bmrViewAgeTxt.text=@"";    
    bmrViewCurrentBMRTxt.text=@"";
    bmrViewPreviousBMRTxt.text=@"";
    [self valueForAllParameters];
    //[self calculateTotalDifference];
}

-(IBAction)genderSwitch:(id)sender{
    [self valueForAllParameters];
}

-(void)valueForAllParameters
{
	if([bmrViewAgeTxt.text isEqualToString:@""]||[bmrViewHeightTxt.text isEqualToString:@""]||[bmrViewWeightTxt.text isEqualToString:@""])
	{
		bmrViewCurrentBMRTxt.text=@"";
	}
	
	
	float weight=[bmrViewWeightTxt.text floatValue];
	int age     =[bmrViewAgeTxt.text intValue];
	float Height=[bmrViewHeightTxt.text floatValue];
	NSLog(@"height : %.2f",Height);
    
    if(Height!=0.00){
	NSString *heightstr=[NSString stringWithFormat:@"%.2f",Height];
	if(![heightstr isEqualToString:@""])
	{
		NSArray  *separateNums=[heightstr componentsSeparatedByString:@"."];
		int realnum=[[separateNums objectAtIndex:0] intValue];
        NSLog(@"Real Num %d",realnum);
        NSLog(@"seprate nums %@",separateNums);
        int fraction=0;
        
        if([separateNums count]>1)
        {
            fraction=[[separateNums objectAtIndex:1] intValue];
            if(fraction%10==0)
                fraction =fraction/10;
            
            NSLog(@"fraction %d",fraction);
            if (fraction>=0 && fraction<=12) 
            {
                NSLog(@"here");
                
            }
//            else
//            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Enter Proper Height" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//                
//                [alert show];
//                [alert release];
//                [bmrViewHeightTxt setText:@""];
//                // bodyFatHeightTxt.text = @"";
//                return ;
//            }
            
            //     int inchesFirstDig = ceilf(fraction/100.00);
            //NSLog(@"sdefgsgg %@",fractionstr);

        }
            
        NSLog(@"fraction Num %d",fraction);

		int inches=realnum*12+fraction;
        
        NSLog(@"Inches %d",inches);
        NSLog(@"Weight %f",weight);
        NSLog(@"Age %d",age);
        NSLog(@"Height %f",Height);
		
		if(isMale==YES)
		{
			float MenBMR  =66+(6.23*weight)+(12.7*inches)-(6.8*age);
			bmrViewCurrentBMRTxt.text=[NSString stringWithFormat:@"%.2f",MenBMR];	
        }
		else
		{
			float WomenBMR=655+(4.35*weight)+(4.7*inches)-(4.7*age);
			bmrViewCurrentBMRTxt.text=[NSString stringWithFormat:@"%.2f",WomenBMR];	
        }}
		[self calculateTotalDifference];
	}

}
-(void)calculateTotalDifference;
	{
		if([bmrViewPreviousBMRTxt.text isEqualToString:@""])
		{
			float TotalDifference=[bmrViewCurrentBMRTxt.text floatValue]-0;
			bmrViewDifferenceBMRTxt.text=[NSString stringWithFormat:@"%.2f",TotalDifference];
			
		}
		else{
			float TotalDifference=[bmrViewCurrentBMRTxt.text floatValue]-[bmrViewPreviousBMRTxt.text floatValue];
			bmrViewDifferenceBMRTxt.text=[NSString stringWithFormat:@"%.2f",TotalDifference];
		}
		
		
	}


-(IBAction)twitterBtnPressed:(id)sender
{
	iCodeOauthViewController *icodeObj=[[iCodeOauthViewController alloc]init];
	NSString *twtrcomment=[NSString stringWithFormat:
						   @"Weight: %@,Height: %@,Age: %@,Current BMR: %@,Previous BMR: %@,Difference BMR: %@",
						   bmrViewWeightTxt.text,bmrViewHeightTxt.text,bmrViewAgeTxt.text,
						   bmrViewCurrentBMRTxt.text,bmrViewPreviousBMRTxt.text ,bmrViewDifferenceBMRTxt.text];
    [icodeObj setTwitterMsg:twtrcomment];
	[self.navigationController pushViewController:icodeObj animated:NO];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if(textField == bmrViewHeightTxt){
//        if (bmrViewHeightTxt.text.length >=4)
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Enter Proper Height" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//            
//            [alert show];
//            [alert release];
//            [bmrViewHeightTxt setText:nil]; // return NO to not change text
//        }
//        else
//        {return YES;}
//    }
    return YES;
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

-(void)viewWillDisappear:(BOOL)animated{
    
    [bmrViewWeightTxt resignFirstResponder];
	[bmrViewHeightTxt resignFirstResponder];
	[bmrViewAgeTxt resignFirstResponder];
	[bmrViewCurrentBMRTxt resignFirstResponder];
	[bmrViewPreviousBMRTxt resignFirstResponder];
	[bmrViewDifferenceBMRTxt resignFirstResponder];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	isMale=YES;
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
