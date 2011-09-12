//
//  SplashScreen.h
//  BasicSplashScreen
//
//  Created by Jean Paul Salas Poveda on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashScreenDelegate.h"

@interface SplashScreen : UIViewController
{}
@property (nonatomic,retain) UIImage *splashImage;
@property (nonatomic,assign) BOOL showsStatusBarOnDismissal;
@property (nonatomic,assign) id<SplashScreenDelegate> delegate;

@end