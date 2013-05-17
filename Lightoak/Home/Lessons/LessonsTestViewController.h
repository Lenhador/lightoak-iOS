//
//  LessonsTestViewController.h
//  Lightoak
//
//  Created by Администратор on 4/9/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonsTestViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmantController;
- (IBAction)changeMode:(UISegmentedControl *)sender;

@property (strong, nonatomic)  UIImageView *teacherVIew;
@property (strong, nonatomic)  UIImageView *studentVIew;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
