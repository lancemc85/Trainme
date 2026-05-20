//
//  SaveViewController.h
//  Exercise
//
//  Created by Dev Team on 2/8/11.
//  Copyright 2011 CopperMobile Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SaveViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView *saveTableView;
	NSMutableArray *saveArray;
	NSString *saveString;
	//int count;
	id owner;
	NSMutableArray *savedWorkouts;
    BOOL isDirtythirty;
}
@property (nonatomic, retain)id owner;
@property (nonatomic, readwrite)BOOL isDirtythirty;

-(IBAction)saveMyFaves:(id)sender;
-(IBAction)pushBackBtn:(id)sender;
-(void)saveExercisesAsMYfaves:(NSArray *)NewArr;
-(NSArray *)SelectData;
@end
