//
//  videoViewController.m
//  Exercise
//
//  Created by Dev Team on 2/4/11.
//  Copyright 2011 CopperMobile Inc. All rights reserved.
//

#import "videoViewController.h"
#import "InfoExerciseViewController.h"
#import "ShuffleViewController.h"
#import "WorkoutViewController.h"
#import "SwapViewController.h"
#import "ExerciseAppDelegate.h"
#import "TouchSQL.h"
#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"
#import "TimerViewController.h"
//#define degreesToRadians(x) (M_PI * (x) / 180.0)


//static NSUInteger kNumberOfPages=6;

@interface videoViewController (PrivateMethods)

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end


@implementation videoViewController

@synthesize swapString;
@synthesize owner;
@synthesize ExString;
@synthesize path;
@synthesize exerciseId;
@synthesize player;
@synthesize exerciseInfotxtvw;
@synthesize txtvwstr;
@synthesize imageNamestr;
@synthesize videoNamestr;
@synthesize scrollView,viewControllers,pageControl;
@synthesize pagesviewcontroller;
@synthesize xCd;
@synthesize yCd;   
@synthesize  Buttonindex;
@synthesize isdirtyThirty;
@synthesize  ExerciseIndex;
@synthesize  Workout_id;
@synthesize DOWorkOutBtn;
@synthesize CardioTime;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

//Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    [super viewDidLoad];
	exerciseArray=[[NSMutableArray alloc]init];
	exerciseVideoArray=[[NSMutableArray alloc]init];
    shuffleArray=[[NSMutableArray alloc]init];
    exercisephotoArray=[[NSMutableArray alloc]init];
	
	
	//HomeViewController *homeViewController=[[HomeViewController alloc]init];
	//pagesviewcontroller=[[pagesViewController alloc]initWithNibName:@"pagesViewController" bundle:[NSBundle mainBundle]];
//	[pagesviewcontroller setPageOwner:self];

	
	//NSMutableArray *controllers = [[NSMutableArray alloc] init];
//    for (unsigned i = 0; i <= [exercisephotoArray count]; i++) 
//	{
//		[controllers addObject:[NSNull null]];
//    }
//    self.viewControllers = controllers;
//    [controllers release];
//	scrollView.pagingEnabled = YES;
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.scrollsToTop = YES;
//    scrollView.delegate = self;
//    
//    scrollView.layer.cornerRadius= 8;
//
//	
//    pageControl.numberOfPages = kNumberOfPages;
//    pageControl.currentPage = 0;
	//[scrollView setHidden:NO];
//	//[self loadScrollViewWithPage:0];
//    [self loadScrollViewWithPage:1];
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
	
	//isdirtyThirty=NO;
    
    
    //-----Added by PARAS-----//
    
    [self checkUserTextAlertStatus];
}

//infoBtnClick Added by Shiva
-(IBAction)infoBtnClick:(id)sender
{

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Tap the image to view more information about the Exercise"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show]; 
	[alert release];
}

#pragma added by PARAS 

