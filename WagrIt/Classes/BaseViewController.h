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

-(NSArray *) sendRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)data;
-(void) noConnectionAlert;
-(NSURL *) constructURL:(NSString *)path;
-(NSArray *)collectWagrs;
-(NSArray *)collectWagrParticipants:(NSString *)wagerId;

@end
