//
//  UIProfileTableViewCell.m
//  Lightoak
//
//  Created by Администратор on 4/8/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "UIProfileTableViewCell.h"

@implementation UIProfileTableViewCell
@synthesize fNameLabel, lNameLabel, timeLabel, contenLessonTextView, photoTeacherView, flagView1, flagView2, buyButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContentLesson:(CLesson *)lesson
{
    [fNameLabel setText:lesson.fName];
    [lNameLabel setText:lesson.lName];
    [timeLabel setText:lesson.time];
    [contenLessonTextView setText:lesson.content];
    [buyButton setTitle:lesson.price forState:UIControlStateNormal];
}
- (IBAction)buyLesson:(UIButton *)sender
{
    
}
@end
