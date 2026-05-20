//
//  TimerViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerViewController.h"
#import "videoViewController.h"
#import "ExerciseAppDelegate.h"

TimerViewController *timerextern=nil;

@implementation TimerViewController

@synthesize WorkoutSlider;
@synthesize ExerciseSlider;
@synthesize workoutlbl;
@synthesize exerciselbl;
@synthesize minuteslbl;
@synthesize secondslbl;
@synthesize startBtn;
@synthesize stopBtn,SecondsTimer;
@synthesize  isDoWorkout;
@synthesize ElapsedTime,currentIndex,seconds,minutes;
@synthesize WrkoutmaxtimeIndicator;
@synthesize WorkoutmediumtimeIndicator;
@synthesize ExercisemaxtimeIndicator;
@synthesize ExercisemediumtimeIndicator;
@synthesize middleseparaterlineimgvw;
@synthesize middleseparatorlineimgvw;
@synthesize videoView;
@synthesize owner;
@synthesize DirtyThirtyIndex;
@synthesize ExercicesArray;
@synthesize exerciseCount;
@synthesize currenIndex;
@synthesize CardioExerciseTime;

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
- (void)viewDidLoad {
    [super viewDidLoad];
	
	timerextern=self;
    [self TimerConfiguration];  
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerText:) 
//												 name:@"updateTimerValue" object:nil];
    
}

-(void)updateTimerText:(float)updateValue:(int)index
{
  //  seconds=seconds+updateValue;
    //workoutCount=workoutCount+updateValue;
    currenIndex=index;
    
    NSLog(@"update my timer value");
}

