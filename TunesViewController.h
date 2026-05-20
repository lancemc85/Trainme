//
//  TunesViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>



@interface TunesViewController : UIViewController<MPMediaPickerControllerDelegate> {
	
	
	MPMusicPlayerController		*musicPlayer;
  //  UISlider					*volumeSlider;
  //  UIButton					*playPauseButton;
    UILabel						*songLabel;
}

//@property	(nonatomic,retain)	IBOutlet	UISlider		*volumeSlider;
//@property	(nonatomic, retain) IBOutlet	UIButton		*playPauseButton;
@property	(nonatomic, retain) IBOutlet	UILabel			*songLabel;

@property	(nonatomic, retain)				MPMusicPlayerController *musicPlayer;


- (IBAction)playOrPauseMusic:(id)sender;
- (IBAction)openMediaPicker:(id)sender;
- (IBAction)volumeSliderChanged:(id)sender;


@end