-(void)checkUserTextAlertStatus
{
    NSUserDefaults *pref        =[NSUserDefaults standardUserDefaults];
    
    if([pref valueForKey:@"FirstTimeAlertShow"]==nil)
    {
        UIAlertView *alert      =[[UIAlertView alloc]
                                  initWithTitle:@"Alert" message:@"Tap the image to view more information about the exercise" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        [alert release];
        
        
        [pref setObject:@"AlertShown" forKey:@"FirstTimeAlertShow"];
        [pref synchronize];
        
    }
    
}
-(IBAction)plusBtn:(id)sender{
    WorkoutViewController *workoutVC = [[WorkoutViewController alloc] initWithNibName:@"WorkoutViewController" bundle:[NSBundle mainBundle]];  
    if(Buttonindex==2){
        [workoutVC workoutViewFlag:YES];
       [workoutVC DirtyThirtyExerciseAray:shuffleArray];
         [self.navigationController pushViewController:workoutVC animated:YES];
  }
    if(Buttonindex==1)
    {
        [workoutVC workoutViewFlag:NO]; 
        workoutVC.Workout_id=Workout_id;
         [self.navigationController pushViewController:workoutVC animated:YES];
       // [workoutVC loadData];
        
    }
    
   
}


-(void)ExerciseIdFromTimer:(NSInteger)ExerciseId:(NSInteger)ButtonIndex:(NSString *)Exercisename{
    
    
    if(ButtonIndex==2){
        NSLog(@"Ex;%@",Exercisename);
        exerciseId=ExerciseId;
        Buttonindex=ButtonIndex;
        label.text=Exercisename;
       // isdirtyThirty=isdirty;
    }
    
}
-(NSString *)getRandomExerciseQuery
{
    NSMutableString *query = [[NSMutableString alloc] init];
    for (int idx=0; idx < 13; idx++)
    {
        if(idx > 0)
            [query appendString:@" UNION ALL "];
        if((idx % 2) == 0)
        {
            [query appendString:@"select * from (SELECT * FROM Exercise AS e INNER JOIN Exercise_BodyPart AS eb on eb.Exercise_id = e.id WHERE eb.BodyPart_id= "];
            switch (idx)
            {
                case 0: [query appendString:@"9"]; break;
                case 2: [query appendString:@"6"]; break;
                case 4: [query appendString:@"1"]; break;
                case 6: [query appendString:@"3"]; break;
                case 8: [query appendString:@"10"]; break;
                case 10: [query appendString:@"4"]; break;
                case 12: [query appendString:@"2"]; break;
                
                    
            }
            [query appendString:@" AND e.isCardio isNull ORDER BY RANDOM() LIMIT 1)"];
        }
        else
        {
            [query appendString:@"select * from (SELECT * FROM Exercise AS e INNER JOIN Exercise_BodyPart AS eb on eb.Exercise_id = e.id WHERE e.isCardio=1 ORDER BY RANDOM() LIMIT 1)"];
        }
    }
    return query;
}


-(NSString *)getExerciseFromSelectedWorkout{
    
    CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from Exercise join Workout_Exercise on Exercise.id=Workout_Exercise.Exercise_id where Workout_Exercise.Workout_id=%d",Workout_id];
    return Query;
    
    }


-(void)viewWillAppear:(BOOL)animated

{ 
       
    
    
  
       if(Buttonindex==2||Buttonindex==1)
       {
      if(exerciseId==0)
      {
          
          if([shuffleArray count]>0)
          {
              [shuffleArray removeAllObjects];
          }
          CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
          
          [db open:NULL];
         //for Dirty-Thirty Exercises
          if(Buttonindex==2)
          {
           NSString *Query = [self getRandomExerciseQuery];
         
                    NSArray *rows = [db rowsForExpression:Query error:nil];
          
          [shuffleArray addObjectsFromArray:rows];
          
              exerciseId=[[[shuffleArray objectAtIndex:0] objectForKey:@"id"] intValue];
              label.text=[[shuffleArray objectAtIndex:0] objectForKey:@"Exercise_Name"] ;
              
              if([[shuffleArray objectAtIndex:0] objectForKey:@"isCardio"]!=[NSNull null])
              {                
                  if([[[shuffleArray objectAtIndex:0] objectForKey:@"isCardio"] intValue]==1)
                  {
                      [cardiotime setHidden:NO];
                      [reps setHidden:YES];
                      [cardiotime setTitle:@"30" forState:UIControlStateNormal];
                      count=0;
                      CardioTime=30;
                      [cardiotime setUserInteractionEnabled:YES];
                  }
              }
              else
              {
                
                      
                      NSString *repStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"REPETION"];
                      if(repStr==NULL)
                          [reps setHidden:YES];
                      else
                      [reps setHidden:NO];
                      
                  [reps setTitle:repStr forState:UIControlStateNormal];
                      [cardiotime setHidden:YES];
                      [cardiotime setUserInteractionEnabled:NO];
                  [self stopTimer];
              }

          }
          // end
          
          // For Workout Exercises
          
          if(Buttonindex==1)
          {
              NSString *Query = [self getExerciseFromSelectedWorkout];
              
              NSArray *rows = [db rowsForExpression:Query error:nil];
              
              [shuffleArray addObjectsFromArray:rows];
              
          
          
          
          NSLog(@"Radom array or shuffle array :-%@",shuffleArray);
          
          exerciseId=[[[shuffleArray objectAtIndex:0] objectForKey:@"id"] intValue];
         label.text=[[shuffleArray objectAtIndex:0] objectForKey:@"Exercise_Name"] ;
          
          if([[shuffleArray objectAtIndex:0] objectForKey:@"IsWorkoutCardio"]!=[NSNull null])
          {                
              if([[[shuffleArray objectAtIndex:0] objectForKey:@"IsWorkoutCardio"] intValue]==1)
              {
                     [cardiotime setHidden:NO];
                  [reps setHidden:YES];
                  [cardiotime setTitle:@"30" forState:UIControlStateNormal];
                  count=0;
                  CardioTime=30;
                   [cardiotime setUserInteractionEnabled:YES];
                }
          }
          else
          {
         if([[shuffleArray objectAtIndex:0] objectForKey:@"REPS"]==[NSNull null])
         {
           [reps setHidden:YES];  
         }
         else{    
          [reps setTitle:[[shuffleArray objectAtIndex:0] objectForKey:@"REPS"] forState:UIControlStateNormal];
              [reps setHidden:NO];
         }
         [cardiotime setHidden:YES];
          [cardiotime setUserInteractionEnabled:NO];
          }
          }
          // end
          if(scrollView){
              [scrollView setHidden:NO];
              [pageControl setHidden:NO];
          }
          
          
          [self calculatingOtherExerciseTime];
          
          [self doPageViewConfiguration];
          [NextBtn setHidden:YES];
}
     
      
      
else
        {
            label.text=[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"Exercise_Name"] ;
            
            if(Buttonindex==1)
            {
            if([[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"IsWorkoutCardio"]!=[NSNull null])
            {                
                if([[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"IsWorkoutCardio"] intValue]==1)
                {
                    [cardiotime setHidden:NO];
                    [reps setHidden:YES];
                      
                   // [cardiotime setTitle:@"30" forState:UIControlStateNormal];
                   
                    }
            }
            else
            {
                if([[shuffleArray objectAtIndex:0] objectForKey:@"REPS"]==[NSNull null])
                {
                    [reps setHidden:YES];  
                }
                else{    
                    
            [reps setTitle:[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"REPS"] forState:UIControlStateNormal];
                 [reps setHidden:NO];
                }
                 [cardiotime setHidden:YES];
                 }
            }
                 
            
            if(Buttonindex==2)
            {
                if([[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"isCardio"]!=[NSNull null])
                {                
                    if([[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"isCardio"] intValue]==1)
                    {
                        [cardiotime setHidden:NO];
                        [reps setHidden:YES];
                        
                       
                        
                    }
                }
                else
                {

                     NSString *repStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"REPETION"];
                     if(repStr==NULL)
                         [reps setHidden:YES];
                     else
                         [reps setHidden:NO];
                     [reps setTitle:repStr forState:UIControlStateNormal];
                     [cardiotime setHidden:YES];
                  }
            }

            if(scrollView){
                [scrollView setHidden:NO];
                [pageControl setHidden:NO];
            }
            [self doPageViewConfiguration];

            
                    }
     
       
        [DOWorkOutBtn setHidden:NO];
           [plusButton setHidden:NO];
        [NextBtn setUserInteractionEnabled:YES];
    }
    else{
        [DOWorkOutBtn setHidden:YES];
        [NextBtn setHidden:YES];
        [plusButton setHidden:YES];
        [reps setHidden:YES];
        [cardiotime setHidden:YES];
        label.text=swapString;
        [self doPageViewConfiguration];
    }
    }



-(void)calculatingOtherExerciseTime
{
    int tempCounter=0;
    
    for(int counter=0;counter<[shuffleArray count];counter++)
    {
        if(Buttonindex==2)
        {
        if([[shuffleArray objectAtIndex:counter] objectForKey:@"isCardio"]!=[NSNull null])
        {
            if([[[shuffleArray objectAtIndex:counter] objectForKey:@"isCardio"] intValue]==1)
            {
                tempCounter++;
            }
        }
        }
        if(Buttonindex==1)
        {
            if([[shuffleArray objectAtIndex:counter] objectForKey:@"IsWorkoutCardio"]!=[NSNull null])
            {
                if([[[shuffleArray objectAtIndex:counter] objectForKey:@"IsWorkoutCardio"] intValue]==1)
                {
                    tempCounter++;
                }
            }  
            
        }
        
    }
    
    NSLog(@"tempCounter %d",tempCounter);
    
    otherExerciseTime=(30.0*60-tempCounter*30.0)/(([shuffleArray count]-tempCounter));
    
    NSLog(@"otherExerciseTime: %f",otherExerciseTime);
    
}



-(void)doPageViewConfiguration
{
    

    txtvwstr=[[NSMutableString alloc]init];
	
	
	if ([exerciseVideoArray count]>0)
	{    
		[exerciseVideoArray removeAllObjects];
        
	}
	
		if ([exerciseArray count]>0)
	{
		[exerciseArray removeAllObjects];
	}
	
	if([exercisephotoArray count]>0)
	{
		[exercisephotoArray removeAllObjects];
	}
	NSArray *exerciseinfoArray,*exerciseVidArray,*exercisePicsArray;
	
   
	exerciseinfoArray=[self getDataForQuery:[NSString stringWithFormat:@"SELECT * FROM Exercise_Info where Exercise_id=%d",exerciseId]];
	exerciseVidArray=[self getPicsVideoForQuery:[NSString stringWithFormat:@"SELECT VideoName FROM Exercise_PicVid where Exercise_id='%d'",exerciseId]];
     exercisePicsArray=[self getPicsForQuery:[NSString stringWithFormat:@"SELECT PhotoName FROM Exercise_PicVid where Exercise_id=%d",exerciseId]];
    
	if([exerciseinfoArray count]>0) 
    {
        [exerciseArray addObjectsFromArray:exerciseinfoArray];
	
    	
//    [exerciseVideoArray addObjectsFromArray:exerciseVidArray];
//         [playVideoBtn setHidden:NO];
        
        if ([exerciseVidArray count]>0) 
        {
            NSLog(@"here data is: %@", exerciseVidArray);
            [exerciseVideoArray addObjectsFromArray:exerciseVidArray];
            [playVideoBtn setHidden:NO];
            //NSLog(@"success:%@",[[exerciseVideoArray objectAtIndex:0] objectForKey:@"VideoName"]);
            if([[exerciseVideoArray objectAtIndex:0] objectForKey:@"VideoName"]== [NSNull null] || [[[exerciseVideoArray objectAtIndex:0] objectForKey:@"VideoName"] length] == 0)
            {
                [playVideoBtn setHidden:YES];
            }
        }
    if([exercisePicsArray count]>0)
    {
          [exercisephotoArray addObjectsFromArray:exercisePicsArray];
                NSDictionary *d=[exercisephotoArray objectAtIndex:0];
        NSString *s=[d objectForKey:@"PhotoName"];
        NSLog(@"pic name >>>>>>>>>>>>>> %@",s);
        if([s isKindOfClass:[NSNull class]])
        [exercisephotoArray removeObjectAtIndex:0];
    }
      

	
	NSLog(@"exerciseArray is %@",exerciseArray);
	NSLog(@"............888    %d",[exercisephotoArray count]);
    NSLog(@"............888    %@",exercisephotoArray);
    NSLog(@"scrollView  %@",scrollView);
        
        if([exercisephotoArray count]==0)
        {
            [self hidescrollview];
        }

    }
    
//    if([exercisephotoArray count]==0)
//    {
//        [self hidescrollview];
//    }
    
	
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
	
	[controllers removeAllObjects];
	[self.viewControllers removeAllObjects];
	
    for ( int k = 0; k < [exercisephotoArray count]; k++) 
	{
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
	scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [exercisephotoArray count], scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    //scrollView.delegate = self;
    
    scrollView.layer.cornerRadius= 8;
    
	
    pageControl.numberOfPages = [exercisephotoArray count];
    pageControl.currentPage = 0;
	
    
    [self loadScrollViewWithPage:0];
      [self loadScrollViewWithPage:1];
    

	for (int j=-2; j<7; j++) 
	{
		NSString *tempstr=[NSString stringWithFormat:@"Step%d",j+1];
       
        if([exerciseArray count]>0){
            if([[exerciseArray objectAtIndex:0]objectForKey:tempstr]!=[NSNull null])
            {
                NSString *steps=[NSString stringWithFormat:@"%@\n\n",[[exerciseArray objectAtIndex:0]objectForKey:tempstr]];
                [txtvwstr appendString:steps];
            }
        }
	}
	
	exerciseInfotxtvw.text=txtvwstr;
  

}


- (void)loadScrollViewWithPage:(int)page 
{
	if (page < 0) 
	{
		
		return;
	}
//    NSLog(@"page: %d and array: %d", page, [exercisephotoArray count]);
	if (page >= [exercisephotoArray count])
	{
		return;
	}

	if(page<[exercisephotoArray count]){

	
	pagesViewController *controller = [viewControllers objectAtIndex:page];
	
		//NSLog(@"nviews: %d", [viewControllers count]);
    if ((NSNull *)controller == [NSNull null]) 
	{
		
        
        controller = [[pagesViewController alloc] initWithPageNumber:page];
        [controller setPageOwner:self];
		[viewControllers replaceObjectAtIndex:page withObject:controller];
		
		[controller release];
	}
	
    // add the controller's view to the scroll view
	if (nil == controller.view.superview) 
	{
	
        CGRect frame = scrollView.frame;
		
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
	
	[controller setExerciseId:exerciseId];
    [controller gettingPicsArrayFromDatabase];
	

	}
	
}

- (void)scrollViewDidScroll:(UIScrollView *)sender 
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) 
	{
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	


    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
	
		
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth)+1;
   

    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
	
	//NSLog(@"arry is %d, %d",[exercisephotoArray count],page);
	
			//NSLog(@"arry is %d < %d",page,[exercisephotoArray count]);
		//NSLog(@"Is it executing?");
        pageControl.currentPage = page;
		
	//	if(page > 0)
			[self loadScrollViewWithPage:page - 1];
		
		[self loadScrollViewWithPage:page];
		
	//	if(page < ([exercisephotoArray count]-2))
			[self loadScrollViewWithPage:page + 1];
		   
	
	
	
		
	// A possible optimization would be to unload the views+controllers which are no longer visible
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

-(IBAction)changeToNextExercise
{  
    [player stop];
    NSLog(@"current index is %d:",timerextern.currentIndex);
  
	
    
    ExerciseIndex=ExerciseIndex+1;
    if(ExerciseIndex<[shuffleArray count])
    {
        NSArray* array = [scrollView subviews];
        for(int K = 0; K < [array count]; K++)
        {
            if([[array objectAtIndex: K] isKindOfClass: [UIView class]])
                [[array objectAtIndex: K] removeFromSuperview];
        }
        exerciseId=[[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"id"] intValue];
        label.text=[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"Exercise_Name"];
   
        if(scrollView){
            [scrollView setHidden:NO];
            [pageControl setHidden:NO];
        }
         [self doPageViewConfiguration];
        
         [self updateTimer:ExerciseIndex];
    }
    else
    { 
        ExerciseIndex=0;
        NSArray* array = [scrollView subviews];
        for(int K = 0; K < [array count]; K++)
        {
           if([[array objectAtIndex: K] isKindOfClass: [UIView class]])
                [[array objectAtIndex: K] removeFromSuperview];
        }
        exerciseId=[[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"id"] intValue];
        label.text=[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"Exercise_Name"];
        
        if(scrollView){
            [scrollView setHidden:NO];
            [pageControl setHidden:NO];
        }
        [self doPageViewConfiguration];
        
        [self updateTimer:0];
        //timerextern.ElapsedTime==0;
      //  ExerciseIndex=ExerciseIndex-1;
        [NextBtn setUserInteractionEnabled:YES];
    }
}


-(void)updateTimer:(int)index
{
    
    if(Buttonindex==1)
    {

        if([[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"IsWorkoutCardio"]!=[NSNull null])
        {                
            if([[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"IsWorkoutCardio"] intValue]==1)
            {
                
            
            [timerextern updateTimerText:30.0:index];
             //timerextern.seconds=0;
             timerextern.CardioExerciseTime=0;
             timerextern.exerciseCount=0;
             [self stopTimer];
             [cardiotime setHidden:NO];
             [cardiotime setUserInteractionEnabled:YES];
             CardioTime=30;
             count=0;
             [reps setHidden:YES];
             [cardiotime setTitle:@"30" forState:UIControlStateNormal];
         }
     }
    else
    {
    [timerextern updateTimerText:otherExerciseTime:index];
    [cardiotime setHidden:YES];
        if([[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"REPS"]==[NSNull null])
        {
            [reps setHidden:YES];
        }
        else
        {
        [reps setHidden:NO];
    [reps setTitle:[[shuffleArray objectAtIndex:ExerciseIndex] objectForKey:@"REPS"] forState:UIControlStateNormal];
        }
    }
        }
        
    
    if(Buttonindex==2)
    {
        if([[shuffleArray objectAtIndex:index] objectForKey:@"isCardio"]!=[NSNull null])
        {
            if([[[shuffleArray objectAtIndex:index] objectForKey:@"isCardio"] intValue]==1)
            {
                
                [timerextern updateTimerText:30.0:index];
                //timerextern.seconds=0;
                timerextern.CardioExerciseTime=0;
                timerextern.exerciseCount=0;
                [self stopTimer];
                [cardiotime setHidden:NO];
                [cardiotime setUserInteractionEnabled:YES];
                CardioTime=30;
                count=0;
                [reps setHidden:YES];
                [cardiotime setTitle:@"30" forState:UIControlStateNormal];
            }
        }
        else
        {
            [timerextern updateTimerText:otherExerciseTime:index];
            [cardiotime setHidden:YES];
             NSString *repStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"REPETION"];
            if(repStr==NULL)
                [reps setHidden:YES];
            else
                [reps setHidden:NO];
            [reps setTitle:repStr forState:UIControlStateNormal];
            
        }
    }
        
    
}



-(void)setCardioTime{
    CardioTime--;
    
  
    [cardiotime setTitle:[NSString stringWithFormat:@"%d",CardioTime] forState:UIControlStateNormal];
    if(CardioTime==0)
    {
        [cardiotime setUserInteractionEnabled:NO];
      
            [SecondsTimer invalidate];
            SecondsTimer=nil;
        
        
    }
    }
-(IBAction)cardiotimeBtnClk:(id)sender
{
        count++;
    if(count%2!=0)
    {
        [self startTimer];
      
    }
    else
    {
       
    [self stopTimer];
        count=0;
        
    }
}

-(void)startTimer
{
    SecondsTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setCardioTime) userInfo:nil repeats:YES];
}

-(void)stopTimer
{
    
    [SecondsTimer invalidate];
    SecondsTimer=nil;
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView 
//{
//    pageControlUsed = NO;
//}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{
    pageControlUsed = NO;
}

-(IBAction)doWorkoutBtnPressed:(id)sender
{
	
    //---ADDED BY PARAS---//
    [NextBtn setHidden:NO];
    if(Buttonindex==2)
    {
    [app setIsDirtyThirty:YES];
    }
    if(Buttonindex==1)
    {
        [app setIsDirtyThirty:NO];
        app.Workout_id=Workout_id;
    }
	if([app.DirtyThirtyExerciseArray count]>0)
	{
		[app.DirtyThirtyExerciseArray removeAllObjects];
	}
    NSLog(@"shuffle array is %@:",shuffleArray);
	[app.DirtyThirtyExerciseArray addObjectsFromArray:shuffleArray];
	
    //changed by paras---//
  
    [app startTimersUpdated];
    
	timerextern.isDoWorkout=YES;
    [timerextern setOwner:self];
    [DOWorkOutBtn setUserInteractionEnabled:NO];
}



-(NSArray *)getDataForQuery:(NSString *)Query
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	
	NSArray *data = [db rowsForExpression:Query error:nil];

	[db release];
    NSLog(@"data is %@",data);
	return data;
}


