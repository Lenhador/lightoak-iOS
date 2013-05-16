//
//  UIToolbarVideoView.m
//  OpenTokBasic
//
//  Created by Администратор on 3/28/13.
//
//

#import "UIToolbarVideoView.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIToolbarVideoView

@synthesize audioPub, toChat, videoPub, pauseLesson, warning;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {        
        [self setBackgroundColor:[UIColor colorWithWhite:0. alpha:0.5]];        
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        
        CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height* screenScale);
        
        audioPub = [UIButton buttonWithType:UIButtonTypeCustom];
        [audioPub setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
        audioPub.exclusiveTouch = NO;
        
        videoPub = [UIButton buttonWithType:UIButtonTypeCustom];
        [videoPub setImage:[UIImage imageNamed:@"eye_white.png"] forState:UIControlStateNormal];
        videoPub.exclusiveTouch = NO;
        
        toChat = [UIButton buttonWithType:UIButtonTypeCustom];
        [toChat setImage:[UIImage imageNamed:@"chat.png"] forState:UIControlStateNormal];
        toChat.exclusiveTouch = NO;
        
        pauseLesson = [UIButton buttonWithType:UIButtonTypeCustom];
        [pauseLesson setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        pauseLesson.exclusiveTouch = NO;
        
        warning = [UIButton buttonWithType:UIButtonTypeCustom];
        [warning setImage:[UIImage imageNamed:@"warning.png"] forState:UIControlStateNormal];
        warning.exclusiveTouch = NO;
        [warning.layer setCornerRadius:5.];
        [warning.layer setMasksToBounds:YES];
        [warning setBackgroundColor:[UIColor colorWithRed:252./255. green:98./255. blue:100./255. alpha:1.]];

        if(screenSize.height > 1135.)
        {
            [audioPub setFrame:CGRectMake(174, 10, 40, 40)];
            [videoPub setFrame: CGRectMake(234, 10, 40, 40)];
            [toChat setFrame: CGRectMake(294, 10, 40, 40)];
            [pauseLesson setFrame: CGRectMake(354, 10, 40, 40)];
            [warning setFrame: CGRectMake(518, 10, 40, 40)];
        }
        else if(screenSize.height < 961.)
        {
            [audioPub setFrame:CGRectMake(130, 10, 40, 40)];
            [videoPub setFrame: CGRectMake(190, 10, 40, 40)];
            [toChat setFrame: CGRectMake(250, 10, 40, 40)];
            [pauseLesson setFrame: CGRectMake(310, 10, 40, 40)];
            [warning setFrame: CGRectMake(430, 10, 40, 40)];
        }
        
        [self addSubview:audioPub];
        [self addSubview:videoPub];
        [self addSubview:toChat];
        [self addSubview:pauseLesson];
        [self addSubview:warning];
    }
    return self;
}

@end
