//
//  AlertInView.m
//  AlertInView
//
//  Created by Jean Paul Salas Poveda on 18/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertInView.h"

@implementation AlertInView

@synthesize adjustY;
@synthesize adjustX;

+ (id)alertInView
{
    AlertInView *alertIn = [[[AlertInView alloc] init] autorelease];
    alertIn.layer.bounds = CGRectMake(0, 0, viewWidth,viewHeight);
    alertIn.layer.anchorPoint = CGPointMake(0, 0);
    alertIn.layer.position = CGPointMake(-viewWidth, 0);	
    
    UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tmpButton.frame = CGRectMake(0, 0, 100, 30);
    tmpButton.center = CGPointMake(viewWidth/2, viewHeight/2);
    [alertIn addSubview:tmpButton];
    
    return alertIn;
}

- (void)showWithTimer:(CGFloat)timer inView:(UIView *)view bounce:(BOOL)bounce
{
    self.adjustX = 0;
    self.adjustY = 0;
    CGPoint fromPos;

	self.adjustY = -self.frame.size.height;
    fromPos = CGPointMake(view.frame.size.width/2-self.frame.size.width/2,view.bounds.size.height);
    
    if (NO) 
    {    
        CGPoint toPos = fromPos;
        CGPoint bouncePos = fromPos;
        bouncePos.x += (adjustX*1.2);
        bouncePos.y += (adjustY*1.2);
        toPos.x += adjustX;
        toPos.y	+= adjustY;
		
        CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyFrame.values  =  [NSArray arrayWithObjects:[NSValue valueWithCGPoint:fromPos],
                                                      [NSValue valueWithCGPoint:bouncePos],
                                                      [NSValue valueWithCGPoint:toPos],
                                                      [NSValue valueWithCGPoint:bouncePos],
                                                      [NSValue valueWithCGPoint:toPos],nil];
        keyFrame.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],
                                                      [NSNumber numberWithFloat:.18],
                                                      [NSNumber numberWithFloat:.5],
                                                      [NSNumber numberWithFloat:.75],
                                                      [NSNumber numberWithFloat:1],nil];
		
        keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        keyFrame.duration = .75;          // Use a longer duration to allow for bounce time
        self.layer.position = toPos;      // ensures that the layer stays in it's final position
        
        [self.layer addAnimation:keyFrame forKey:@"keyFrame"];
        
    } else {                              // Use implicit animation to slide in image
        
        CGPoint toPos = fromPos;
        toPos.x += adjustX;
        toPos.y	+= adjustY;
        
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"position"];
        basic.fromValue = [NSValue valueWithCGPoint:fromPos];
        basic.toValue = [NSValue valueWithCGPoint:toPos];
        self.layer.position = toPos;
        //self.center = toPos;
        [self.layer addAnimation:basic forKey:@"basic"];		
	}
    
    popInTimer = [NSTimer scheduledTimerWithTimeInterval:timer 
                                                  target:self 
                                                selector:@selector(popIn) 
                                                userInfo:nil 
                                                 repeats:NO];
    
    [view addSubview:self];
}

@end

@implementation AlertInView (Private)
- (id) init
{
    if ((self = [super init])) 
    {

        self.backgroundColor = [UIColor yellowColor];
    }
    
    return self;
}

- (void) popIn
{
    [UIView beginAnimations:@"slideIn" context:nil];
	self.frame = CGRectOffset(self.frame, -adjustX, -adjustY);
	[UIView commitAnimations];
}
@end