    //
//  pagesViewController.m
//  HotelConnect
//
//  Created by raidu on 10/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "pagesViewController.h"
#import "videoViewController.h"
#import "TouchSQL.h"
#import "ExerciseAppDelegate.h"
#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation pagesViewController

@synthesize imageView1;
@synthesize list;
@synthesize exerciseId;
@synthesize pageOwner;





// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page 
{
    if (self = [super initWithNibName:@"pagesViewController" bundle:nil]) 
	{
        pageNumber = page;
    }
    return self;
}


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
    exercisephotoArray=[[NSMutableArray alloc]init];
	 i=pageNumber;
    
   // imageView1.layer.cornerRadius= 8;
	
	NSLog(@"------- %d",i);
		
}

-(void)gettingPicsArrayFromDatabase
{
	
	if([exercisephotoArray count]>0)
	{
		[exercisephotoArray removeAllObjects];
	}
	
	NSArray *exercisePicsArray=[self getPicsVideoForQuery:[NSString stringWithFormat:@"SELECT PhotoName FROM Exercise_PicVid where Exercise_id=%d",exerciseId]];
	
	NSLog(@"%@",exercisePicsArray);
	//NSArray *exercisePicsArray=[self getPicsVideoForQuery:[NSString stringWithFormat:@"SELECT PhotoName FROM Exercise_PicVid where Exercise_id=1 AND Photo_Index=%d",i]];
	[exercisephotoArray addObjectsFromArray:exercisePicsArray];
	NSLog(@">>>>>>><<<%d",[exercisephotoArray count]);
	NSLog(@" jj%@",[[exercisephotoArray objectAtIndex:i] objectForKey:@"PhotoName"]);
    
    if([exercisephotoArray count]>0)
    {
        if([[exercisephotoArray objectAtIndex:i] objectForKey:@"PhotoName"]!=[NSNull null])
        {
    //      image1 =[UIImage imageNamed:[[exercisephotoArray objectAtIndex:i] objectForKey:@"PhotoName"]];
    //      UIImage *newImage = [self resizeImageFromImage:image1 withSize:imageView1.frame.size];
    //      imageView1.image=newImage; 
            
            [self addNewImageToScroll];
            
        }
        else
        {
            [pageOwner hidescrollview];
        }
    }
}


-(void)addNewImageToScroll
{
    float xCd        =0;
    float yCd        =0;
    
    image1 =[UIImage imageNamed:[[exercisephotoArray objectAtIndex:i] objectForKey:@"PhotoName"]];
    UIImage *newImage = [self resizeImageFromImage:image1 withSize:imageView1.frame.size];
    imageView1.image=newImage; 

    
    float xcord=([pageOwner scrollView].frame.size.width - newImage.size.width)/2;
    xCd= (xCd+xcord);
    yCd=([pageOwner scrollView].frame.size.height- newImage.size.height)/2;
    imageView1.frame =CGRectMake( xCd, yCd, newImage.size.width, newImage.size.height);
  //  imageView1.image=newImage; 

    NSLog(@"[pageOwner scrollView].frame.size.width  %f",[pageOwner scrollView].frame.size.width);
    NSLog(@"xcord  %f",xcord);
    NSLog(@"xCd  %f",xCd);
    NSLog(@"yCd  %f",yCd);
    NSLog(@"newImage.size.width  %f",newImage.size.width);
    NSLog(@"newImage.size.height   %f",newImage.size.height);
}

-(UIImage *)resizeImageFromImage:(UIImage *)img withSize:(CGSize)newSize
{
    
    float actualHeight = img.size.height;
    float actualWidth = img.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = newSize.width/newSize.height;
    
    if(imgRatio!=maxRatio){
        if(imgRatio < maxRatio){
            imgRatio = newSize.height / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = newSize.height;
        }
        else{
            imgRatio = newSize.width / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = newSize.width;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [img drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



-(void)viewDidAppear:(BOOL)animated
{
}


-(NSArray *)getPicsVideoForQuery:(NSString *)Query
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	[db open:NULL];
	
	NSArray *data = [db rowsForExpression:Query error:nil];
	
	[db release];
	return data;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"hhhhhhhhh");
   // [imageView1 setHidden:YES];
    [pageOwner hidescrollview];
    

}

-(void)viewWillDisappear:(BOOL)animated
{
  //image1 =[UIImage imageNamed:@""];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Overriden to allow any orientation.
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


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
    [exercisephotoArray release];
}


@end
