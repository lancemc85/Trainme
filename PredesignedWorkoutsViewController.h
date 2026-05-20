//
//  WorkoutsViewController.h
//  Exercise
//
//  Created by raidu on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutViewController.h"



@interface PredesignedWorkoutsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	
	UITableView *exercisestableView;
	WorkoutViewController *workoutViewController;
	NSInteger Workout_id;
	NSString *Workoutname;
	NSMutableArray *ExercisesName;
    IBOutlet UIButton *doWorkout;
}

@property(nonatomic,retain)IBOutlet	UITableView *exercisestableView;
@property(nonatomic,retain)  IBOutlet UIButton *doWorkout;
@property(nonatomic,retain)	WorkoutViewController *workoutViewController;
@property(nonatomic,retain)NSString *Workoutname;
@property(nonatomic,readwrite)NSInteger Workout_id;;
-(NSArray *)SelectData;
-(IBAction)pushBackBtn:(id)sender;
-(IBAction)pushDoWorkoutBtn:(id)sender;
-(IBAction)plusBtn:(id)sender;


@end
extern PredesignedWorkoutsViewController  *predesignedWorkout;