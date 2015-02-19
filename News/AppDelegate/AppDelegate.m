//
//  AppDelegate.m
//  News
//
//  Created by Harish on 10/02/15.
//  Copyright (c) 2015 CTS. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Override point for customization after application launch.
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    MasterViewController *masterController = [[MasterViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc]  initWithRootViewController:masterController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    [masterController release];
    [navController release];
    return YES;
}

@end
