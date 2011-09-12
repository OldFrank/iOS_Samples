//
//  RevealSplashScreenAppDelegate_iPhone.h
//  RevealSplashScreen
//
//  Created by Jean Paul Salas Poveda on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RevealSplashScreenAppDelegate.h"
#import "SplashScreenDelegate.h"

@interface RevealSplashScreenAppDelegate_iPhone : RevealSplashScreenAppDelegate <SplashScreenDelegate>

@property (nonatomic, retain) SplashScreen_iPhone *splashController;

@end
