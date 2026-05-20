//
//  SettingsViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController<UITextFieldDelegate> 
{
	IBOutlet UIButton *settingsLoseWeightOptionBtn;
	IBOutlet UIButton *settingsToneMuscleOptionBtn;
	IBOutlet UIButton *settingsGainMuscleOptionBtn;
	IBOutlet UITextField *settingsEmailAddressTxt;
	IBOutlet UIButton *settingsSaveBtn;
	IBOutlet UIButton *settingsPushGoBackBtn;
    
    IBOutlet UILabel  *repetionLabel;
    
    BOOL specialCharacterPresent;
	NSString *repetionText;
	NSString *purpose;
	NSString *emailid;
    
    BOOL      viewIsAlreadyUp;
}

@property(nonatomic,retain)IBOutlet UIButton *settingsLoseWeightOptionBtn;
@property(nonatomic,retain)IBOutlet UIButton *settingsToneMuscleOptionBtn;
@property(nonatomic,retain)IBOutlet UIButton *settingsGainMuscleOptionBtn;
@property(nonatomic,retain)IBOutlet UITextField *settingsEmailAddressTxt;
@property(nonatomic,retain)IBOutlet UIButton *settingsSaveBtn;
@property(nonatomic,retain)IBOutlet UIButton *settingsPushGoBackBtn;

-(IBAction)pushGoBack:(id)sender;
-(IBAction)loseWeightBtnPressed:(id)sender;
-(IBAction)ToneMuscleBtnPressed:(id)sender;
-(IBAction)GainMuscleBtnPressed:(id)sender;
-(IBAction)savebtnInSettings:(id)sender;
-(IBAction)clearBtn:(id)sender;
//-(void)checkingNumberData:(UITextField *)inputText;


@end
