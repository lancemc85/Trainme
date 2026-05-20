//
//  pagesViewController.h
//  HotelConnect
//
//  Created by raidu on 10/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>



@interface pagesViewController : UIViewController{
	
	int pageNumber;
    IBOutlet UIImageView *imageView1;	
	NSMutableArray *list;
	UIImage *image1; 
	NSMutableArray *exercisephotoArray;
	NSInteger exerciseId;
	id pageOwner;
	int i;

}

@property (nonatomic, retain) IBOutlet UIImageView *imageView1;
@property(nonatomic,readwrite)	NSInteger exerciseId;
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain)	id pageOwner;


-(id)initWithPageNumber:(int)page;
-(void)gettingPicsArrayFromDatabase;
-(NSArray *)getPicsVideoForQuery:(NSString *)Query;
-(UIImage *)resizeImageFromImage:(UIImage *)img withSize:(CGSize)newSize;
-(void)addNewImageToScroll;




@end

