//
//  AddWagrViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 11/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#define SCROLLVIEW_CONTENT_HEIGHT 460
#define SCROLLVIEW_CONTENT_WIDTH  320

#import "AddWagrViewController.h"
#import "WagrItAppDelegate.h"

@implementation AddWagrViewController

@synthesize descriptionField;
@synthesize rewardField;
@synthesize guessField;
@synthesize datePicker;
@synthesize friendDatePicker;
@synthesize firstNameField;
@synthesize lastNameField;
@synthesize emailField;
@synthesize chooseButton;
@synthesize friendPicker;
@synthesize friendGuessField;
@synthesize addButton;
@synthesize addActivity;
@synthesize submitButton;
@synthesize submitActivity;
@synthesize friendsTable;
@synthesize friends;
@synthesize years;
@synthesize months;
@synthesize dateButton;
@synthesize friendDateButton;
@synthesize dateAction;
@synthesize friendDateAction;
@synthesize closeButton;
@synthesize guessDate;
@synthesize friendGuessDate;
@synthesize friendAction;
@synthesize chosenFriend;
@synthesize scrollview;

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
	self.title = @"New Wagr";
	submitActivity.hidden = YES;
	addActivity.hidden = YES;
	friendAction.hidden = YES;
	dateAction.hidden = YES;
	friendDateAction.hidden = YES;
	if ([[WagrItAppDelegate existingFriends]count]<1) {
		chooseButton.hidden = YES;
	}
	friendsTable.backgroundColor = [UIColor clearColor];
	friends = [[NSMutableArray alloc]init];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
	guessDate = [[NSDictionary alloc]initWithObjectsAndKeys:
										[NSString stringWithFormat:@"%d",[components year]],@"year",
										[NSString stringWithFormat:@"%d",[components month]],@"month",
										[NSString stringWithFormat:@"%d",[components day]],@"day",
										[NSString stringWithFormat:@"%d",[components hour]],@"hour",
										[NSString stringWithFormat:@"%d",[components minute]],@"minute",nil];
	friendGuessDate = [[NSDictionary alloc]initWithDictionary:guessDate];
	years = [[NSArray alloc]initWithObjects:@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",nil];
	months = [[NSArray alloc]initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec",nil];
}

#pragma mark -
#pragma mark Table view data source

//- (WagrListViewController *) init {
//	if (self == [super init]) 
//	return self;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friends count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.00; 
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	NSDictionary *friend = [friends objectAtIndex:[indexPath row]];
	cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
	if ([[friend valueForKey:@"guess"] isEqualToString:@""]) {
		cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ (We'll ask %@ for a guess)",[friend valueForKey:@"first_name"],[friend valueForKey:@"last_name"],[friend valueForKey:@"first_name"]];
	} else {
		cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ guesses %@",[friend valueForKey:@"first_name"],[friend valueForKey:@"last_name"],[friend valueForKey:@"guess"]];
	}
	return cell;
}

#pragma mark -
#pragma mark picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	if (pickerView==datePicker || pickerView==friendDatePicker) {
		return 5;
	} else if (pickerView==friendPicker) {
		return 1;
	}
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {	
	if (pickerView==datePicker || pickerView==friendDatePicker) {
		switch (component) {
			case 0:
				return 12;
				break;
			case 1:
				return 31;
				break;
			case 2:
				return 10;
				break;
			case 3:
				return 24;		
				break;
			case 4:
				return 60;
				break;
			default:
				break;
		}
	}  else if (pickerView==friendPicker) {
		return [[WagrItAppDelegate existingFriends] count];
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {	
	if (pickerView==datePicker || pickerView==friendDatePicker) {
		switch (component) {
			case 0:
				return [months objectAtIndex:row];
				break;
			case 1:
				return [NSString stringWithFormat:@"%d",row+1];
				break;
			case 2:
				return [years objectAtIndex:row];
				break;
			case 3:
				return [NSString stringWithFormat:@"%d:",row+1];
				break;
			case 4:
				if (row < 10) {
					return [NSString stringWithFormat:@"0%d",row];
				} else {
					return [NSString stringWithFormat:@"%d",row];
				}
				break;
			default:
				break;
		}
	} else if (pickerView==friendPicker) {
		NSDictionary *friend = [[WagrItAppDelegate existingFriends] objectAtIndex:row];
		return [NSString stringWithFormat:@"%@ %@",[friend valueForKey:@"first_name"],[friend valueForKey:@"last_name"]];
	}
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (pickerView==datePicker) {
		switch (component) {
			case 0:
				[guessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"month"];
				break;
			case 1:
				[guessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"day"];
				break;
			case 2:
				[guessDate setValue:[years objectAtIndex:row] forKey:@"year"];
				break;
			case 3:
				[guessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"hour"];
				break;
			case 4:
				[guessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"minute"];
				break;
			default:
				break;
		}
	} else if (pickerView==friendDatePicker) {
		switch (component) {
			case 0:
				[friendGuessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"month"];
				break;
			case 1:
				[friendGuessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"day"];
				break;
			case 2:
				[friendGuessDate setValue:[years objectAtIndex:row] forKey:@"year"];
				break;
			case 3:
				[friendGuessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"hour"];
				break;
			case 4:
				[friendGuessDate setValue:[NSString stringWithFormat:@"%d", row] forKey:@"minute"];
				break;
			default:
				break;
		}
	} else if (pickerView==friendPicker) {
		chosenFriend = [[NSDictionary alloc]initWithDictionary:[[WagrItAppDelegate existingFriends] objectAtIndex:row]];
	}
}


-(IBAction)pickDate:(id)sender {
	[self initDatePicker:datePicker withActionSheet:dateAction];
}

-(IBAction)dateSelected:(id)sender {
	dateAction.hidden = YES;
	guessField.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",
					   [guessDate valueForKey:@"month"],
					   [guessDate valueForKey:@"day"],
					   [guessDate valueForKey:@"year"],
					   [guessDate valueForKey:@"hour"],
					   [guessDate valueForKey:@"minute"]];
}

-(IBAction)pickFriendDate:(id)sender {
	[self initDatePicker:friendDatePicker withActionSheet:friendDateAction];
}

-(IBAction)friendDateSelected:(id)sender {
	friendDateAction.hidden = YES;
	friendGuessField.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",
					   [friendGuessDate valueForKey:@"month"],
					   [friendGuessDate valueForKey:@"day"],
					   [friendGuessDate valueForKey:@"year"],
					   [friendGuessDate valueForKey:@"hour"],
					   [friendGuessDate valueForKey:@"minute"]];
}

