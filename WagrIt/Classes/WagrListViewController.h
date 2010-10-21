//
//  WagrListViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WagrDetailViewController;

@interface WagrListViewController : UITableViewController {
	NSDictionary *wagrs;
	NSDictionary *selectedWagr;
}


@end
