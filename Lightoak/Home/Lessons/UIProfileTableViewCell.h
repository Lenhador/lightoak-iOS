//
//  UIProfileTableViewCell.h
//  Lightoak
//
//  Created by Администратор on 4/8/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CLesson.h"

@interface UIProfileTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *fNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UITextView *contenLessonTextView;
@property (strong, nonatomic) IBOutlet UIImageView *photoTeacherView;
@property (strong, nonatomic) IBOutlet UIImageView *flagView1;
@property (strong, nonatomic) IBOutlet UIImageView *flagView2;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;

- (IBAction)buyLesson:(UIButton *)sender;

- (void) setContentLesson : (CLesson *) lesson;

@end
