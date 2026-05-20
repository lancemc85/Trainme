//
//  TimerViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoViewController.h"

@interface TimerViewController : UIViewController<UIAlertViewDelegate> {
	
	UISlider *WorkoutSlider;
	UISlider *ExerciseSlider;
	NSTimer *WorkoutTimer;
	NSTimer *ExerciseTimer;
	NSTimer *minutesTimer;
	NSTimer *SecondsTimer;	
	UILabel *workoutlbl;
	UILabel *exerciselbl;
	UILabel *minuteslbl;
	UILabel *secondslbl;
	UIButton *startBtn;
	UIButton *stopBtn;
    NSInteger workoutCount;
	NSInteger exerciseCount;
	NSInteger minutes,seconds,timeForExercise;
	BOOL isDoWorkout;
   NSInteger DirtyThirtyIndex;
	NSString *workoutName;
	NSMutableArray *ExercicesArray;
    NSMutableArray  *cardioExercises;
	NSArray *tempExerciseArr;
	int currenIndex;
	int ElapsedTime;
	int TotalTime;
	int exercisemaxtime;
    int CardioExerciseTime;
	UIImageView *middleseparaterlineimgvw;
	UIImageView *middleseparatorlineimgvw;

	UILabel *WrkoutmaxtimeIndicator;
	UILabel *WorkoutmediumtimeIndicator;
	UILabel *ExercisemaxtimeIndicator;
	UILabel *ExercisemediumtimeIndicator;
   videoViewController *videoView;	
    id owner;
    
    //---ADDED BY PARAS---//
    
    BOOL                    alreadyTimeTabShown;
    
}


@property(nonatomic,retain)IBOutlet 	UISlider *WorkoutSlider;
@property(nonatomic,retain)IBOutlet 	UISlider *ExerciseSlider;
@property (nonatomic, retain)id owner;

@property(nonatomic,retain)IBOutlet  	UILabel *workoutlbl;
@property(nonatomic,retain)IBOutlet 	UILabel *exerciselbl;
@property(nonatomic,retain)IBOutlet 	UILabel *minuteslbl;
@property(nonatomic,retain)IBOutlet 	UILabel *secondslbl;
@property(nonatomic,retain)IBOutlet	    UIButton *startBtn;
@property(nonatomic,retain)IBOutlet	    UIButton *stopBtn;
@property(nonatomic,retain)IBOutlet		UILabel *WrkoutmaxtimeIndicator;
@property(nonatomic,retain)IBOutlet		UILabel *WorkoutmediumtimeIndicator;
@property(nonatomic,retain)IBOutlet		UILabel *ExercisemaxtimeIndicator;
@property(nonatomic,retain)IBOutlet		UILabel *ExercisemediumtimeIndicator;
@property(nonatomic,retain)IBOutlet	    UIImageView *middleseparaterlineimgvw;
@property(nonatomic,retain)IBOutlet	    UIImageView *middleseparatorlineimgvw;
@property(nonatomic,retain)             NSMutableArray *ExercicesArray;
@property(nonatomic,retain) videoViewController *videoView;

@property(nonatomic,retain)NSTimer *SecondsTimer;
@property(nonatomic,readwrite) BOOL	    isDoWorkout;
@property(nonatomic,readwrite) NSInteger DirtyThirtyIndex;
@property(nonatomic,readonly) int currentIndex;
@property(nonatomic,readonly) int ElapsedTime;
@property(nonatomic,readonly)NSInteger minutes;
@property(nonatomic)NSInteger seconds;
@property(nonatomic)NSInteger exerciseCount;
@property(nonatomic)int currenIndex;
@property(nonatomic)int CardioExerciseTime;




-(IBAction)pushStartBtn:(id)sender;
-(IBAction)pushStopBtn:(id)sender;
-(void)secondstime;
-(void)startTimers;
-(void)getWorkoutName:(NSString *)workout;
-(void)getExerciseElements:(NSArray *)ExerciseArr;
-(NSString *)checktimeForAllExercies;
-(void)updateSeconds;
-(void)updateMinutes;
-(void)startWorkout;
-(void)stopTheTimer;
-(void)TimerConfiguration;


//---ADDED by PARAS--//

-(void)updateTimerText:(float)updateValue:(int)index;
-(void)checkingStatusOfExerciseAndTime:(int)index;
@end

extern TimerViewController *timerextern;
