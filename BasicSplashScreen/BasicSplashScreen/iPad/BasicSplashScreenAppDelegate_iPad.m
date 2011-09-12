//
//  BasicSplashScreenAppDelegate_iPad.m
//  BasicSplashScreen
//
//  Created by Jean Paul Salas Poveda on 11/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicSplashScreenAppDelegate_iPad.h"
#import "iPadViewController.h"
#import "SplashScreen_iPad.h"

@implementation BasicSplashScreenAppDelegate_iPad

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    SplashScreen_iPad *splashScreen = [[SplashScreen_iPad alloc] init];
    splashScreen.delegate = self;
    splashScreen.showsStatusBarOnDismissal = YES;
    splashScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIImage *splash = [UIImage imageNamed:@"splash_background_ipad.png"]; 
    splashScreen.splashImage = splash;
    
    iPadViewController *viewController = [[iPadViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window addSubview:navController.view];
    [navController presentModalViewController:splashScreen animated:NO];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)splashScreenDidAppear:(SplashScreen*)splashScreen
{
    NSLog(@"splashScreenDidAppear");
}

- (void)splashScreenWillDisappear:(SplashScreen*)splashScreen
{
    NSLog(@"splashScreenWillDisappear");    
}

- (void)splashScreenDidDisappear:(SplashScreen*)splashScreen
{
    NSLog(@"splashScreenDidDisappear");        
}

@end
