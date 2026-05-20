//
//  TunesViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TunesViewController.h"
#import "ExerciseAppDelegate.h"

#ifdef __APPLE__
#include "TargetConditionals.h"
#endif

@interface TunesViewController ()
- (void)handleNowPlayingItemChanged:(id)notification;
- (void)handlePlaybackStateChanged:(id)notification;
- (void)handleExternalVolumeChanged:(id)notification;
@end

@implementation TunesViewController

@synthesize		musicPlayer;
//@synthesize		playPauseButton;
@synthesize		songLabel;
//@synthesize		volumeSlider;



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
   if (!TARGET_IPHONE_SIMULATOR)
    {

    self.musicPlayer =[MPMusicPlayerController iPodMusicPlayer];
    
    // Initial sync of display with music player state
    [self handleNowPlayingItemChanged:nil];
    [self handlePlaybackStateChanged:nil];
	
    // Register for music player notifications
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	//
    [notificationCenter addObserver:self selector:@selector(handleNowPlayingItemChanged:) 
							   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.musicPlayer];
    [notificationCenter addObserver:self selector:@selector(handlePlaybackStateChanged:)  
							   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification  object:self.musicPlayer];
    [notificationCenter addObserver:self selector:@selector(handleExternalVolumeChanged:) 
							   name:MPMusicPlayerControllerVolumeDidChangeNotification         object:self.musicPlayer];
    [self.musicPlayer beginGeneratingPlaybackNotifications];
	
	MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES; // this is the default   
    [self presentModalViewController:mediaPicker animated:YES];
    [mediaPicker release];
        
        
    }
	
}


#pragma mark----------------------Media player notification handlers

// When the now playing item changes, update song info labels and artwork display.

- (void)handleNowPlayingItemChanged:(id)notification 
{
    // Ask the music player for the current song.
    MPMediaItem *currentItem = self.musicPlayer.nowPlayingItem;
    
    // Display the artist, album, and song name for the now-playing media item.
    
    self.songLabel.text   = [currentItem valueForProperty:MPMediaItemPropertyTitle];
	
    
}

#pragma mark----------------------PlayBack State changes----------------------

// When the playback state changes, set the play/pause button appropriately.
- (void)handlePlaybackStateChanged:(id)notification 
{
    MPMusicPlaybackState playbackState = self.musicPlayer.playbackState;
    if (playbackState == MPMusicPlaybackStatePaused || playbackState == MPMusicPlaybackStateStopped) 
	{
     //   [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
    } 
	
	else if (playbackState == MPMusicPlaybackStatePlaying) 
	{
      //  [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

#pragma mark ----------------------Volume controller----------------------
- (void)handleExternalVolumeChanged:(id)notification {
//    // self.volumeSlider is a UISlider used to display music volume.
//    // self.musicPlayer.volume ranges from 0.0 to 1.0.
//  //  [self.volumeSlider setValue:self.musicPlayer.volume animated:YES];
}


#pragma mark ----------------------Button actions----------------------

- (IBAction)playOrPauseMusic:(id)sender 
{
    if (!TARGET_IPHONE_SIMULATOR)
    {
        MPMusicPlaybackState playbackState = self.musicPlayer.playbackState;
        if (playbackState == MPMusicPlaybackStateStopped || playbackState == MPMusicPlaybackStatePaused) {
            [self.musicPlayer play];
        } else if (playbackState == MPMusicPlaybackStatePlaying) {
            [self.musicPlayer pause];
        }
    }
	//[NSThread	detachNewThreadSelector:@selector(startTheBackgroundJob) toTarget:self withObject:nil];
}

#pragma mark ----------------------open Media Picker----------------------
- (IBAction)openMediaPicker:(id)sender 
{
    if (!TARGET_IPHONE_SIMULATOR)
    {
        MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
        mediaPicker.delegate = self;
        mediaPicker.allowsPickingMultipleItems = YES; // this is the default   
        [self presentModalViewController:mediaPicker animated:YES];
        [mediaPicker release];
    }
}




#pragma mark ----------------------MPMediaPickerController delegate methods----------------------

- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    // We need to dismiss the picker
	
	app.tabBarCtrl.selectedIndex=0;
    [self dismissModalViewControllerAnimated:YES];
    
    // Assign the selected item(s) to the music player and start playback.
    [self.musicPlayer stop];
    [self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [self.musicPlayer play];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    // User did not select anything
    // We need to dismiss the picker
	app.tabBarCtrl.selectedIndex=0;
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark ----------------------volume Slider----------------------
- (IBAction)volumeSliderChanged:(id)sender {
  //  self.musicPlayer.volume = self.volumeSlider.value;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!TARGET_IPHONE_SIMULATOR)
    {
        MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
        mediaPicker.delegate = self;
        mediaPicker.allowsPickingMultipleItems = YES; // this is the default   
        [self presentModalViewController:mediaPicker animated:YES];
        [mediaPicker release];
    }
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