-(void)initDatePicker:(UIPickerView *)pickerView withActionSheet:(UIActionSheet *)actionSheet {
	[self resetView];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
	[pickerView selectRow:[components month]-1 inComponent:0 animated:NO];
	[pickerView selectRow:[components day]-1 inComponent:1 animated:NO];
	[pickerView selectRow:[components hour]-1 inComponent:3 animated:NO];
	[pickerView selectRow:[components minute] inComponent:4 animated:NO];
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
	closeButton.momentary = YES; 
	closeButton.frame = CGRectMake(250, 7.0f, 60.0f, 35.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor colorWithRed:99.0f/255.0f green:173.0f/255.0f blue:208.0f/255.0f alpha:1.0];
	if (pickerView==datePicker) {
		[closeButton addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
	} else {
		[closeButton addTarget:self action:@selector(friendDateSelected:) forControlEvents:UIControlEventValueChanged];
	}
	[actionSheet addSubview:closeButton];
	[actionSheet addSubview:pickerView];
	[closeButton release];
	[self.view bringSubviewToFront:actionSheet];
	actionSheet.hidden = NO;
}

-(IBAction)pickFriend:(id)sender {
	[self resetView];
	chosenFriend = [[NSDictionary alloc]initWithDictionary:[[WagrItAppDelegate existingFriends] objectAtIndex:0]];
	[friendAction setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Choose"]];
	closeButton.momentary = YES; 
	closeButton.frame = CGRectMake(250, 7.0f, 60.0f, 35.0f);
	closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
	closeButton.tintColor = [UIColor colorWithRed:99.0f/255.0f green:173.0f/255.0f blue:208.0f/255.0f alpha:1.0];
	[closeButton addTarget:self action:@selector(friendSelected:) forControlEvents:UIControlEventValueChanged];
	[friendAction addSubview:closeButton];
	[friendAction addSubview:friendPicker];
	[closeButton release];
	[self.view bringSubviewToFront:friendAction];
	friendAction.hidden = NO;
}

-(IBAction)friendSelected:(id)sender {
	friendAction.hidden = YES;
	firstNameField.text = [chosenFriend valueForKey:@"first_name"];
	lastNameField.text = [chosenFriend valueForKey:@"last_name"];
	emailField.text = [chosenFriend valueForKey:@"email"];
}

-(IBAction)addWagrer:(id)sender {
	NSDictionary *newFriend = [NSDictionary dictionaryWithObjectsAndKeys:firstNameField.text,@"first_name",
							   lastNameField.text,@"last_name",
							   emailField.text,@"email",
							   friendGuessField.text,@"guess",
							   nil];
	[friends addObject:newFriend];
	firstNameField.text = @"";
	lastNameField.text = @"";
	emailField.text = @"";
	friendGuessField.text = @"";
	[friendsTable reloadData];
}

-(IBAction)submitWagr:(id)sender {

}

-(void)resetView {
	friendAction.hidden = YES;
	dateAction.hidden = YES;
	friendDateAction.hidden = YES;
	[self.view endEditing:YES];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"Registering for keyboard events");
	
	// Register for the events
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector (keyboardDidShow:)
	 name: UIKeyboardDidShowNotification
	 object:nil];
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector (keyboardDidHide:)
	 name: UIKeyboardDidHideNotification
	 object:nil];
	
	// Setup content size
	scrollview.contentSize = CGSizeMake(SCROLLVIEW_CONTENT_WIDTH,
										SCROLLVIEW_CONTENT_HEIGHT);
	
	//Initially the keyboard is hidden
	keyboardVisible = NO;
}

