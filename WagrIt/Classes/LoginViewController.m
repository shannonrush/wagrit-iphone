//
//  LoginViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "WagrListViewController.h"
#import	"WagrItAppDelegate.h"
#import "SignupViewController.h"


@implementation LoginViewController

@synthesize loginField;
@synthesize passwordField;
@synthesize loginActivity;
@synthesize loginButton;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.view.frame = [[UIScreen mainScreen] applicationFrame];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	loginActivity.hidden = YES;
}


- (IBAction)loginUser:(id)sender {
	loginButton.hidden = YES;
	loginActivity.hidden = NO;
    NSString *dataString=[NSString stringWithFormat:@"login=%@&password=%@",loginField.text, passwordField.text];
	[self asynchRequest:@"session.json" withMethod:@"POST" withContentType:@"application/x-www-form-urlencoded" withData:dataString];		
}

-(void) handleAsynchResponse:(NSDictionary *)data{
	if (CFBooleanGetValue([data objectForKey:@"success"])) {
		[WagrItAppDelegate setToken:[[NSString alloc] initWithString:[data objectForKey:@"token"]]];
		WagrListViewController*  rootVC = [[WagrListViewController alloc] init];	
		UINavigationController*  navController = [[UINavigationController alloc] initWithRootViewController:rootVC];
		[self presentModalViewController:navController animated:YES];	
		[rootVC release];	
		[navController release];
		[responseData release];
		
	} else {
		[loginField setText:@""];
		[passwordField setText:@""];
	}
}

-(IBAction)signup:(id)sender {
	SignupViewController*  signupView = [[SignupViewController alloc] init];	
	[self presentModalViewController:signupView animated:YES];	
	[signupView release];	
}
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
