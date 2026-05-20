//
//  BodyFatViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BodyFatViewController : UIViewController <UITextFieldDelegate>
{
	IBOutlet UITextField *bodyFatWeightTxt;
	IBOutlet UITextField *bodyFatWristTxt;
	IBOutlet UITextField *bodyFatWaistTxt;
	IBOutlet UITextField *bodyFatHipsTxt;
	IBOutlet UITextField *bodyFatforearmTxt;
    IBOutlet UILabel   *bodyFatWristlbl;
    IBOutlet UILabel    *bodyFatHipslbl;
    IBOutlet UILabel    *bodyFatforearmlbl;
	IBOutlet UILabel *bodyFatCurrentBFlbl;
	IBOutlet UILabel *bodyFatPreviousBFlbl;
	IBOutlet UILabel *bodyFatDifferenceBFlbl;
	IBOutlet UIButton *bodyFatEmailBtn;
	IBOutlet UIButton *bodyFatPushBackBtn;
	UIImageView  *genderImage;
	UIButton     *malebtn;
	UIButton     *femalebtn;
	NSString *BodyFatData;
	NSString *BodyFatTitle;
    NSString *wriststr;
    NSString *hipsstr;
    NSString *forearmstr;
	BOOL isMale;
	float bodyfat;
	int count;
    BOOL specialCharacterPresent;
    IBOutlet UILabel *MFlbl;
	
}

@property(nonatomic,retain)IBOutlet UIImageView  *genderImage;
@property(nonatomic,retain)IBOutlet	UIButton     *malebtn;
@property(nonatomic,retain)IBOutlet	UIButton     *femalebtn;
@property(nonatomic,retain)IBOutlet UITextField *bodyFatWeightTxt;
@property(nonatomic,retain)IBOutlet UITextField *bodyFatWristTxt;
@property(nonatomic,retain)IBOutlet UITextField *bodyFatWaistTxt;
@property(nonatomic,retain)IBOutlet UITextField *bodyFatHipsTxt;
@property(nonatomic,retain)IBOutlet UITextField *bodyFatforearmTxt;
@property(nonatomic,retain)IBOutlet UILabel *bodyFatCurrentBFlbl;
@property(nonatomic,retain)IBOutlet UILabel *bodyFatPreviousBFlbl;
@property(nonatomic,retain)IBOutlet UILabel *bodyFatDifferenceBFlbl;
@property(nonatomic,retain)IBOutlet UIButton *bodyFatEmailBtn;
@property(nonatomic,retain)IBOutlet UIButton *bodyFatPushBackBtn;
@property(nonatomic,retain)	NSString *BodyFatData;
@property(nonatomic,retain)	NSString *BodyFatTitle;


-(IBAction)pushGoBack:(id)sender;
-(IBAction)EmailBtnPressed:(id)sender;
-(IBAction)malebtnPressed:(id)sender;
-(IBAction)femalebtnPressed:(id)sender;
//-(IBAction)heighttxtfldEdited;
//-(IBAction)WaisttxtfldEdited;
//-(IBAction)HipstxtfldEdited;
-(IBAction)clearBtn:(id)sender;
//-(IBAction)NecktxtfldEdited;
-(IBAction)saveCurrentWeightdata:(id)sender;
-(NSArray *)getCurrentBodyFatData;
-(void)calculateTotalDifference;
-(NSArray *)getPreviousBodyFatData;;
- (void)setViewMovedUp:(BOOL)movedUp;
-(void)valuesOfAllParameters;
-(void)configuration;
-(IBAction)facebookBtnPressed:(id)sender;
-(IBAction)twitterBtnPressed:(id)sender;
-(IBAction)nonNumericValues:(id)sender;
@end
