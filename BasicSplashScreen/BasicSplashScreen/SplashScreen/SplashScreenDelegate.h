//
//  SplashScreenDelegate.h
//  BasicSplashScreen
//
//  Created by Jean Paul Salas Poveda on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
@class SplashScreen;

@protocol SplashScreenDelegate <NSObject>

@optional
- (void)splashScreenDidAppear:(SplashScreen*)splashScreen;
- (void)splashScreenWillDisappear:(SplashScreen*)splashScreen; 
- (void)splashScreenDidDisappear:(SplashScreen*)splashScreen;

@end
