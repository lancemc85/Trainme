//
//  WeightCalculatorViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeightCalculatorViewController : UIViewController 
{
	IBOutlet UITextField *weightCalcCurrentWeightTxt;
	IBOutlet UITextField *weightCalcPreviousWeightTxt;
	IBOutlet UITextField *weightCalcTotalDifferenceTxt;
	IBOutlet UIButton *weightCalcEmailBtn;
	IBOutlet UIButton *weightCalcPushBackBtn;
	NSString *WeightCalData;
	NSString *WeightCalTitle;
    NSString *temp;
    int count;
    BOOL specialCharacterPresent;
}

@property(nonatomic,retain)IBOutlet UITextField *weightCalcCurrentWeightTxt;
@property(nonatomic,retain)IBOutlet UITextField *weightCalcPreviousWeightTxt;
@property(nonatomic,retain)IBOutlet UITextField *weightCalcTotalDifferenceTxt;
@property(nonatomic,retain)IBOutlet UIButton *weightCalcEmailBtn;
@property(nonatomic,retain)IBOutlet UIButton *weightCalcPushBackBtn;
@property(nonatomic,retain)	NSString *WeightCalData;
@property(nonatomic,retain)	NSString *WeightCalTitle;

-(IBAction)pushGoBack:(id)sender;
-(IBAction)EmailBtnPressed:(id)sender;
-(IBAction)facebookBtnPressed:(id)sender;
-(IBAction)twitterBtnPressed:(id)sender;
-(IBAction)saveCurrentWeightdata:(id)sender;
-(IBAction)clearBtn:(id)sender;
-(NSArray *)getCurrentweightData;
-(NSArray *)getPreviousweightData;
-(IBAction)nonNumericValues:(id)sender;
-(void)setViewMovedUp:(BOOL)movedUp;

@end
