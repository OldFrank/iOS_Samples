//
//  BasicSplashScreenAppDelegate_iPhone.m
//  BasicSplashScreen
//
//  Created by Jean Paul Salas Poveda on 11/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicSplashScreenAppDelegate_iPhone.h"

@implementation BasicSplashScreenAppDelegate_iPhone

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    SplashScreen *splashScreen = [[SplashScreen alloc] init];
    splashScreen.delegate = self;
    splashScreen.showsStatusBarOnDismissal = YES;
    splashScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    /*UIViewController *viewController = [[UIViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window addSubview:navController.view];
    [navController presentModalViewController:splashScreen animated:NO];*/

    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (int i=0; i<4; i++) 
    {
        UIViewController *viewController = [[UIViewController alloc] init];
        [viewControllers addObject:viewController];
        [viewController release];
    }
 
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = viewControllers;
    [self.window addSubview:tabBarController.view];
    [tabBarController presentModalViewController:splashScreen animated:NO];
    
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
