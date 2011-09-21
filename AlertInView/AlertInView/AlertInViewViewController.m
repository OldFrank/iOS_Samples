//
//  AlertInViewViewController.m
//  AlertInView
//
//  Created by Jean Paul Salas Poveda on 18/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertInViewViewController.h"
#import "AlertInView.h"

@implementation AlertInViewViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AlertInView *aView = [AlertInView alertInView];
    [aView showWithTimer:3.5 inView:self.view bounce:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
