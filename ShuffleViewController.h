//
//  ShuffleViewController.h
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoViewController.h"
@class SwapViewController,SaveViewController,TimerViewController;
@interface ShuffleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	
	UITableView         *shuffleTable;
	
	NSMutableArray        *shuffleArray;
	SwapViewController      *swap;
	
	BOOL                     isSwap;
     SaveViewController       *save;
	TimerViewController      *timer;
	NSIndexPath              *path;
	NSIndexPath           *selectedPath;
    NSMutableArray            *BodypartArr;
    videoViewController *videoController;
}
@property(nonatomic,readwrite)	BOOL isSwap;
@property(nonatomic,retain)NSString *ExchangeString;
@property(nonatomic,retain)IBOutlet 	UITableView *shuffleTable;
@property (nonatomic, retain)id owner;
@property(nonatomic,retain)	videoViewController *videoController;
-(IBAction)pushBackBtn:(id)sender;
-(IBAction)doWorkoutBtnPressed:(id)sender;
-(IBAction)AddMyFaves:(id)sender;
-(void)referenceTime:(id)sender;
-(void)loadData;
-(NSArray *)SelectData;
-(NSString *)getRandomExerciseQuery;

@end

extern ShuffleViewController *externshuffle;
