//
//  WagrDetailViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 10/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WagrDetailViewController : UIViewController {
	NSDictionary *selectedWagr;
	UILabel *description;
	UILabel *reward;
	UITableView *participants;
}

@property (nonatomic, retain) NSDictionary *selectedWagr;
@property (nonatomic, retain) IBOutlet UILabel *description;
@property (nonatomic, retain) IBOutlet UILabel *reward;
@property (nonatomic, retain) IBOutlet UITableView *participants;

@end
