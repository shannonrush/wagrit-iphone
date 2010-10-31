//
//  WagrDetailViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 10/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WagrDetailViewController.h"
#import "BaseViewController.h"
#import "WagrDetailCell.h"
#import	"WagrItAppDelegate.h"


@implementation WagrDetailViewController

@synthesize selectedWagr;
@synthesize participants, description, reward, markComplete;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = [self.selectedWagr valueForKey:@"description"];	
    description.text = [self.selectedWagr valueForKey:@"description"];
	participants.backgroundColor = [UIColor clearColor];
	if (CFBooleanGetValue([self.selectedWagr valueForKey:@"complete"])) {
		[self setCompleteConditions];
	} else {
		reward.text = [NSString stringWithFormat:@"The winner gets %@!", [self.selectedWagr valueForKey:@"reward"]];
	}
}

-(void)setCompleteConditions {
	markComplete.hidden = YES;
	reward.text = @"This Wagr Has Ended";
	participants.allowsSelection = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.selectedWagr objectForKey:@"participants"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"customCell";
	WagrDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"WagrDetailCell" owner:nil options:nil];
		for (id currentObject in nibObjects) {
			if ([currentObject isKindOfClass:[WagrDetailCell class]]) {
				cell = (WagrDetailCell *)currentObject;
			}
		}
	}
	NSDictionary *participant = [[self.selectedWagr objectForKey:@"participants"]objectAtIndex:[indexPath row]];
	if (CFBooleanGetValue([participant objectForKey:@"won_wager"])) {
		[[cell cellMain] setText:[NSString stringWithFormat:@"%@ won!", [participant valueForKeyPath:@"user_name"]]];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		if (!CFBooleanGetValue([self.selectedWagr valueForKey:@"complete"])) {
			[[cell cellMain] setText:[NSString stringWithFormat:@"Tap if %@ was right!", [participant valueForKeyPath:@"user_name"]]];
		} else {
			[[cell cellMain] setText:[NSString stringWithFormat:@"%@ did not win", [participant valueForKeyPath:@"user_name"]]];
		}
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	[[cell cellDetails] setText:[NSString stringWithFormat:@"%@ guessed %@", [participant valueForKeyPath:@"user_name"], [participant valueForKeyPath:@"guess"]]];
	 return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (!CFBooleanGetValue([self.selectedWagr valueForKey:@"complete"])) {
		NSDictionary *participant = [[self.selectedWagr objectForKey:@"participants"] objectAtIndex:[indexPath row]];
		NSNumber *status = [NSNumber numberWithBool:!CFBooleanGetValue([participant objectForKey:@"won_wager"])];
		NSString *dataString=[NSString stringWithFormat:@"wager_participant[won_wager]=%@&authenticity_token=%@", status, [WagrItAppDelegate token]];
		NSString *urlString=[NSString stringWithFormat:@"wager_participants/%@.json",[participant valueForKey:@"id"]];
		[self asynchRequest:urlString withMethod:@"PUT" withContentType:@"application/x-www-form-urlencoded" withData:dataString];
	}
}	

-(IBAction)markComplete:(id)sender {
	NSString *dataString=[NSString stringWithFormat:@"wager_id=%@&authenticity_token=%@", [self.selectedWagr valueForKey:@"id"], [WagrItAppDelegate token]];
	NSString *urlString=[NSString stringWithFormat:@"wagers/mark_complete.json"];
	[self asynchRequest:urlString withMethod:@"PUT" withContentType:@"application/x-www-form-urlencoded" withData:dataString];
}

-(void)handleAsynchResponse:(NSDictionary *)data {
	if (!CFBooleanGetValue([data objectForKey:@"success"])) {
		[self errorAlert:[data objectForKey:@"errors"]];
	} else {
		if ([[data valueForKey:@"method"] isEqualToString:@"won_wager"]) {
			NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", @"id", [data valueForKey:@"id"]];
			NSDictionary *participant = [[[self.selectedWagr objectForKey:@"participants"] filteredArrayUsingPredicate:pred] objectAtIndex:0];
			NSNumber *status = [NSNumber numberWithBool:!CFBooleanGetValue([participant objectForKey:@"won_wager"])];
			[participant setValue:status forKey:@"won_wager"];
			[participants reloadData];
			if (CFBooleanGetValue(status)) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Won!", [participant valueForKey:@"user_name"]] message:@"Is this wagr over now?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No",nil];
				[alert show];
				[alert release];
			}
			} else if ([[data valueForKey:@"method"] isEqualToString:@"mark_complete"]) {
			[self.selectedWagr setValue:[NSNumber numberWithBool:YES] forKey:@"complete"];
			[self setCompleteConditions];
			[participants reloadData];
		}
	}

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			[self markComplete:nil];
			break;
		default:
			break;
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
	[description release];
	[selectedWagr release];
    [super dealloc];
}


@end
