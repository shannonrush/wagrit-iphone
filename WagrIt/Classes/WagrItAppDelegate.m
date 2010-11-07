//
//  WagrItAppDelegate.m
//  WagrIt
//
//  Created by Shannon Rush on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WagrItAppDelegate.h"
#import "LoginViewController.h"

@implementation WagrItAppDelegate

@synthesize window;
@synthesize loginViewController;
@synthesize baseDomain;

#pragma mark -
#pragma mark Accessors

+(NSString *)token {
	return token;
}

+(void)setToken:(NSString *)auth_token {
	token = auth_token;
}

+(NSArray *)timezones {
	return timezones; 
}

+(NSMutableArray *)existingFriends {
	return existingFriends;
}

+(void)setExistingFriends:(NSMutableArray *)returnedFriends {
	existingFriends = returnedFriends;
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	token = [[NSString alloc]init];
	existingFriends = [[NSMutableArray alloc]init];
	timezones = [[NSArray alloc]initWithObjects:@"International Date Line West",
				 @"Midway Island",
				 @"Samoa",
				 @"Hawaii",
				 @"Alaska",
				 @"Pacific Time (US & Canada)",
				 @"Tijuana",
				 @"Arizona",
				 @"Chihuahua",
				 @"Mazatlan",
				 @"Mountain Time (US & Canada)",
				 @"Central America",
				 @"Central Time (US & Canada)",
				 @"Guadalajara",
				 @"Mexico City",
				 @"Monterrey",
				 @"Saskatchewan",
				 @"Bogota",
				 @"Eastern Time (US & Canada)",
				 @"Indiana (East)",
				 @"Lima",
				 @"Quito",
				 @"Caracas",
				 @"Atlantic Time (Canada)",
				 @"La Paz",
				 @"Santiago",
				 @"Newfoundland",
				 @"Brasilia",
				 @"Buenos Aires",
				 @"Georgetown",
				 @"Greenland",
				 @"Mid-Atlantic",
				 @"Azores",
				 @"Cape Verde Is.",
				 @"Casablanca",
				 @"Dublin",
				 @"Edinburgh",
				 @"Lisbon",
				 @"London",
				 @"Monrovia",
				 @"UTC",
				 @"Amsterdam",
				 @"Belgrade",
				 @"Berlin",
				 @"Bern",
				 @"Bratislava",
				 @"Brussels",
				 @"Budapest",
				 @"Copenhagen",
				 @"Ljubljana",
				 @"Madrid",
				 @"Paris",
				 @"Prague",
				 @"Rome",
				 @"Sarajevo",
				 @"Skopje",
				 @"Stockholm",
				 @"Vienna",
				 @"Warsaw",
				 @"West Central Africa",
				 @"Zagreb",
				 @"Athens",
				 @"Bucharest",
				 @"Cairo",
				 @"Harare",
				 @"Helsinki",
				 @"Istanbul",
				 @"Jerusalem",
				 @"Kyev",
				 @"Minsk",
				 @"Pretoria",
				 @"Riga",
				 @"Sofia",
				 @"Tallinn",
				 @"Vilnius",
				 @"Baghdad",
				 @"Kuwait",
				 @"Moscow",
				 @"Nairobi",
				 @"Riyadh",
				 @"St. Petersburg",
				 @"Volgograd",
				 @"Tehran",
				 @"Abu Dhabi",
				 @"Baku",
				 @"Muscat",
				 @"Tbilisi",
				 @"Yerevan",
				 @"Kabul",
				 @"Ekaterinburg",
				 @"Islamabad",
				 @"Karachi",
				 @"Tashkent",
				 @"Chennai",
				 @"Kolkata",
				 @"Mumbai",
				 @"New Delhi",
				 @"Sri Jayawardenepura",
				 @"Kathmandu",
				 @"Almaty",
				 @"Astana",
				 @"Dhaka",
				 @"Novosibirsk",
				 @"Rangoon",
				 @"Bangkok",
				 @"Hanoi",
				 @"Jakarta",
				 @"Krasnoyarsk",
				 @"Beijing",
				 @"Chongqing",
				 @"Hong Kong",
				 @"Irkutsk",
				 @"Kuala Lumpur",
				 @"Perth",
				 @"Singapore",
				 @"Taipei",
				 @"Ulaan Bataar",
				 @"Urumqi",
				 @"Osaka",
				 @"Sapporo",
				 @"Seoul",
				 @"Tokyo",
				 @"Yakutsk",
				 @"Adelaide",
				 @"Darwin",
				 @"Brisbane",
				 @"Canberra",
				 @"Guam",
				 @"Hobart",
				 @"Melbourne",
				 @"Port Moresby",
				 @"Sydney",
				 @"Vladivostok",
				 @"Magadan",
				 @"New Caledonia",
				 @"Solomon Is.",
				 @"Auckland",
				 @"Fiji",
				 @"Kamchatka",
				 @"Marshall Is.",
				 @"Wellington",
				 @"Nuku'alofa",
				 nil];
	LoginViewController *aViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
	[self setLoginViewController:aViewController];
	[aViewController release];
	UIView *controllersView = [loginViewController view];
	[window addSubview:controllersView];
	[window makeKeyAndVisible];
	[self setBaseDomain:@"http://localhost:3000/"];	//TODO - Set to production value

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[token release];
	[loginViewController release];
    [window release];
	[existingFriends release];
    [super dealloc];
}


@end
