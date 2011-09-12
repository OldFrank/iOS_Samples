#import "SplashScreen_iPhone.h"

@protocol SplashScreenDelegate <NSObject>

@optional
- (void)splashScreenDidAppear:(SplashScreen_iPhone *)splashScreen;
- (void)splashScreenWillDisappear:(SplashScreen_iPhone *)splashScreen;
- (void)splashScreenDidDisappear:(SplashScreen_iPhone *)splashScreen;

@end