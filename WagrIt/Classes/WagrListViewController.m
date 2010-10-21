//
//  WagrListViewController.m
//  WagrIt
//
//  Created by Shannon Rush on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WagrListViewController.h"
#import "WagrDetailViewController.h"


@implementation WagrListViewController


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (WagrListViewController *) init {
	if (self == [super init]) self.title = @"Wagrs";
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	// get data for table
	NSURL *url = [NSURL URLWithString:@"http://localhost:3000/wagers.json"]; 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableData *responseData;
    //NSString *dataString=[NSString stringWithFormat:@"login=%@&password=%@",loginField.text, passwordField.text]; 
    
    //[request setHTTPBody:[dataString dataUsingEncoding:NSISOLatin1StringEncoding]];
    [request setHTTPMethod:@"GET"]; 
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
    NSDictionary *wagrs;
    if(connection) { 
        NSError *WSerror; 
        NSURLResponse *WSresponse; 
        responseData = [[NSMutableData alloc ] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&WSresponse error:&WSerror]]; 
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        wagrs = [responseString JSONValue];
		//    NSLog(@"Dictionary value for \"success\" is \"%@\"", [dictionary objectForKey:@"success"]);
        NSLog(@"%@",responseString);
	}
    return [wagrs count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// get data for table
	NSURL *url = [NSURL URLWithString:@"http://localhost:3000/wagers.json"]; 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableData *responseData;
	[request setHTTPMethod:@"GET"]; 
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
    NSDictionary *wagrs;
    if(connection) { 
        NSError *WSerror; 
        NSURLResponse *WSresponse; 
        responseData = [[NSMutableData alloc ] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&WSresponse error:&WSerror]]; 
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        wagrs = [responseString JSONValue];
        NSLog(@"%@",responseString);	
	}
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	cell.textLabel.text = [[wagrs objectAtIndex:[indexPath row]] valueForKeyPath:@"wager.description"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"In didSelectRowAtIndexPath");
    // Navigation logic may go here. Create and push another view controller.
	
	 WagrDetailViewController *wagrDetail = [[WagrDetailViewController alloc] initWithNibName:@"WagrDetailViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:wagrDetail animated:YES];
	 [wagrDetail release];
	 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

