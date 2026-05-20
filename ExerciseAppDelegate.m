//
//  ExerciseAppDelegate.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExerciseAppDelegate.h"
#import "HomeViewController.h"
#import "TimerViewController.h"
#import "TunesViewController.h"
#import "SearchViewController.h"
#import "MoreViewController.h"
#import "SettingsViewController.h"
#import "TouchSQL.h"
ExerciseAppDelegate *app=nil;

@implementation ExerciseAppDelegate

@synthesize window;
@synthesize  homeViewController;
@synthesize  timerViewController;
@synthesize  tunesViewController;
@synthesize  searchViewController;
@synthesize  moreViewController;
@synthesize  homenavController;
@synthesize  timernavController;
@synthesize  tunesnavController;
@synthesize  searchnavController;
@synthesize  morenavController;
@synthesize  mailController;
@synthesize  tabBarCtrl;
@synthesize count;
@synthesize isDirtyThirty;
@synthesize DirtyThirtyExerciseArray,Workout_id;
@synthesize workoutName;
@synthesize exerciseId;
@synthesize  dirtyThirtybuttonIndex;
@synthesize  ExerciseName;
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    //UITextField *textField;
    //UITextField *textField2;
   
    NSString *termsStr=[NSString stringWithFormat:@"WARNINGS, TERMS & CONDITIONS:"@"\n\n"
                        @" -This application is intended for the educational and entertainment purposes only"@"\n\n"
                        @" -You may be injured, incur damages or even die if you apply or train in these techniques,and you agree that neither ResurrectionFitness, Inc. nor the co-developers are responsible for any such injury, damages or death."@"\n\n"
                        @" -Should you decide to attempt these techniques, YOU DO SO AT YOUR OWN RISK; it is also essential that you consult with your doctor first, & to always train them under the supervision of a qualified instructor."@"\n\n"
                        @"-We cannot guarantee that these techniques will result in weight loss, muscle gain or maintenance due to variables of genetics and precision of exercise regimen as well as consistency of the program."@"\n\n"
                        @" IF YOU DO NOT AGREE TO THE ABOVE WARNINGS, TERMS AND CONDITIONS, COSE THE APPLICATION BY CLICKING THE HOME BUTTON ON THE iPHONE OR iPOD TOUCH AND DELETE THE RESURRECTION FITNESS APPLICATION. "@"\n\n"
                        @"(I HAVE READ AND ACCEPT THE TERMS & CONDITIONS) "@"\n\n"@"\n\n"];

    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Terms and Conditions" 
                                                     message:termsStr // IMPORTANT
                                                    delegate:self 
                                           cancelButtonTitle:@"Cancel" 
                                           otherButtonTitles:@"Accept", nil];
   // CGRect frame = prompt.frame;
    //frame.origin.y -= 100.0f;
    //prompt.frame = frame;
    
//        //    [textField setPlaceholder:@"username"];
   //[prompt addSubview:termsTextView];
