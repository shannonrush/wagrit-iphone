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


@implementation WagrDetailViewController

@synthesize selectedWagr;
@synthesize participants, description, reward;

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
	self.title = [self.selectedWagr valueForKeyPath:@"description"];	
    description.text = [self.selectedWagr valueForKeyPath:@"description"];
	reward.text = [NSString stringWithFormat:@"The winner gets %@!", [self.selectedWagr valueForKeyPath:@"reward"]];
	participants.backgroundColor = [UIColor clearColor];
}

// Participant table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.selectedWagr objectForKey:@"participants"] count];
}


// Customize the appearance of table view cells.
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
	[[cell cellMain] setText:[NSString stringWithFormat:@"Tap if %@ was right!", [participant valueForKeyPath:@"user_name"]]];
	[[cell cellDetails] setText:[NSString stringWithFormat:@"%@ guesses %@", [participant valueForKeyPath:@"user_name"], [participant valueForKeyPath:@"guess"]]];

	 return cell;
	//customCell.textLabel.text = 	[NSString stringWithFormat:@"Tap if %@ was right!", [[[self.selectedWagr objectForKey:@"participants"] objectAtIndex:[indexPath row]] valueForKeyPath:@"user_name"]];
	//customCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ guesses %@", [[[self.selectedWagr objectForKey:@"participants"] objectAtIndex:[indexPath row]] valueForKeyPath:@"user_name"], [[[self.selectedWagr objectForKey:@"participants"] objectAtIndex:[indexPath row]] valueForKeyPath:@"guess"]];
	//return customCell;
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
