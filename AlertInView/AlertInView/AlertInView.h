//
//  AlertInView.h
//  AlertInView
//
//  Created by Jean Paul Salas Poveda on 18/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define viewWidth   200
#define viewHeight  100

@interface AlertInView : UIView
{
    NSTimer *popInTimer;
}
@property CGFloat adjustY;
@property CGFloat adjustX;

+ (id)alertInView;
- (void)showWithTimer:(CGFloat)timer inView:(UIView *)view bounce:(BOOL)bounce;

@end

@interface AlertInView (Private)
- (id) init;
- (void) popIn;
@end