////    
//    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 85.0, 260.0, 25.0)]; 
//    [textField2 setBackgroundColor:[UIColor whiteColor]];
//    [textField2 setPlaceholder:@"password"];
//    [textField2 setSecureTextEntry:YES];
   // [prompt addSubview:textField2];
    
    // set place
  //  [prompt setTransform:CGAffineTransformMakeTranslation(0.0, 170.0)];
    [prompt show];
    [prompt release];
    
    // set cursor and show keyboard
   
    // Override point for customization after application launch.
	app=self;
	[self checkAndCreateDatabase];
	
	count=0;
	homeViewController    = [[HomeViewController alloc]initWithNibName:@"HomeViewController"	bundle:[NSBundle mainBundle]];
	timerViewController   = [[TimerViewController alloc]initWithNibName:@"TimerViewController"	bundle:[NSBundle mainBundle]];
	tunesViewController   = [[TunesViewController alloc]initWithNibName:@"TunesViewController"	bundle:[NSBundle mainBundle]];
	searchViewController  = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:[NSBundle mainBundle]];
	moreViewController    = [[MoreViewController alloc]initWithNibName:@"MoreViewController"    bundle:[NSBundle mainBundle]];
	videoView=[[videoViewController alloc]initWithNibName:@"videoViewController" bundle:[NSBundle mainBundle]];
	homenavController     = [[UINavigationController alloc]initWithRootViewController:homeViewController];
	timernavController    = [[UINavigationController alloc]initWithRootViewController:timerViewController];
	tunesnavController    = [[UINavigationController alloc]initWithRootViewController:tunesViewController];
	searchnavController   = [[UINavigationController alloc]initWithRootViewController:searchViewController];
	morenavController     = [[UINavigationController alloc]initWithRootViewController:moreViewController];
	
	UITabBarItem *hometabBarItem =    [[UITabBarItem alloc] initWithTitle: @"Home" image:[UIImage imageNamed: @"home1.png"] tag:0];
	homenavController.tabBarItem =    hometabBarItem;
	homenavController.navigationBarHidden=YES;
	[hometabBarItem release];
	
	UITabBarItem *timertabBarItem = [[UITabBarItem alloc] initWithTitle: @" Timer" image:[UIImage imageNamed: @"timer.png"] tag:1];
	
	timernavController.tabBarItem = timertabBarItem;
	
	timernavController.navigationBarHidden=YES;
	timerViewController.isDoWorkout=YES;
	[timertabBarItem release];
	
	UITabBarItem *tunestabBarItem = [[UITabBarItem alloc] initWithTitle: @" Tunes" image:[UIImage imageNamed: @"tunes.png"] tag:2];
	tunesnavController.tabBarItem = tunestabBarItem;
	tunesnavController.navigationBarHidden=YES;
	
	[tunestabBarItem release];
	
	UITabBarItem *searchtabBarItem = [[UITabBarItem alloc] initWithTitle: @" Search" image:[UIImage imageNamed: @"search.png"] tag:3];
	searchnavController.tabBarItem = searchtabBarItem;
	searchnavController.navigationBarHidden=YES;
	[searchtabBarItem release];
	
	UITabBarItem *moretabBarItem = [[UITabBarItem alloc] initWithTitle: @"More" image:[UIImage imageNamed: @"more.png"] tag:4];
	morenavController.tabBarItem = moretabBarItem;
	morenavController.navigationBarHidden=YES;
	[moretabBarItem release];
	
	tabBarCtrl=[[UITabBarController alloc]init];
	tabBarCtrl.delegate = self;
	NSArray* controllers = [NSArray arrayWithObjects:homenavController,timernavController,tunesnavController,searchnavController,morenavController,nil];
	tabBarCtrl.viewControllers= controllers;
	DirtyThirtyExerciseArray=[[NSMutableArray alloc]init];
	[window addSubview:tabBarCtrl.view];
	
	
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)willPresentAlertView:(UIAlertView *)alertView {

    alertView.frame = CGRectMake(10.f, 60.f, 285.f, 360.f);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	
        if (buttonIndex == 0)
        {
            
            exit(0);
        }
}

-(void)checkAndCreateDatabase{	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"ExerciseApp.sqlite"];
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	if(success)
	{		
		return;
		// If the database already exists then return without doing anything
		//if(success) return databasePath;
	}
	// If not then proceed to copy the database from the application to the users filesystem
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ExerciseApp.sqlite"];
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	[fileManager release];	
}
-(NSString *) databasePath{
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"ExerciseApp.sqlite"];
	return databasePath;
}

-(void)sendingMail:(NSString*)title gettingBody:(NSString*)BodyMessage; 
{

	NSUserDefaults *standardUserDefault=[NSUserDefaults standardUserDefaults];

	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			mailController = [[MFMailComposeViewController alloc] init];
			mailController.mailComposeDelegate = self;
			
			if([standardUserDefault objectForKey:@"EmailId"])
			{
				NSString *mailstr = [standardUserDefault objectForKey:@"EmailId"];
				NSLog(@"mailstr %@",mailstr);
				NSArray  *mailArray=[NSArray arrayWithObject:mailstr];
				[mailController setToRecipients:mailArray];
			}
			
            NSString *subject = [NSString stringWithFormat:@"%@",title];
			[mailController setSubject:subject];
			
			NSString *emailBody = [NSString stringWithFormat:@"%@",BodyMessage];
			
			[mailController setMessageBody:emailBody isHTML: YES];
			
			[morenavController presentModalViewController:mailController animated:YES];
			[mailController release];
			
		}
		else
        [self launchMailAppOnDevice];
	}
	else
		[self launchMailAppOnDevice];

} 