-(void)TimerConfiguration
{
    isDoWorkout=NO;
	CGRect frame = CGRectMake(35, 125, 245, 18);
	WorkoutSlider = [[UISlider alloc] initWithFrame:frame];
	WorkoutSlider.minimumValue = 0.0;
	WorkoutSlider.maximumValue=1800;
	WorkoutSlider.continuous = YES;
	
	CGRect frame1 = CGRectMake(35, 300, 245, 18);
	ExerciseSlider = [[UISlider alloc] initWithFrame:frame1];
	ExerciseSlider.minimumValue = 0.0;
	ExerciseSlider.maximumValue=360;
    ExerciseSlider.continuous = YES;
	
	WorkoutSlider.userInteractionEnabled = NO;
	ExerciseSlider.userInteractionEnabled = NO;
	WorkoutSlider.opaque=YES;
	ExerciseSlider.opaque=NO;
    
    
	UIImage *stetchLeftTrack	= [[UIImage imageNamed:@"GreenBar-1.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:0.0];
	UIImage *stetchRightTrack	= [[UIImage imageNamed:@"slideroutlined.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:0.0];
	UIImage *stetchLeftTrack2	= [[UIImage imageNamed:@"GreenBar-1.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:0.0];
	UIImage *stetchRightTrack2	= [[UIImage imageNamed:@"slideroutlined.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:0.0];
	
	[WorkoutSlider setMinimumTrackImage:stetchLeftTrack2 forState:UIControlStateNormal];	
	[WorkoutSlider setMaximumTrackImage:stetchRightTrack2 forState:UIControlStateNormal];
	[WorkoutSlider setThumbImage: [UIImage imageNamed:@"green-back.png"] forState: UIControlStateNormal];
	
    [ExerciseSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];	
	[ExerciseSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
	[ExerciseSlider setThumbImage: [UIImage imageNamed:@"green-back.png"] forState: UIControlStateNormal];
	//cardioExercises=[[NSMutableArray alloc] init];
	[self.view addSubview: WorkoutSlider];
	[self.view addSubview: ExerciseSlider];

}
-(void)viewWillAppear:(BOOL)animated
{
       NSLog(@"Button index is :%d",DirtyThirtyIndex);
	[self.view bringSubviewToFront:middleseparaterlineimgvw];
	[self.view bringSubviewToFront:middleseparatorlineimgvw];
    
    
    NSLog(@"%d",[cardioExercises count]);
	
    if(isDoWorkout)
    {
                    
        
        if([ExercicesArray count]>0)
        {
            int workoutmaxtime=1800;    
           
            WorkoutSlider.maximumValue=workoutmaxtime;
            int noofcardioExercise=[cardioExercises count];
            
            
            int noofExercises=[ExercicesArray count]- noofcardioExercise;
             exercisemaxtime=(1800-(noofcardioExercise*30))/(noofExercises*60);
            int exrercisemaxtimeinseconds=(1800-(noofcardioExercise*30))/noofExercises;
           // float maxValue=1800/(noofExercises*60);
            //[[[ExercicesArray objectAtIndex:0] objectForKey:@"time"] intValue]*60;
            float exercisemedtime=exercisemaxtime/2;
         //   NSLog(@"====== %d",exercisemaxtime);
        //	NSLog(@"current Index=%d",currenIndex);
            
            WrkoutmaxtimeIndicator.text=@"30 min";     //[NSString stringWithFormat:@"%@ min",[self checktimeForAllExercies]]; 
            WorkoutmediumtimeIndicator.text=@"15 min"; //[NSString stringWithFormat:@"%d min",workoutmedtime]; 
            
            if(currenIndex==0)
             {
                if(DirtyThirtyIndex==2)
                {
                if([[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"isCardio"]!=[NSNull null])
                {
                    
                     if  ([[[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"isCardio"] intValue]==1)
                    {
                        ExercisemaxtimeIndicator.text=[NSString stringWithFormat:@"%d sec",exercisemaxtime];
                       
                        ExercisemediumtimeIndicator.text=[NSString stringWithFormat:@"%.1f sec",exercisemedtime];
                        ExerciseSlider.maximumValue=30;
                        [exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"Exercise_Name"]]];
                      
                    }
                }
                else
                {
                    ExercisemaxtimeIndicator.text=[NSString stringWithFormat:@"%d min",exercisemaxtime];
                    //[[ExercicesArray objectAtIndex:0] objectForKey:@"time"]];
                    ExercisemediumtimeIndicator.text=[NSString stringWithFormat:@"%.1f min",exercisemedtime];
                    
                    ExerciseSlider.maximumValue=exrercisemaxtimeinseconds;
                    [exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"Exercise_Name"]]];
                }

                }
                  
                    else if(DirtyThirtyIndex==1)
                    {
                        if([[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"IsWorkoutCardio"]!=[NSNull null])
                        {
                            
                            if  ([[[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"IsWorkoutCardio"] intValue]==1)
                            {
                                ExercisemaxtimeIndicator.text=[NSString stringWithFormat:@"%d sec",exercisemaxtime];
                                
                                ExercisemediumtimeIndicator.text=[NSString stringWithFormat:@"%.1f sec",exercisemedtime];
                                ExerciseSlider.maximumValue=30;
                                [exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"Exercise_Name"]]];
                                
                            }
                        }
                        else
                        {
                            ExercisemaxtimeIndicator.text=[NSString stringWithFormat:@"%d min",exercisemaxtime];
                            //[[ExercicesArray objectAtIndex:0] objectForKey:@"time"]];
                            ExercisemediumtimeIndicator.text=[NSString stringWithFormat:@"%.1f min",exercisemedtime];
                            
                            ExerciseSlider.maximumValue=exrercisemaxtimeinseconds;
                            [exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currentIndex] objectForKey:@"Exercise_Name"]]];
                        }


                    
                }
            }
            [workoutlbl setText:workoutName];
		}
		
		//[exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:0] objectForKey://@"Exercise_Name"]]];
        if(ExerciseTimer)
        {
            [self.view bringSubviewToFront:stopBtn];
        }
        else
        {
            [self.view bringSubviewToFront:startBtn];
        }
        }
    else
    {
        //[self TimerConfiguration];
      //  NSLog(@"puneet");
    }
	
	[self updateSeconds];
	[self updateMinutes];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"Button index is:%d",DirtyThirtyIndex);
    if(currenIndex<[ExercicesArray count]){
       // [owner setSwapString:nil];
        [owner setExerciseIndex:currenIndex];
        [owner setSwapString:[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"Exercise_Name"]];
        [owner setExerciseId:[[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"id"] intValue]];
        
}


}

-(IBAction)pushStartBtn:(id)sender
{
    if(minutes==30)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Start DoworkOut Again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
 else if(seconds==0)
 {
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Start DoworkOut First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alert show];
     [alert release];

 }
    
    
    
    
else 
{
    if(DirtyThirtyIndex==2||DirtyThirtyIndex==1){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Start DoworkOut Again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
else
{
	[self.view bringSubviewToFront:stopBtn];
	[self startTimers];
	
}
  
}
    
}

-(void)getWorkoutName:(NSString *)workout
{

	workoutName=workout;
	
	}
-(void)getExerciseElements:(NSArray *)ExerciseArr
{
	
	if([ExercicesArray count]>0 )
	{
		[ExercicesArray removeAllObjects];
		[ExercicesArray release];
		ExercicesArray = nil;
	}
    

    cardioExercises=[[NSMutableArray alloc] init];
	ExercicesArray=[[NSMutableArray alloc]initWithArray:ExerciseArr];
   	
   }



-(void)startWorkout
{
	minutes=0;
	seconds=0;
	if(WorkoutTimer)
		[WorkoutTimer invalidate];
	if(ExerciseTimer)
		[ExerciseTimer invalidate];
	if(SecondsTimer)
	[SecondsTimer invalidate];
	[self startTimers];
	[self.view bringSubviewToFront:stopBtn];
	currenIndex=0;
	ElapsedTime=0;
	workoutCount=0;
	exerciseCount=0;
	TotalTime=0;
    CardioExerciseTime=0;
    for(int i=0;i<[ExercicesArray count];i++)
    { // NSLog(@" %@",[[ExercicesArray objectAtIndex:i] objectForKey:@"isCardio"]);
        if(DirtyThirtyIndex==2)
        {
        if ([[ExercicesArray objectAtIndex:i] objectForKey:@"isCardio"]!=[NSNull null]) {
             if([[[ExercicesArray objectAtIndex:i] objectForKey:@"isCardio"] intValue]==1)
            

            {
                
                [cardioExercises addObject:[[ExercicesArray objectAtIndex:i] objectForKey:@"isCardio"]];
            }
            
            }
        }
        else
        {
            if ([[ExercicesArray objectAtIndex:i] objectForKey:@"IsWorkoutCardio"]!=[NSNull null]) {
                if([[[ExercicesArray objectAtIndex:i] objectForKey:@"IsWorkoutCardio"] intValue]==1)
                    
                    
                {
                    
                    [cardioExercises addObject:[[ExercicesArray objectAtIndex:i] objectForKey:@"IsWorkoutCardio"]];
                }
                
            }
            
        }
         }


          }

-(void)stopTheTimer
{
    if(WorkoutTimer){
    [WorkoutTimer invalidate];
    WorkoutTimer=nil;
    }
	if(ExerciseTimer)
    {
		[ExerciseTimer invalidate];
    ExerciseTimer=nil;
    }
	if(SecondsTimer)
    {
        [SecondsTimer invalidate];
        SecondsTimer=nil;
    
    }
    
//    minutes=0;
//	seconds=0;
//    currenIndex=0;
//	ElapsedTime=0;
//	workoutCount=0;
//	exerciseCount=0;
//	TotalTime=0;
//    CardioExerciseTime=0;
   // [ExercicesArray removeAllObjects];

    
    }


    

-(void)startTimers
{
	WorkoutTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(workoutSlider:) userInfo:nil repeats:YES];
	ExerciseTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ExerciseSlider:) userInfo:nil repeats:YES];
	SecondsTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(secondstime) userInfo:nil repeats:YES];
}
	

