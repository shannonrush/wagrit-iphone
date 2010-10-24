//
//  WagrDetailViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 10/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WagrDetailViewController.h"
#import "BaseViewController.h"


@implementation WagrDetailViewController

@synthesize selectedWagr;
@synthesize description, reward;

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
	if ([[self.selectedWagr valueForKeyPath:@"wagered_amount"] isKindOfClass:[NSNull class]]) {
		reward.text = [NSString stringWithFormat:@"The winner gets %@", [self.selectedWagr valueForKeyPath:@"wagered_description"]];
	} else {
		reward.text = [NSString stringWithFormat:@"The winner gets $%1.2f", [[self.selectedWagr valueForKeyPath:@"wagered_amount"] floatValue]];
	}
	// collect participants
	NSURL *url = [NSURL URLWithString:@"http://localhost:3000/wagers/get_participants.json"]; 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSMutableData *responseData;
    NSString *dataString=[NSString stringWithFormat:@"wager_id=%@",@"1"]; 
	[request setHTTPBody:[dataString dataUsingEncoding:NSISOLatin1StringEncoding]];
    [request setHTTPMethod:@"POST"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
	
	NSError *WSerror; 
	NSURLResponse *WSresponse; 
	responseData = [[NSMutableData alloc ] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&WSresponse error:&WSerror]]; 
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"%@",responseString);
	participants = [responseString JSONValue];
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
