//
//  WagrItAppDelegate.h
//  WagrIt
//
//  Created by Shannon Rush on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

NSString *token;

@interface WagrItAppDelegate : NSObject <UIApplicationDelegate> {
	LoginViewController *loginViewController;
    UIWindow *window;
	NSString *baseDomain;
}

@property (nonatomic, retain) LoginViewController *loginViewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSString *baseDomain;

+(NSString *)token;
+(void)setToken:(NSString *)auth_token;

@end

