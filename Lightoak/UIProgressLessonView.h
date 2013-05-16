//
//  UIProgressLessonView.h
//  OpenTokBasic
//
//  Created by Администратор on 3/31/13.
//
//

#import <UIKit/UIKit.h>

@interface UIProgressLessonView : UIProgressView

- (id)initWithFrame:(CGRect)frame timeLessson : (float) timeLesson;
@property (nonatomic) BOOL pause;
@end