-(void)startTimersUpdated
{
    if(isDirtyThirty)
    {
        [timerViewController getWorkoutName:@"Dirty-Thirty"];
        [timerViewController getExerciseElements:DirtyThirtyExerciseArray];
       [timerViewController setDirtyThirtyIndex:2];
    }
	else
        
    {
        NSMutableArray *tempArr=[[NSMutableArray alloc]init];
        [tempArr addObjectsFromArray:[self SelectWorkOutData]];
        if ([tempArr count]>0) {
            
            [timerViewController getWorkoutName:[[tempArr objectAtIndex:0] objectForKey:@"Workout_Name"]];
        }
       
       // [DirtyThirtyExerciseArray addObjectsFromArray:[self SelectData]];
        [timerViewController getExerciseElements:DirtyThirtyExerciseArray];
        [timerViewController setDirtyThirtyIndex:1];
        // [timerViewController startTimers];
    }
	
    [timerViewController setIsDoWorkout:YES];
    [timerViewController startWorkout];
    
   // tabBarCtrl.selectedIndex=1;
    //[window addSubview:tabBarCtrl.view];

}


-(void)startTimers
{
	  if(isDirtyThirty)
	   {
		   [timerViewController getWorkoutName:@"Dirty-Thirty"];
		   [timerViewController getExerciseElements:DirtyThirtyExerciseArray];
           [timerViewController setDirtyThirtyIndex:2];
		   //[timerViewController startTimers];
	   }
	else
			  
	   {
		   NSMutableArray *tempArr=[[NSMutableArray alloc]init];
		   [tempArr addObjectsFromArray:[self SelectWorkOutData]];
		   if ([tempArr count]>0) {
			  
			   [timerViewController getWorkoutName:[[tempArr objectAtIndex:0] objectForKey:@"Workout_Name"]];
		   }
		   if([DirtyThirtyExerciseArray count]>0)
		   {
			   [DirtyThirtyExerciseArray removeAllObjects];
		   }
		   [DirtyThirtyExerciseArray addObjectsFromArray:[self SelectData]];
		   [timerViewController getExerciseElements:DirtyThirtyExerciseArray];
		   [timerViewController setDirtyThirtyIndex:1];
		  // [timerViewController startTimers];
	   }
	
    [timerViewController setIsDoWorkout:YES];
    [timerViewController startWorkout];
   
    tabBarCtrl.selectedIndex=1;
    [window addSubview:tabBarCtrl.view];
	}

-(void)BackFromtimer
{
     
    [videoView  ExerciseIdFromTimer:exerciseId :dirtyThirtybuttonIndex :ExerciseName];
    [videoView doPageViewConfiguration];
    //tabBarCtrl.selectedIndex=0;
    //[window addSubview:tabBarCtrl.view];
}


-(NSArray *)SelectWorkOutData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[self databasePath]];
	
	[db open:NULL];
	
	NSString *Query = [NSString stringWithFormat:@"SELECT Workout_Name FROM WorkOut WHERE id=%d",Workout_id];
    NSArray *rows = [db rowsForExpression:Query error:nil];
    [db release];
	return rows;
	
	
}  

-(NSArray *)SelectData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[self databasePath]];
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from Exercise join Workout_Exercise on Exercise.id=Workout_Exercise.Exercise_id where Workout_Exercise.Workout_id=%d",Workout_id];
	NSArray *rows = [db rowsForExpression:Query error:nil];
    [db release];
	return rows;
}


-(void)launchMailAppOnDevice
{
	NSString* emailURLString	= [NSString stringWithFormat:@"mailto:?subject=%@%@&body=%@\n\n%@\n\n", [self getSubjectStr], @"", [self getBodyStr], @""];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[emailURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];	
}

- (NSString*) getSubjectStr
{
	return @"Measurements";
}
//
- (NSString*) getBodyStr
{
	return @"";
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[controller dismissModalViewControllerAnimated: YES];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];	
    [timerViewController release];   
    [homeViewController release]; 
	[tunesViewController release];  
	[searchViewController release]; 
	[moreViewController release];  
	[homenavController release];   
	[timernavController   release];
	[tunesnavController release];   
	[searchnavController   release];
	[morenavController release];     

}


@end
