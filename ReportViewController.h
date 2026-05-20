//
//  ReportViewController.h
//  Exercise
//
//  Created by Dev Team on 3/7/11.
//  Copyright 2011 CopperMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReportViewController : UIViewController
{
	UILabel *necklbl;
	UILabel *shoulderslbl;
	UILabel *chestlbl;
	UILabel *corelbl;
	UILabel *hipslbl;
	UILabel *thighlbl;
	UILabel *calflbl;
	UILabel *armlbl;
	UILabel *bodyweightlbl;
	UILabel *bodyfatlbl;
	UILabel *BMRlbl;
	
	NSMutableArray *Query1Arr;
	NSMutableArray *Query2Arr;
	NSMutableArray *Query3Arr;

}

@property(nonatomic,retain)IBOutlet 	UILabel *necklbl;
@property(nonatomic,retain)IBOutlet 	UILabel *shoulderslbl;
@property(nonatomic,retain)IBOutlet 	UILabel *chestlbl;
@property(nonatomic,retain)IBOutlet 	UILabel *corelbl;
@property(nonatomic,retain)IBOutlet 	UILabel *hipslbl;
@property(nonatomic,retain)IBOutlet 	UILabel *thighlbl;
@property(nonatomic,retain)IBOutlet 	UILabel *calflbl;
@property(nonatomic,retain)IBOutlet 	UILabel *armlbl;
@property(nonatomic,retain)IBOutlet 	UILabel *bodyweightlbl;
@property(nonatomic,retain)IBOutlet 	UILabel *bodyfatlbl;
@property(nonatomic,retain)IBOutlet 	UILabel *BMRlbl;
@property(nonatomic,retain) 	NSMutableArray *Query1Arr;
@property(nonatomic,retain)	    NSMutableArray *Query2Arr;
@property(nonatomic,retain)	    NSMutableArray *Query3Arr;


-(NSArray *)getMeasurementData;
-(IBAction)pushBackbutton:(id)sender;
-(NSArray *)getBMRData;
-(NSArray *)getBodyFatData;
-(NSArray *)getBodyWeightData;



@end