-(NSArray *)getPicsVideoForQuery:(NSString *)Query
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	
	NSArray *data = [db rowsForExpression:Query error:nil];
	
	[db release];
	return data;
}

-(NSArray *)getPicsForQuery:(NSString *)Query
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	
	NSArray *data = [db rowsForExpression:Query error:nil];
	
	[db release];
	return data;
}


-(IBAction)pushPlayVideoBtn:(id)sender
{
	
	
	
	[self doPageViewConfiguration];
	NSBundle *Bundle=[NSBundle mainBundle];
  
      if([exerciseVideoArray count]==0){
//          UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"No Video for this Exercise" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//          [alert show];
//          [alert release];
         // [playVideoBtn setHidden:YES];
          return;
          
      }
    NSLog(@"exercise video detail: %@", exerciseVideoArray);    
    if([exerciseVideoArray count]>0){
	   //[playVideoBtn setHidden:NO];
	if([[exerciseVideoArray objectAtIndex:0] objectForKey:@"VideoName"]!= [NSNull null])
	{
//	NSLog(@"Video is : %@",[[exerciseVideoArray objectAtIndex:0] objectForKey:@"VideoName"]);
		NSString *videoPlay			=[Bundle pathForResource:[[exerciseVideoArray objectAtIndex:0] objectForKey:@"VideoName"] ofType:@"mp4"];
		//NSlog(@"exerciseVideoArray0000   %@",[[exerciseVideoArray objectAtIndex:0] objectForKey:@"VideoName"]);
//		NSLog(@"path is : %@",videoPlay);
		NSURL * pathURL	= [NSURL	fileURLWithPath:videoPlay isDirectory:NO];
		
		if(! [[NSFileManager defaultManager] fileExistsAtPath:videoPlay])
		{
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"No Video for this Exercise" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
			return;
		}
		player=[[MPMoviePlayerController alloc] initWithContentURL:pathURL]; 
		[self.view addSubview:player.view];
		player.view.frame = CGRectMake(20, 46, 279, 251);  
		[player play];
		
		/*if ([player respondsToSelector:@selector(loadState)]) 
		 {
		 // Set movie player layout
		 [player setControlStyle:MPMovieControlStyleFullscreen];
		 //[player setFullscreen:YES];
		 
		 // May help to reduce latency
		 //[player prepareToPlay];
		 
		 // Register that the load state changed (movie is ready)
		 [[NSNotificationCenter defaultCenter] addObserver:self 
		 selector:@selector(moviePlayerLoadStateChanged:) 
		 name:MPMoviePlayerLoadStateDidChangeNotification 
		 object:nil];
		 }  
		 else
		 {
		 // Register to receive a notification when the movie is in memory and ready to play.
		 [[NSNotificationCenter defaultCenter] addObserver:self 
		 selector:@selector(moviePreloadDidFinish:) 
		 name:MPMoviePlayerContentPreloadDidFinishNotification 
		 object:nil];
		 }
		 */
		// Register to receive a notification when the movie has finished playing. 
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(moviePlayBackDidFinish:) 
													 name:MPMoviePlayerPlaybackDidFinishNotification 
												   object:nil];
		[exerciseVideoArray removeAllObjects];
	}
	else 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"No Video for this Exercise" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
		[alert show];
		[alert release];
	}
    }
	

		
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{    
	
	player = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:player];
	[player stop];
	[player.view removeFromSuperview];
	
}




