//
//  AboutPredefinedViewController.h
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PredesignedWorkoutsViewController.h"
#import "videoViewController.h"
#import "TimerViewController.h"

@interface PredefinedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	
	UITableView *predefinedTrainerTableView;
	UITableView *predefinedMyFavesTableView;
    NSMutableArray *MytrainerContents;
	NSMutableArray *MyfavesContents;
	NSMutableArray *trainerArray;
	PredesignedWorkoutsViewController  *predesignedWorkoutsViewController;
    videoViewController *videoView;
	NSInteger indexnumber;
	NSString *saveRtnString;
    int Buttonindex;
}

@property(nonatomic,retain)IBOutlet	UITableView *predefinedTrainerTableView;
@property(nonatomic,retain)IBOutlet	UITableView *predefinedMyFavesTableView;
@property(nonatomic,retain)	PredesignedWorkoutsViewController  *predesignedWorkoutsViewController;
@property(nonatomic,retain)   videoViewController *videoView;
@property(nonatomic,retain)	NSMutableArray *MytrainerContents;
@property(nonatomic,retain) NSString *saveRtnString;
@property(readwrite)NSInteger indexnumber;
@property(readwrite)int Buttonindex;
-(IBAction)pushBackBtn:(id)sender;
-(NSArray *)SelectTrainerData;
-(NSArray *)SelectMyData;

@end

extern PredefinedViewController *predefinedextern;

