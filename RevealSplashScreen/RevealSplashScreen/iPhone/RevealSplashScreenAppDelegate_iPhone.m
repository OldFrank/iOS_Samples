//
//  RevealSplashScreenAppDelegate_iPhone.m
//  RevealSplashScreen
//
//  Created by Jean Paul Salas Poveda on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RevealSplashScreenAppDelegate_iPhone.h"
#import "SplashScreen_iPhone.h"

@implementation RevealSplashScreenAppDelegate_iPhone

@synthesize splashController;

- (void)addSplashScreen 
{	
    splashController = [[SplashScreen_iPhone alloc] init];
	splashController.delegate = self;
	splashController.transition = ClearFromLeft;
	splashController.delay = 1.0;
    [splashController showInWindow:self.window];	
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    UIViewController *viewController = [[UIViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window addSubview:navController.view];
    [navController  release];
    [viewController release];
    
	[self addSplashScreen];
	
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)splashScreenDidAppear:(SplashScreen_iPhone *)splashScreen
{
    NSLog(@"splashScreenDidAppear");
}

- (void)splashScreenWillDisappear:(SplashScreen_iPhone *)splashScreen
{
    NSLog(@"splashScreenWillDisappear");    
}

- (void)splashScreenDidDisappear:(SplashScreen_iPhone *)splashScreen
{
    NSLog(@"splashScreenDidDisappear");
    
    // looping through the transitions for demostration
	// this should be a release of the splashscreenviewcontroller
	
	if (self.splashController.transition == ClearFromLeft) 
		self.splashController.transition = ClearFromRight;
	else if (self.splashController.transition == ClearFromRight) 
		self.splashController.transition = ClearFromTop;
	else if (self.splashController.transition == ClearFromTop) 
		self.splashController.transition = ClearFromBottom;
	else if (self.splashController.transition == ClearFromBottom) 
		self.splashController.transition = ClearFromCenter;	
	else if (self.splashController.transition == ClearFromCenter) 
		self.splashController.transition = CircleFromCenter;
	else if (self.splashController.transition == CircleFromCenter) 
		self.splashController.transition = ClearFromLeft;
	
    [self.splashController showInWindow:self.window];	
}

@end