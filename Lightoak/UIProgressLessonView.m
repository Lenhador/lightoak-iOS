//
//  UIProgressLessonView.m
//  OpenTokBasic
//
//  Created by Администратор on 3/31/13.
//
//

#import "UIProgressLessonView.h"

@interface UIProgressLessonView ()
{
    float timeLesson;
    float timeElapsed;
    NSTimer *timer;
}

@end
@implementation UIProgressLessonView

@synthesize pause;

- (id)initWithFrame:(CGRect)frame timeLessson:(float)time
{
    self = [super initWithFrame:frame];
    if (self)
    {
        pause = NO;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 0.5f);
        self.transform = transform;
        timeLesson = time;
        [self setTrackImage:[UIImage imageNamed:@"track.png"]];
        [self setProgressImage:[UIImage imageNamed:@"progress.png"]];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeView) userInfo:nil repeats:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ajustTimeLesson: ) name:@"ajustTime" object:nil];
    }
    return self;
}

- (void) ajustTimeLesson : (NSNotification *)notification
{
    if(pause)
    {
        [timer invalidate];
    }
    else
    {
        [self setProgress:timeElapsed/timeLesson animated:YES];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeView) userInfo:nil repeats:YES];
    }
}
- (void)updateTimeView
{
    if(timeElapsed == timeLesson)
    {
        [timer invalidate];
    }
    else
    {
        timeElapsed = timeElapsed +1;
    }
    [self setProgress:timeElapsed/timeLesson animated:YES];
}
@end