-(void)workoutSlider:(NSTimer *)timer
{
	WorkoutSlider.value = workoutCount++;
}

-(void)ExerciseSlider:(NSTimer *)timer
{
	ExerciseSlider.value = exerciseCount++;
    ElapsedTime++;
}

-(void)secondstime
{
	
    timeForExercise++;
    
	if(seconds<59)
	{
        seconds++;
    }
        
     else if(minutes<60)
		{
			minutes++;
			TotalTime++;

           

			if(TotalTime==30)
			{
				if(WorkoutTimer)
				{
					[WorkoutTimer invalidate];
					WorkoutTimer = nil;
				}
				if(ExerciseTimer)
				{
					[ExerciseTimer invalidate];
					ExerciseTimer=nil;
				}
				if(SecondsTimer)
				{
					[SecondsTimer invalidate];
					SecondsTimer = nil;
				}
				seconds=0;
				[self updateMinutes];
				[self updateSeconds];
				return;
            }
				
          seconds = 0;
	      [self updateMinutes];
       
        }
	[self updateSeconds];
    
   if(isDoWorkout)
   {
       if(currenIndex<[ExercicesArray count]){
           
           
           //For dirtythirty exercices
           
           if(DirtyThirtyIndex==2)
           {
            if([[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"isCardio"]!=[NSNull null])
            {                
              
                
                if([[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"isCardio"] intValue]==1)
                {
                   
                                       [exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"Exercise_Name"]]]; 
                
                    
            

                    ExerciseSlider.maximumValue=30;
                    ExercisemaxtimeIndicator.text=@"30 sec";
                    ExercisemediumtimeIndicator.text=@"15 sec";
                }
                CardioExerciseTime++;
                
                if(CardioExerciseTime==30) 
                {
                    currenIndex++;
                   // seconds=0;
                //minutes=0;
                    exerciseCount=0;
                    CardioExerciseTime=0;
                }

            
            
            }
            
            
         else{    
                
                
                int timeValue=(1800-([cardioExercises count]*30))/([ExercicesArray count]-[cardioExercises count]);//
                
                if(exerciseCount==timeValue)
                {
                    currenIndex++;
                    exerciseCount=0;
                }
                
                if(currenIndex<[ExercicesArray count])
                {
                    int maximumValue=(1800-([cardioExercises count]*30))/([ExercicesArray count]-[cardioExercises count]);
					ExerciseSlider.maximumValue=maximumValue;
                    float Exercisetime=(1800-([cardioExercises count]*30))/(([ExercicesArray count]-[cardioExercises count])*60);
                    ExercisemaxtimeIndicator.text=[NSString stringWithFormat:@"%.1f min",Exercisetime];
					ExercisemediumtimeIndicator.text=[NSString stringWithFormat:@"%.1f min",Exercisetime/2];
					[exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"Exercise_Name"]]];                
                }
            }

           }
           //For Predesigned exercices
            if(DirtyThirtyIndex==1)
            {
                
                if([[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"IsWorkoutCardio"]!=[NSNull null])
                {                
                    
                    
                    if([[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"IsWorkoutCardio"] intValue]==1)
                    {
                        
                        [exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"Exercise_Name"]]]; 
                        
                        
                        
                        
                        ExerciseSlider.maximumValue=30;
                        ExercisemaxtimeIndicator.text=@"30 sec";
                        ExercisemediumtimeIndicator.text=@"15 sec";
                    }
                    CardioExerciseTime++;
                    
                    if(CardioExerciseTime==30) 
                    {
                        currenIndex++;
                        //seconds=0;
                        //minutes=0;
                        exerciseCount=0;
                        CardioExerciseTime=0;
                    }
                    }
                else{    
                    
                    
                    int timeValue=(1800-([cardioExercises count]*30))/([ExercicesArray count]-[cardioExercises count]);//
                    
                    if(exerciseCount==timeValue)
                    {
                        currenIndex++;
                        exerciseCount=0;
                    }
                    
                    if(currenIndex<[ExercicesArray count])
                    {
                        int maximumValue=(1800-([cardioExercises count]*30))/([ExercicesArray count]-[cardioExercises count]);
                        ExerciseSlider.maximumValue=maximumValue;
                        float Exercisetime=(1800-([cardioExercises count]*30))/(([ExercicesArray count]-[cardioExercises count])*60);
                        ExercisemaxtimeIndicator.text=[NSString stringWithFormat:@"%.1f min",Exercisetime];
                        ExercisemediumtimeIndicator.text=[NSString stringWithFormat:@"%.1f min",Exercisetime/2];
                        [exerciselbl setText:[NSString stringWithFormat:@"%@",[[ExercicesArray objectAtIndex:currenIndex] objectForKey:@"Exercise_Name"]]];                
                    }}
}
}
}

    if(app.isDirtyThirty==YES)
        [self checkingStatusOfExerciseAndTime:currenIndex];
}



