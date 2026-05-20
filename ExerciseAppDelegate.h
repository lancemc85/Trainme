//
//  ExerciseAppDelegate.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "TimerViewController.h"
#import "TunesViewController.h"
#import "SearchViewController.h"
#import "MoreViewController.h"
#import <MessageUI/MessageUI.h>
#import "videoViewController.h"
 #import <sqlite3.h>
#define APPDELEGATE (ExerciseAppDelegate *)[[UIApplication sharedApplication] delegate]
@interface ExerciseAppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate> {
    UIWindow *window;
	HomeViewController   *homeViewController;
	TimerViewController  *timerViewController;
	TunesViewController  *tunesViewController;
	SearchViewController *searchViewController;
	MoreViewController   *moreViewController;
	videoViewController *videoView;
	UITabBarController *tabBarCtrl;
	
	UINavigationController *homenavController;
	UINavigationController *timernavController;
	UINavigationController *tunesnavController;
	UINavigationController *searchnavController;
	UINavigationController *morenavController;
	
	MFMailComposeViewController *mailController;
	int                count;
	NSString *workoutName;
	NSInteger Workout_id;
	NSMutableArray *DirtyThirtyExerciseArray;
	BOOL isDirtyThirty;
    NSInteger exerciseId;
    NSInteger currentIndex;
    NSInteger  dirtyThirtybuttonIndex;
    NSString *ExerciseName;
	//NSTimer *WorkoutTimer;
	//NSTimer *ExerciseTimer;
	//NSTimer *SecondsTimer;
	//NSInteger workoutCount;
	//NSInteger exerciseCount;
	//NSString *mintimerValue;
	//int minutes,seconds;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain)  	HomeViewController   *homeViewController;
@property (nonatomic, retain)  	TimerViewController  *timerViewController;
@property (nonatomic, retain)	TunesViewController  *tunesViewController;
@property (nonatomic, retain)  	SearchViewController *searchViewController;
@property (nonatomic, retain)  	MoreViewController   *moreViewController;
@property (nonatomic, retain) 	UINavigationController *homenavController;
@property (nonatomic, retain) 	UINavigationController *timernavController;
@property (nonatomic, retain) 	UINavigationController *tunesnavController;
@property (nonatomic, retain) 	UINavigationController *searchnavController;
@property (nonatomic, retain) 	UINavigationController *morenavController;
@property (nonatomic, retain)  	MFMailComposeViewController *mailController;
@property (nonatomic, retain)	UITabBarController *tabBarCtrl;
@property (nonatomic, readwrite)  int  count;
@property(nonatomic,retain)  		NSString *workoutName;
@property(nonatomic,retain)  		NSString   *ExerciseName;
@property(nonatomic,retain)NSMutableArray *DirtyThirtyExerciseArray;
 @property(nonatomic,readwrite)    NSInteger Workout_id; 
@property(nonatomic,readwrite)    NSInteger exerciseId; 
@property(nonatomic,readwrite)      NSInteger  dirtyThirtybuttonIndex;
@property(nonatomic,readwrite)BOOL isDirtyThirty;
-(void)sendingMail:(NSString*)title gettingBody:(NSString*)BodyMessage; 
-(void)checkAndCreateDatabase;
-(NSString *) databasePath;
-(NSArray *)SelectData;
-(NSArray *)SelectWorkOutData;
-(void)startTimers;
-(void)BackFromtimer;
-(void)launchMailAppOnDevice;
- (NSString*) getBodyStr;
- (NSString*) getSubjectStr;

//--Added by Paras---//

-(void)startTimersUpdated;

@end

extern ExerciseAppDelegate *app;

