//
//  MoreViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "MyMeasurementsViewController.h"
#import "WeightCalculatorViewController.h"
#import "BodyFatViewController.h"
#import "BMRViewController.h"
#import "MyFoodLogViewController.h"
#import "LinksViewController.h"
#import "ReportViewController.h"


@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	
	UITableView                       *moreTabTableView;
	NSArray                           *contents;
	SettingsViewController            *settingsViewController;
	MyMeasurementsViewController      *myMeasurementsViewController;
	WeightCalculatorViewController    *weightCalculatorViewController;
	BodyFatViewController             *bodyFatViewController;
	BMRViewController                 *bMRViewController;
	MyFoodLogViewController           *myFoodLogViewController;
	LinksViewController               *linksViewController;
	ReportViewController              *reportViewController;
}

@property(nonatomic,retain)IBOutlet 	UITableView *moreTabTableView;
@property(nonatomic,retain)	SettingsViewController            *settingsViewController;
@property(nonatomic,retain)	MyMeasurementsViewController      *myMeasurementsViewController;
@property(nonatomic,retain)	WeightCalculatorViewController    *weightCalculatorViewController;
@property(nonatomic,retain)	BodyFatViewController             *bodyFatViewController;
@property(nonatomic,retain)	BMRViewController                 *bMRViewController;
@property(nonatomic,retain)	MyFoodLogViewController           *myFoodLogViewController;
@property(nonatomic,retain)	LinksViewController               *linksViewController;
@property(nonatomic,retain)	ReportViewController              *reportViewController;

@end
