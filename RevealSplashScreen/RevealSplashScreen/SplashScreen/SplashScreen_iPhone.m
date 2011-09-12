//
//  SplashScreen_iPhone.m
//  RevealSplashScreen
//
//  Created by Jean Paul Salas Poveda on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SplashScreen_iPhone.h"
#import "SplashScreenDelegate.h"

@implementation SplashScreen_iPhone

@synthesize splashImage;
@synthesize maskImage;
@synthesize delegate;
@synthesize transition;
@synthesize maskImageName;
@synthesize delay;
@synthesize anchor;

#pragma mark - Livecycle methods
- (void)viewDidLoad 
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:self.splashImage];
    [self.view addSubview:imgView];
    [imgView release];
    /*self.view.layer.contentsScale = [[UIScreen mainScreen] scale];
    self.view.layer.contents = (id)self.splashImage.CGImage;
    self.view.contentMode = UIViewContentModeBottom;*/
    if (self.transition == 0) self.transition = ClearFromRight;
}

- (void)viewDidAppear:(BOOL)animated 
{
    if ([self.delegate respondsToSelector:@selector(splashScreenDidAppear:)])
        [self.delegate splashScreenDidAppear:self];
        
    switch (self.transition) {              
        case CircleFromCenter:
            self.maskImageName = @"mask";
            self.anchor = CGPointMake(0.5, 0.5);
            break;
        case ClearFromCenter:
            self.maskImageName = @"wideMask";
            self.anchor = CGPointMake(0.5, 0.5);
            break;
        case ClearFromLeft:
            self.maskImageName = @"leftStripMask";
            self.anchor = CGPointMake(0.0, 0.5);
            break;
        case ClearFromRight:
            self.maskImageName = @"RightStripMask";
            self.anchor = CGPointMake(1.0, 0.5);
            break;
        case ClearFromTop:
            self.maskImageName = @"TopStripMask";
            self.anchor = CGPointMake(0.5, 0.0);
            break;
        case ClearFromBottom:
            self.maskImageName = @"BottomStripMask";
            self.anchor = CGPointMake(0.5, 1.0);
            break;
        default:
            return;
    }
    [self performSelector:@selector(animate) 
               withObject:nil 
               afterDelay:self.delay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Others
- (void)showInWindow:(UIWindow *)window 
{
    [window addSubview:self.view];        
}

- (UIImage *)splashImage 
{
    if (splashImage == nil) {
        splashImage = [UIImage imageNamed:@"Default.png"];
    }
    return splashImage;
}

- (UIImage *)maskImage 
{
    if (maskImage != nil) [maskImage release];
    NSString *defaultPath = [[NSBundle mainBundle] 
                             pathForResource:self.maskImageName 
                             ofType:@"png"];
    maskImage = [[UIImage alloc] 
                 initWithContentsOfFile:defaultPath];
    return maskImage;
}

- (void)setMaskLayerwithanchor 
{    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.anchorPoint = self.anchor;
    maskLayer.frame = self.view.superview.frame;
    maskLayer.contents = (id)self.maskImage.CGImage;
    self.view.layer.mask = maskLayer;
}

- (void)animate 
{
    if ([self.delegate respondsToSelector:@selector(splashScreenWillDisappear:)])
        [self.delegate splashScreenWillDisappear:self];
    
    [self setMaskLayerwithanchor];
    
    CABasicAnimation *anim = [CABasicAnimation 
                              animationWithKeyPath:@"transform.scale"];
    anim.duration = DURATION;
    anim.toValue = [NSNumber numberWithInt:self.view.bounds.size.height/8];
    anim.fillMode = kCAFillModeBoth;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [self.view.layer.mask addAnimation:anim forKey:@"scale" ];
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag 
{	
    self.view.layer.mask = nil;
    [self.view removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(splashScreenDidDisappear:)]) {
        [self.delegate splashScreenDidDisappear:self];
    }
}

#pragma mark - Memory management
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc 
{
    [splashImage release], splashImage = nil;
    [maskImage release], maskImage = nil;
    [maskImageName release], maskImageName = nil;
    [super dealloc];
}

@end