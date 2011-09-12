//
//  SplashScreen.m
//  BasicSplashScreen
//
//  Created by Jean Paul Salas Poveda on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SplashScreen.h"

@implementation SplashScreen

@synthesize splashImage;
@synthesize showsStatusBarOnDismissal;
@synthesize delegate;

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
    [splashImage release];
    [super dealloc];
}

#pragma mark - View lifecycle
- (UIImage *)splashImage 
{
    if (splashImage == nil) 
        self.splashImage = [UIImage imageNamed:@"Default.png"];
    
    return splashImage; 
}

- (void)hide 
{
    if (self.showsStatusBarOnDismissal) 
    {
        UIApplication *app = [UIApplication sharedApplication];
        [app setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:self.splashImage]; 
    iv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    iv.contentMode = UIViewContentModeCenter;
    self.view = iv;
    [iv release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
    SEL didAppearSelector = @selector(splashScreenDidAppear:); 
    if ([self.delegate respondsToSelector:didAppearSelector])
        [self.delegate splashScreenDidAppear:self];
    
    [self performSelector:@selector(hide) withObject:nil afterDelay:2]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    SEL willDisappearSelector = @selector(splashScreenWillDisappear:); 
    if ([self.delegate respondsToSelector:willDisappearSelector])
        [self.delegate splashScreenWillDisappear:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    SEL didDisappearSelector = @selector(splashScreenDidDisappear:); 
    if ([self.delegate respondsToSelector:didDisappearSelector])
        [self.delegate splashScreenDidDisappear:self];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end