-(void) viewWillDisappear:(BOOL)animated {
	NSLog (@"Unregister for keyboard events");
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self];
}

-(void) keyboardDidShow: (NSNotification *)notif {
	NSLog(@"Keyboard is visible");
	// If keyboard is visible, return
	if (keyboardVisible) {
		NSLog(@"Keyboard is already visible. Ignore notification.");
		return;
	}
	
	// Get the size of the keyboard.
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	// Save the current location so we can restore
	// when keyboard is dismissed
	offset = scrollview.contentOffset;
	
	// Resize the scroll view to make room for the keyboard
	CGRect viewFrame = scrollview.frame;
	viewFrame.size.height -= keyboardSize.height;
	scrollview.frame = viewFrame;
	
	CGRect textFieldRect = [activeField frame];
	textFieldRect.origin.y += 10;
	[scrollview scrollRectToVisible:textFieldRect animated:YES];
	
	NSLog(@"ao fim");
	// Keyboard is now visible
	keyboardVisible = YES;
}
-(void) keyboardDidHide: (NSNotification *)notif {
	// Is the keyboard already shown
	if (!keyboardVisible) {
		NSLog(@"Keyboard is already hidden. Ignore notification.");
		return;
	}
	
	// Reset the frame scroll view to its original value
	scrollview.frame = CGRectMake(0, 0, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
	
	// Reset the scrollview to previous location
	scrollview.contentOffset = offset;
	
	// Keyboard is no longer visible
	keyboardVisible = NO;
	
}

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
	activeField = textField;
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
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
	[chosenFriend release];
	[friends release];
    [super dealloc];
}


@end
