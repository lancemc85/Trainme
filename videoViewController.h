//
//  videoViewController.h
//  Exercise
//
//  Created by Dev Team on 2/4/11.
//  Copyright 2011 CopperMobile Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	<MediaPlayer/MediaPlayer.h>
#import "pagesViewController.h"



@class InfoExerciseViewController;
@interface videoViewController : UIViewController<UIScrollViewDelegate> {
    
	NSString *swapString;
	NSString *ExString;
	id owner;
	IBOutlet UILabel *label;
	IBOutlet UIButton *imageBtn;
    IBOutlet UIButton *playVideoBtn;
    IBOutlet UIButton *DOWorkOutBtn;
    IBOutlet UIButton *NextBtn;
     IBOutlet UIButton *plusButton;
	InfoExerciseViewController *info;
	MPMoviePlayerController * player;
	NSIndexPath *path;
	NSInteger exerciseId;
	UITextView *exerciseInfotxtvw;
	NSMutableArray *exerciseArray;
	NSMutableArray *exerciseVideoArray;
    NSMutableString *txtvwstr;
	NSString *imageNamestr;
	NSString *videoNamestr;

	NSMutableArray *viewControllers;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
	BOOL pageControlUsed;
	pagesViewController *pagesviewcontroller;
    
	NSMutableArray *exercisephotoArray;
	unsigned i;
    float xCd;
    float yCd ;
	int Buttonindex;
    NSMutableArray        *shuffleArray;
    BOOL isdirtyThirty;
    NSInteger ExerciseIndex;
    //BOOL isHomeScreen;
    NSInteger  Workout_id;
    float otherExerciseTime;
    
    IBOutlet UIButton *cardiotime;
    IBOutlet UIButton *reps;
    int CardioTime; 
  //  BOOL isPlay;
    int count;
  NSTimer *SecondsTimer;	
}

-(IBAction)changeToNextExercise;
//-(IBAction)EerciseBtn:(id)sender;
-(IBAction)pushBackBtn:(id)sender;

-(IBAction)plusBtn:(id)sender;

-(IBAction)pushPlayVideoBtn:(id)sender;
-(IBAction)infoBtnClick:(id)sender;
-(NSArray *)getDataForQuery:(NSString *)Query;
-(NSArray *)getPicsVideoForQuery:(NSString *)Query;
-(NSArray *)getPicsForQuery:(NSString *)Query;
-(NSString *)getExerciseFromSelectedWorkout;

-(void)hidescrollview;
-(void)doPageViewConfiguration;
-(void)ExerciseIdFromTimer:(NSInteger)ExerciseId:(NSInteger)ButtonIndex:(NSString *)Exercisename;
-(IBAction)changePage:(id)sender;
-(IBAction)doWorkoutBtnPressed:(id)sender;

@property(nonatomic,readwrite)NSInteger exerciseId;
@property(nonatomic,retain)   NSIndexPath *path;
@property(nonatomic,retain)IBOutlet UIButton *DOWorkOutBtn;
@property(nonatomic,retain)   NSMutableString *txtvwstr;
@property(nonatomic,retain)	  NSString *imageNamestr;
@property(nonatomic,retain)	  NSString *videoNamestr;
@property(nonatomic,retain)IBOutlet	UITextView *exerciseInfotxtvw;
@property (nonatomic, retain)id owner;
@property(nonatomic,retain)NSString *swapString;
@property(nonatomic,retain)NSString *ExString;
@property(nonatomic,retain)	MPMoviePlayerController * player;
@property(nonatomic,readwrite)BOOL isdirtyThirty;
//@property(nonatomic,readwrite)BOOL isHomeScreen;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) NSMutableArray *viewControllers;
@property(nonatomic,retain) UIPageControl *pageControl;
@property(nonatomic,retain)	pagesViewController *pagesviewcontroller;
@property(nonatomic,readwrite)  float xCd;
@property(nonatomic,readwrite)  float yCd;
@property(nonatomic,readwrite)  int Buttonindex;
@property(nonatomic,readwrite)   NSInteger ExerciseIndex;
@property(nonatomic,readwrite)NSInteger Workout_id;
@property(nonatomic,readwrite)int CardioTime;   
//------ADDED BY PARAS 28 Aprail----//
-(void)checkUserTextAlertStatus;
-(void)updateTimer:(int)index;

-(void)calculatingOtherExerciseTime;
-(NSString *)getRandomExerciseQuery;
-(void)setCardioTime;
-(void)startTimer;
-(void)stopTimer;
@end