-(IBAction)pushBackBtn:(id)sender
{
    if([exercisephotoArray count]==0)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else
    {
       
        if(scrollView.hidden==YES)
        {
           [scrollView setHidden:NO];
           
        }
        else
            [self.navigationController popViewControllerAnimated:YES];
    }
	
    [pageControl setHidden:NO];
	//[exercisephotoArray removeAllObjects];
    
    [player.view removeFromSuperview];
}



//-(IBAction)ExchangeBtn:(id)sender
//{
//	[self.navigationController popViewControllerAnimated:NO];
//	[owner setSelectedIndex:path.row];		
//	[owner ExchangeExercise];
//}

//-(IBAction)EerciseBtn:(id)sender
//{
//	[scrollView setHidden:YES];
//}

-(void)hidescrollview
{
	if(scrollView){
	[scrollView setHidden:YES];
        [pageControl setHidden:YES];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
	
	[player stop];
      
    NSArray* array = [scrollView subviews];
    for(int K = 0; K < [array count]; K++)
	{
        if([[array objectAtIndex: K] isKindOfClass: [UIView class]])
            [[array objectAtIndex: K] removeFromSuperview];
	}
    
    if(scrollView){
        [scrollView setHidden:NO];
        [pageControl setHidden:NO];
    }
	 
    
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
  return YES; 
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [exerciseArray release];
	[exerciseVideoArray release];
    [exercisephotoArray release];
    [player release];
}


@end
