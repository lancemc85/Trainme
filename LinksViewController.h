//
//  LinksViewController.h
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LinksViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UITableView *linksViewLinkTable;
	IBOutlet UIButton *linksViewPushBackBtn;
	IBOutlet UIButton *linksViewEmailBtn;
	NSString *linksData;
	NSString *linksTitle;
    NSMutableArray *linkArray;
}

@property(nonatomic,retain)IBOutlet  UITableView *linksViewLinkTable;
@property(nonatomic,retain)IBOutlet UIButton *linksViewPushBackBtn;
@property(nonatomic,retain)IBOutlet UIButton *linksViewEmailBtn;
@property(nonatomic,retain)	NSString *linksData;
@property(nonatomic,retain)	NSString *linksTitle;

-(IBAction)pushGoBack:(id)sender;
-(IBAction)EmailBtnPressed:(id)sender;
-(NSArray *)SelectData;


@end
