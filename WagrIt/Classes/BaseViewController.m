    //
//  BaseViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "WagrItAppDelegate.h"


@implementation BaseViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(NSURL *) constructURL:(NSString *)path {
	WagrItAppDelegate *appDelegate = (WagrItAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *urlString=[NSString stringWithFormat:@"%@%@",appDelegate.baseDomain, path];
	return [NSURL URLWithString:urlString];
}

-(void) noConnectionAlert {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Connect" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

-(NSArray *) sendRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)dataString {
	NSURL *url = [self constructURL:path]; 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSMutableData *responseData;
	
	if (dataString != nil && [dataString length] > 0) {
		[request setHTTPBody:[dataString dataUsingEncoding:NSISOLatin1StringEncoding]];
	}
    [request setHTTPMethod:method];
	[request setValue:contentType forHTTPHeaderField:@"content-type"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
	
	NSError *WSerror; 
	NSURLResponse *WSresponse; 
	responseData = [[NSMutableData alloc ] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&WSresponse error:&WSerror]]; 
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	if([responseData length] == 0) {
		// No connection, show alert and return empty array
		[self noConnectionAlert];
		return [[NSArray alloc] init];
	} else {
		// Success!
		NSLog(@"%@",responseString);
		return [responseString JSONValue];
	}
}


-(NSArray *)collectWagrs {
	NSArray *array = [self sendRequest:@"wagers/get_wagers.json" withMethod:@"GET" withContentType:@"application/x-www-form-urlencoded" withData:nil];	
	return [[NSArray alloc] initWithArray:array];
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