-(void)checkingStatusOfExerciseAndTime:(int)index
{
    if(currenIndex>=[ExercicesArray count])
    {
        NSLog(@"print me");
        
        if(WorkoutSlider.value<1800)
        {
            currenIndex=0;
            seconds=0;
            [self stopTheTimer];

            [self startTimers];
        }
        else
        {
            //[self stopTheTimer];
        }
    }
}

-(void)updateSeconds
{
	NSString *string;
	if(seconds < 10)
		string=[NSString stringWithFormat:@"0%d",seconds];
	else 
		string=[NSString stringWithFormat:@"%d",seconds];
	
	[secondslbl setText:string];
}

-(void)updateMinutes
{
	NSString *string;
	if(minutes < 10)
		string=[NSString stringWithFormat:@"0%d",minutes];
	
	else
		string=[NSString stringWithFormat:@"%d",minutes];
	
	[minuteslbl setText:string];
}

-(NSString *)checktimeForAllExercies
{
	int time=0;
	for (int i=0;i<[ExercicesArray count]; i++) {
		
		time+=[[[ExercicesArray objectAtIndex:i] objectForKey:@"time"] intValue];
	}
	NSString *tempString=[NSString stringWithFormat:@"%d",time];
	return tempString;
}

-(IBAction)pushStopBtn:(id)sender
{
	[self.view bringSubviewToFront:startBtn];
	if(WorkoutTimer)
	{
		[WorkoutTimer invalidate];
		WorkoutTimer = nil;
	}
	if(ExerciseTimer)
	{
		[ExerciseTimer invalidate];
		ExerciseTimer=nil;
	}
	if(SecondsTimer)
	{
		[SecondsTimer invalidate];
		SecondsTimer = nil;
	}
    DirtyThirtyIndex=0;
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
    [exerciselbl release];
}


@end
