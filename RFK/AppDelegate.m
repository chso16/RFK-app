//
//  AppDelegate.m
//  RFK
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"sky"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    
    NSDictionary *appDefaultsa = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"sky2"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaultsa];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}
- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
