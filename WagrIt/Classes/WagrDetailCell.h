//
//  WagrDetailCell.h
//  WagrIt
//
//  Created by Shannon Rush on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WagrDetailCell : UITableViewCell {
	IBOutlet UILabel *cellMain;
	IBOutlet UILabel *cellDetails;
}

@property (nonatomic, retain) IBOutlet UILabel *cellMain;
@property (nonatomic, retain) IBOutlet UILabel *cellDetails;

@end
