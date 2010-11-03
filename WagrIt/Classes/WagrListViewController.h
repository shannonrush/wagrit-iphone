//
//  WagrListViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class WagrDetailViewController;

@interface WagrListViewController : BaseViewController {
	NSDictionary *selectedWagr;
	NSArray *wagrs;
	UITableView *tableView;
	UIActivityIndicatorView *refreshActivity;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *refreshActivity;
-(void)refreshWagrs;

@end
