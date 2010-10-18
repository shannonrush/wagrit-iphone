//
//  WagrItAppDelegate.h
//  WagrIt
//
//  Created by Shannon Rush on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@interface WagrItAppDelegate : NSObject <UIApplicationDelegate> {
	LoginViewController *loginViewController;
    UIWindow *window;
}

@property (nonatomic, retain) LoginViewController *loginViewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

