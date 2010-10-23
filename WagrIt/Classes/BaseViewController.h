//
//  BaseViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController {
	NSArray *wagrs;

}

-(NSArray *)collectWagrs;

@end
