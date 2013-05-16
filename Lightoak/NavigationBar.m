//
//  NavigationBar.m
//  Lightoak
//
//  Created by Администратор on 4/8/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   
    //[self setTintColor: color];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColor(context, CGColorGetComponents( [color CGColor]));
    CGContextFillRect(context, rect);
}


@end
