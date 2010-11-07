//
//  AddWagrViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 11/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddWagrViewController : BaseViewController {
	UITextField *descriptionField;
	UITextField *rewardField;
	UITextField *guessField;
	UIPickerView *datePicker;
	UIPickerView *friendDatePicker;
	UITextField *firstNameField;
	UITextField *lastNameField;
	UITextField *emailField;
	UIButton *chooseButton;
	UIActionSheet *friendAction;
	UIPickerView *friendPicker;
	UITextField *friendGuessField;
	UIButton *addButton;
	UIActivityIndicatorView *addActivity;
	UIButton *submitButton;
	UIActivityIndicatorView *submitActivity;
	UITableView *friendsTable;
	NSMutableArray *friends;
	NSArray *years;
	NSArray *months;
	UIButton *dateButton;
	UIButton *friendDateButton;
	UIActionSheet *dateAction;
	UISegmentedControl *closeButton;
	NSDictionary *guessDate;
	NSDictionary *friendGuessDate;
	NSDictionary *chosenFriend;
	UIScrollView *scrollview;
	BOOL keyboardVisible;
	CGPoint offset;
	UITextField *activeField;
}

@property (nonatomic, retain) IBOutlet UITextField *descriptionField;
@property (nonatomic, retain) IBOutlet UITextField *rewardField;
@property (nonatomic, retain) IBOutlet UITextField *guessField;
@property (nonatomic, retain) IBOutlet UIPickerView *datePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *friendDatePicker;
@property (nonatomic, retain) IBOutlet UITextField *firstNameField;
@property (nonatomic, retain) IBOutlet UITextField *lastNameField;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UIButton *chooseButton;
@property (nonatomic, retain) IBOutlet UIPickerView *friendPicker;
@property (nonatomic, retain) IBOutlet UITextField *friendGuessField;
@property (nonatomic, retain) IBOutlet UIButton *addButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *addActivity;
@property (nonatomic, retain) IBOutlet UIButton *submitButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *submitActivity;
@property (nonatomic, retain) IBOutlet UITableView *friendsTable;
@property (nonatomic, retain) NSMutableArray *friends;
@property (nonatomic, retain) NSArray *years;
@property (nonatomic, retain) NSArray *months;
@property (nonatomic, retain) IBOutlet UIButton *dateButton;
@property (nonatomic, retain) IBOutlet UIButton *friendDateButton;
@property (nonatomic, retain) IBOutlet UIActionSheet *dateAction;
@property (nonatomic, retain) IBOutlet UIActionSheet *friendDateAction;
@property (nonatomic, retain) IBOutlet UISegmentedControl *closeButton;
@property (nonatomic, retain) IBOutlet NSDictionary *guessDate;
@property (nonatomic, retain) IBOutlet NSDictionary *friendGuessDate;
@property (nonatomic, retain) IBOutlet UIActionSheet *friendAction;
@property (nonatomic, retain) IBOutlet NSDictionary *chosenFriend;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollview;



-(IBAction)pickDate:(id)sender;
-(IBAction)pickFriendDate:(id)sender;
-(IBAction)dateSelected:(id)sender;
-(IBAction)friendDateSelected:(id)sender;
-(IBAction)pickFriend:(id)sender;
-(IBAction)friendSelected:(id)sender;
-(IBAction)addWagrer:(id)sender;
-(IBAction)submitWagr:(id)sender;
-(void)initDatePicker:(UIPickerView *)pickerView withActionSheet:(UIActionSheet *)actionSheet;
-(void)resetView;

@end
