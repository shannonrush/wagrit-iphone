//
//  BaseViewController.h
//  WagrIt
//
//  Created by Shannon Rush on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController {
	NSMutableData *responseData;
}

-(void) noConnectionAlert;
-(NSURL *) constructURL:(NSString *)path;
-(void) collectWagrs;
-(void) asynchRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)data;
-(void) handleAsynchResponse:(NSDictionary *)data;

@end
