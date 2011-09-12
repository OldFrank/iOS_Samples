//
//  SplashScreen_iPhone.h
//  RevealSplashScreen
//
//  Created by Jean Paul Salas Poveda on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {	
    CircleFromCenter,
	ClearFromCenter,
	ClearFromLeft, 
	ClearFromRight, 
	ClearFromTop, 
	ClearFromBottom, 
} TransitionDirection;

#define DURATION 0.75

@protocol SplashScreenDelegate;

@interface SplashScreen_iPhone : UIViewController

@property (nonatomic, retain) UIImage *splashImage;
@property (nonatomic, retain) UIImage *maskImage;
@property (nonatomic, assign) id <SplashScreenDelegate> delegate;
@property (nonatomic, retain) NSString *maskImageName;
@property (nonatomic) TransitionDirection transition;
@property (nonatomic) CGFloat delay;
@property (nonatomic) CGPoint anchor;

- (void)showInWindow:(UIWindow *)window;

@end
