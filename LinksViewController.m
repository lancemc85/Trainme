//
//  LinksViewController.m
//  Exercise
//
//  Created by raidu on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LinksViewController.h"
#import "ExerciseAppDelegate.h"
#import   "TouchSQL.h"
@implementation LinksViewController

@synthesize linksViewLinkTable;
@synthesize linksViewPushBackBtn;
@synthesize linksViewEmailBtn;
@synthesize linksData;
@synthesize linksTitle;





-(IBAction)pushGoBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
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
- (void)viewWillAppear:(BOOL)animated {

    if([linkArray count]>0)
		
	{
		[linkArray removeAllObjects];
	}
	
	
	[self SelectData];
	//[linkArray addObjectsFromArray:[self SelectData]];
	
}


-(IBAction)EmailBtnPressed:(id)sender
{
    NSMutableString *linkstr=[[NSMutableString alloc] init];
	linksTitle=@"Link for Exercise App";
    NSLog(@"%d",[linkArray count]);
    for(int i=0;i<[linkArray count];i++)
    {
        linksData =[NSString stringWithFormat:
                    @"<b>%@</b><br>",[[linkArray objectAtIndex:i] objectForKey:@"links"]];
        [linkstr appendString:linksData];
    }
	
	
	[app sendingMail:linksTitle gettingBody:linkstr];
}

-(NSArray *)SelectData
{
	CSqliteDatabase *db = [[CSqliteDatabase alloc] initWithPath:[APPDELEGATE databasePath]];
	
	[db open:NULL];
	NSString *Query = [NSString stringWithFormat:@"select * from Links"];
	
	NSArray *rows = [db rowsForExpression:Query error:nil];
	
	NSLog(@"rows: %@",rows);
	[linkArray addObjectsFromArray:rows];
	[linksViewLinkTable reloadData];
	
	return rows;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    linkArray=[[NSMutableArray alloc] init];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [linkArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text=[[linkArray objectAtIndex:indexPath.row] objectForKey:@"links"];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
}


@end
