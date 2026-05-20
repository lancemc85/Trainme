//
//  InfoExerciseViewController.h
//  Exercise
//
//  Created by Dev Team on 2/4/11.
//  Copyright 2011 CopperMobile Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoExerciseViewController : UIViewController {
	NSString *ExerciseString;
	
	IBOutlet UILabel *label;

}
@property(nonatomic,retain)NSString *ExerciseString;

-(IBAction)ExchangeBtn:(id)sender;
@end
