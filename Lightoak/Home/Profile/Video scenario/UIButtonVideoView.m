//
//  UIButtonVideoView.m
//  OpenTokBasic
//
//  Created by Администратор on 3/28/13.
//
//

#import "UIButtonVideoView.h"


@implementation UIButtonVideoView

@synthesize off;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIFont *butFont = [UIFont fontWithName:@"Noteworthy-Bold" size:17.0];
        UIColor *butColorDefault = [UIColor colorWithRed:90.0f/255 green:90.0f/255 blue:90.0f/255 alpha:1.0];
        UIColor *butColorHighlight = [UIColor colorWithRed:255.0f/255 green:255.0f/255 blue:255.0f/255 alpha:1.0];
        
        UIImage *btn = [UIImage imageNamed:@"Button.png"];
        UIImage *btnH = [UIImage imageNamed:@"ButtonHighlighted.png"];
        
        self = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self setTitle:@"About me" forState:UIControlStateNormal];
        [self setBackgroundImage:btn forState:UIControlStateNormal];
        [self setBackgroundImage:btnH forState:UIControlStateHighlighted];
        
        [self.titleLabel setFont:butFont];
        [self setTitleColor:butColorDefault forState:UIControlStateNormal];
        [self setTitleColor:butColorHighlight forState:UIControlStateHighlighted];
        off = NO;
    }
    return self;
}

@end
