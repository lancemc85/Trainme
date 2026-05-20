//
//  BMRViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMRViewController : UIViewController<UITextFieldDelegate> 
{
	IBOutlet UITextField *bmrViewWeightTxt;
	IBOutlet UITextField *bmrViewHeightTxt;
	IBOutlet UITextField *bmrViewAgeTxt;
	IBOutlet UITextField *bmrViewCurrentBMRTxt;
	IBOutlet UITextField *bmrViewPreviousBMRTxt;
	IBOutlet UITextField *bmrViewDifferenceBMRTxt;
	IBOutlet UISwitch *bmrViewGenderSwch;
	IBOutlet UIButton *bmrViewEmailBtn;
	IBOutlet UIButton *bmrViewPushBackBtn;
	IBOutlet UIButton *bmrViewPushNextBtn;
	UIImageView *genderImage;
	BOOL isMale;
	NSString *BMRTitle;
	NSString *BMRData;
    int count;
    BOOL specialCharacterPresent;


}

@property(nonatomic,retain)IBOutlet UITextField *bmrViewWeightTxt;
@property(nonatomic,retain)IBOutlet UITextField *bmrViewHeightTxt;
@property(nonatomic,retain)IBOutlet UITextField *bmrViewAgeTxt;
@property(nonatomic,retain)IBOutlet UITextField *bmrViewCurrentBMRTxt;
@property(nonatomic,retain)IBOutlet UITextField *bmrViewPreviousBMRTxt;
@property(nonatomic,retain)IBOutlet UITextField *bmrViewDifferenceBMRTxt;
@property(nonatomic,retain)IBOutlet UISwitch *bmrViewGenderSwch;
@property(nonatomic,retain)IBOutlet UIButton *bmrViewEmailBtn;
@property(nonatomic,retain)IBOutlet UIButton *bmrViewPushBackBtn;
@property(nonatomic,retain)IBOutlet UIButton *bmrViewPushNextBtn;
@property(nonatomic,retain)IBOutlet UIImageView *genderImage;

-(IBAction)pushGoBack:(id)sender;
-(IBAction)malebtnPressed:(id)sender;
-(IBAction)femalebtnPressed:(id)sender;
-(IBAction)saveCurrentBMRdata:(id)sender;
-(IBAction)changeValue:(id)sender;
-(IBAction)clearBtn:(id)sender;
-(void)valueForAllParameters;
-(void)calculateTotalDifference;
-(NSArray *)getCurrentBMRData;
-(NSArray *)getPreviousBMRData;
-(IBAction)EmailBtnPressed:(id)sender;
-(IBAction)facebookBtnPressed:(id)sender;
-(IBAction)twitterBtnPressed:(id)sender;
-(IBAction)genderSwitch:(id)sender;


@end
