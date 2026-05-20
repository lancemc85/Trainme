//
//  SwapViewController.h
//  Exercise
//
//  Created by raidu on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class videoViewController,ShuffleViewController;

@interface SwapViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	
	videoViewController *video;
	ShuffleViewController *ss;
    NSString *swapString;
	NSInteger swapEx_id;
	NSMutableArray *swapArray;
	id owner;
	NSInteger bodyPart_id;
	NSString *checkString;
	IBOutlet UITableView *swapTableView;
	BOOL isSelect;
	NSInteger selectedIndex;
	NSIndexPath *selectedPath;
}


@property(nonatomic,retain)NSString *swapString;
@property(nonatomic,readwrite) NSInteger bodyPart_id;
@property (nonatomic, retain)id owner;
@property (nonatomic, readwrite)NSInteger selectedIndex;


-(IBAction)pushBackBtn:(id)sender;
-(void)ExchangeExercise;
-(void)ExchangeExerciseBtn:(id)sender;
-(void)SelectData;
//-(void)removeExchangeButton:(NSIndexPath *)indexPath;
//-(void)addExchangeButton:(NSIndexPath *)indexPath;


@end


extern SwapViewController *externswap;