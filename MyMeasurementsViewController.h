//
//  MyMeasurementsViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyMeasurementsViewController : UIViewController<UITextFieldDelegate> 
{

	IBOutlet UITextField *measureNeckTxt;
	IBOutlet UITextField *measureShouldersTxt;
	IBOutlet UITextField *measureChestTxt;
	IBOutlet UITextField *measureCoreTxt;
	IBOutlet UITextField *measureHipsTxt;
	IBOutlet UITextField *measureThighTxt;
	IBOutlet UITextField *measureCalfTxt;
	IBOutlet UITextField *measureArmTxt;
	IBOutlet UIButton *measureEmailBtn;
	IBOutlet UIButton *measurePushBackBtn;
	
	NSString *MeasurementData;
	NSString *MeasurementTitle;
	NSString *neckstr;
	NSString *shouldersstr;
	NSString *cheststr;
	NSString *corestr;
	NSString *hipsstr;
	NSString *thighstr;
	NSString *calfstr;
	NSString *armsstr;
    int count;
     BOOL specialCharacterPresent;
   // NSString *inputString;
}


@property(nonatomic,retain)IBOutlet UITextField *measureNeckTxt;
@property(nonatomic,retain)IBOutlet UITextField *measureShouldersTxt;
@property(nonatomic,retain)IBOutlet UITextField *measureChestTxt;
@property(nonatomic,retain)IBOutlet UITextField *measureCoreTxt;
@property(nonatomic,retain)IBOutlet UITextField *measureHipsTxt;
@property(nonatomic,retain)IBOutlet UITextField *measureThighTxt;
@property(nonatomic,retain)IBOutlet UITextField *measureCalfTxt;
@property(nonatomic,retain)IBOutlet UITextField *measureArmTxt;
@property(nonatomic,retain)IBOutlet UIButton *measureEmailBtn;
@property(nonatomic,retain)IBOutlet UIButton *measurePushBackBtn;
@property(nonatomic,retain)IBOutlet	NSString *MeasurementData;
@property(nonatomic,retain)IBOutlet	NSString *MeasurementTitle;

-(IBAction)saveMeasurementdata:(id)sender;
-(IBAction)clearBtn:(id)sender;
-(IBAction)pushGoBack:(id)sender;
-(IBAction)pushEmailBtn:(id)sender;
-(NSArray *)getMeasurementData;
-(void)setViewMovedUp:(BOOL)movedUp;
-(IBAction)facebookComment:(id)sender;
-(IBAction)twitterTweet:(id)sender;
-(IBAction)nonNumericValues:(id)sender;



@end
