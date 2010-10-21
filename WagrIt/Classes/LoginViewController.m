//
//  LoginViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "WagrListViewController.h"


@implementation LoginViewController

@synthesize loginField;
@synthesize passwordField;

- (IBAction)loginUser:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/session.json"]; 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableData *responseData;
    NSString *dataString=[NSString stringWithFormat:@"login=%@&password=%@",loginField.text, passwordField.text]; 
    
    [request setHTTPBody:[dataString dataUsingEncoding:NSISOLatin1StringEncoding]];
    [request setHTTPMethod:@"POST"]; 
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
    
    if(connection) { 
        NSError *WSerror; 
        NSURLResponse *WSresponse; 
        responseData = [[NSMutableData alloc ] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&WSresponse error:&WSerror]]; 
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSDictionary *dictionary = [responseString JSONValue];
        NSLog(@"Dictionary value for \"success\" is \"%@\"", [dictionary objectForKey:@"success"]);
        NSLog(@"%@",responseString);
		
		// root VC for nav
		WagrListViewController*  rootVC = [[WagrListViewController alloc] init];
		
		// Create the nav controller and add the view controllers.
		UINavigationController*  navController = [[UINavigationController alloc] initWithRootViewController:rootVC];
		
		// Display the nav controller modally.
		[self presentModalViewController:navController animated:YES];
		
		// Release the view controllers to prevent over-retention.
		
		[rootVC release];	
		[navController release];
        [responseString release];
		
    } 
    [connection release];
    [responseData release];
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

- (BOOL)textFieldShouldReturn:(UITextField *)theField {
	[theField resignFirstResponder];
	return YES;
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
	//[loginField release];
	//[passwordField release];
    [super dealloc];
}


@end
