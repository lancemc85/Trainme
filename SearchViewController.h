//
//  SearchViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoViewController.h"
#import "pagesViewController.h"

@interface SearchViewController : UIViewController<UIPickerViewDelegate> {
	
	UIImageView *bodyImage;
	UIImageView *backbodyImage;
	UILabel *labelofBodyPart;
	UITextView *BodyPartInfotxtview;

	NSArray     *frontBodyImagesArray;
	NSArray     *backBodyImagesArray;
	UIButton    *viewExercisesBtn;
	UIView  *frontView;
	UIView  *backView;
	
	NSMutableArray *pickerExerciseArray;
	NSMutableArray   *BodyPartsArray;
	UIView *pickerOnView;
	UIPickerView *picker;
	int selectedrow;
	NSString      *bodyPartName;
	NSInteger    exerciseid;
	NSInteger     bodyPartId;
	pagesViewController *pagesviewcontroller;
    NSString *pickerText;
}

@property(nonatomic,retain)IBOutlet 	UIImageView *bodyImage;
@property(nonatomic,retain)IBOutlet 	UIImageView *backbodyImage;
@property(nonatomic,retain)IBOutlet	    UIButton    *viewExercisesBtn;
@property(nonatomic,retain)IBOutlet	    UILabel *labelofBodyPart;
@property(nonatomic,retain)IBOutlet	    UITextView *BodyPartInfotxtview;
@property(nonatomic,retain)IBOutlet 	UIView *pickerOnView;
@property(nonatomic,retain)IBOutlet 	UIPickerView *picker;
@property(nonatomic,retain)	            NSArray     *backBodyImagesArray;
@property(nonatomic,retain)IBOutlet 	UIView  *frontView;
@property(nonatomic,retain)IBOutlet 	UIView  *backView;
@property(nonatomic,retain)IBOutlet     NSString *pickerText;

@property(nonatomic,retain)		pagesViewController *pagesviewcontroller;
@property(nonatomic,readwrite)	NSInteger    exerciseid;



-(IBAction)chestBtnPressed:(id)sender;
-(IBAction)AbbsBtnPressed:(id)sender;
-(IBAction)shouldersBtnPressed:(id)sender;
-(IBAction)bicepsBtnPressed:(id)sender;
-(IBAction)tightsBtnPressed:(id)sender;
-(IBAction)frontbodyBtnPressed:(id)sender;
-(IBAction)backbodyBtnPressed:(id)sender;
-(IBAction)viewExercisesBtnPressed:(id)sender;
-(IBAction)buttocksBtnPressed:(id)sender;
-(IBAction)backCalfsBtnPressed:(id)sender;
-(IBAction)back2backBtnPressed:(id)sender;
-(IBAction)hamstringBtnPressed:(id)sender;
-(IBAction)backTricepsBtnPressed:(id)sender;
-(IBAction)backShouldersBtnPressed:(id)sender;
-(IBAction)pickerDoneButtonClicked;
-(IBAction)viewExampleBtnpressed:(id)sender;
-(void)hidePicker;
-(void)showPicker;
-(void)selectedBodyParts;
-(NSArray *)selectExerciseData;
@end

extern SearchViewController *externSearch;