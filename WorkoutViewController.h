//
//  WorkoutViewController.h
//  Exercise
//
//  Created by raidu on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoViewController.h"
@class SwapViewController,SaveViewController;
@interface WorkoutViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	
	UITableView             *workoutTableView;
	NSMutableArray          *workoutsArray;
	NSMutableDictionary    *workoutsdict;
	SwapViewController     *swap;
	NSString                *ExchangeString;
	NSIndexPath             *path;
	NSIndexPath              *selectedPath;
    SaveViewController       *save;
	IBOutlet UIButton        *addButton;
	BOOL isSwap;
    NSMutableArray            *BodypartArr;
     videoViewController   *videoController;
    NSMutableArray                *dirtyThiryExcerciseArray;
    NSMutableArray*   dirtyThiryContent;
    BOOL                isDirtyBtnClicked;
    BOOL                isCalledFromDirty;
    NSInteger Workout_id;
}

@property(nonatomic,retain)IBOutlet 	UITableView *workoutTableView;
@property(nonatomic,readwrite)	BOOL isSwap;
@property(nonatomic,readwrite) BOOL                isCalledFromDirty;
@property(nonatomic,retain)NSString *ExchangeString;
@property(nonatomic,retain)NSMutableDictionary *workoutsdict;
@property(nonatomic,retain)	videoViewController *videoController;
-(IBAction)pushBackBtn:(id)sender;
-(IBAction)AddMyFaves:(id)sender;
-(NSArray *)SelectData;
- (void)workoutViewFlag :(BOOL)isFlag;
-(void)DirtyThirtyExerciseAray:(NSMutableArray *)array;
-(void)loadData;
@property(nonatomic,readwrite)NSInteger Workout_id;
-(void)swapExerciseWithData:(NSDictionary *)newData;


@end

extern WorkoutViewController *externworkout;