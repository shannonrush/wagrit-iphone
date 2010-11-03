//
//  SignupViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SignupViewController.h"
#import "WagrItAppDelegate.h"

@implementation SignupViewController

@synthesize firstNameField;
@synthesize lastNameField;
@synthesize emailField;
@synthesize timeZoneField;
@synthesize passwordField;
@synthesize passwordConfirmationField;
@synthesize timeZonePicker;
@synthesize timeZones;

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
	[self getTimeZones];
}

-(IBAction)pickTimeZone:(id)sender {
	[self.view bringSubviewToFront:timeZonePicker];
	timeZonePicker.hidden = NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {	
	return [timeZones count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {	
	return [NSString stringWithFormat:@"%@", [[timeZones objectAtIndex:row] valueForKey:@"name"]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	timeZonePicker.hidden = YES;
	timeZoneField.text = [[timeZones objectAtIndex:row] valueForKey:@"name"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theField {
	[theField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if (textField==timeZoneField) {
		[self.view endEditing:YES];
		[self pickTimeZone:nil];
		return NO;
	} else {
		return YES;
	}
}

-(void)getTimeZones {
	NSString *urlString=[NSString stringWithFormat:@"wagers/get_timezones.json"];
	[self asynchRequest:urlString withMethod:@"GET" withContentType:@"application/x-www-form-urlencoded" withData:nil];
}

-(IBAction)signup:(id)sender {
	NSString *escaped = [timeZoneField.text stringWithPercentEscape];
	NSString *dataString=[NSString stringWithFormat:@"[user]first_name=%@&[user]last_name=%@&[user]email=%@&[user]timezone=%@&[user]password=%@&[user]password_confirmation=%@",
						  firstNameField.text, 
						  lastNameField.text,
						  emailField.text,
						  escaped,
						  passwordField.text,
						  passwordConfirmationField.text];
	[self asynchRequest:@"users/signup_user.json" withMethod:@"PUT" withContentType:@"application/x-www-form-urlencoded" withData:dataString];
}

-(void)handleAsynchResponse:(NSDictionary *)data {
	if (!CFBooleanGetValue([data objectForKey:@"success"])) {
		[self errorAlert:[data objectForKey:@"errors"]];
	} else {
		if ([[data valueForKey:@"method"] isEqualToString:@"get_timezones"]) {
			timeZones = [[NSArray alloc] initWithArray:[data objectForKey:@"timezones"]];
			[timeZonePicker reloadAllComponents];
		} else if (([[data valueForKey:@"method"] isEqualToString:@"signup_user"])) {
			NSLog(@"hooray!");
		}
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
    [super dealloc];
}

@end


