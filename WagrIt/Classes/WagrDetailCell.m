//
//  WagrDetailCell.m
//  WagrIt
//
//  Created by Shannon Rush on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WagrDetailCell.h"


@implementation WagrDetailCell
@synthesize cellMain, cellDetails;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
