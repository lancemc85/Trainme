//
//  MyFoodLogViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyFoodLogViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate> 
{
	IBOutlet UITextField *myFoodLogTotaltxtfld;
	IBOutlet UITextField *myFoodLogProteinTxt;
	IBOutlet UITextField *myFoodLogCarbohydratesTxt;
	IBOutlet UITextField *myFoodLogSugarTxt;
    IBOutlet UITextField *myFoodLogFatTxt;
	IBOutlet UIButton *myFoodLogClearBtn;
	IBOutlet UITextView *myFoodLogNotesTxtView;
	IBOutlet UIButton *myFoodLogEmailBtn;
	IBOutlet UIButton *myFoodLogPushBackBtn;
	NSString *MyFoodData;
	NSString *MyFoodTitle;
    int count;
    BOOL specialCharacterPresent;
}

@property(nonatomic,retain)IBOutlet UITextField *myFoodLogTotaltxtfld;
@property(nonatomic,retain)IBOutlet UITextField *myFoodLogProteinTxt;
@property(nonatomic,retain)IBOutlet UITextField *myFoodLogCarbohydratesTxt;
@property(nonatomic,retain)IBOutlet UITextField *myFoodLogSugarTxt;
@property(nonatomic,retain)IBOutlet UITextField *myFoodLogFatTxt;
@property(nonatomic,retain)IBOutlet UIButton *myFoodLogClearBtn;
@property(nonatomic,retain)IBOutlet UITextView *myFoodLogNotesTxtView;
@property(nonatomic,retain)IBOutlet UIButton *myFoodLogEmailBtn;
@property(nonatomic,retain)IBOutlet UIButton *myFoodLogPushBackBtn;
@property(nonatomic,retain)	NSString *MyFoodData;
@property(nonatomic,retain)	NSString *MyFoodTitle;

-(NSArray *)getFoodLogData;
-(IBAction)saveMyFoodLogdata:(id)sender;
-(IBAction)pushGoBack:(id)sender;
-(IBAction)pushClearBtn:(id)sender;
-(IBAction)pushEmailBtn:(id)sender;
-(IBAction)facebookBtnPressed:(id)sender;
-(IBAction)twitterBtnPressed:(id)sender;
-(void)setViewMovedUp:(BOOL)movedUp;
-(IBAction)changeValue:(id)sender;

@end
