//
//  ProfileViewController.m
//  Lightoak
//
//  Created by Администратор on 4/6/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "ProfileViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()

@end
@implementation ProfileViewController
@synthesize photoView, startLessonBut,titleNav;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleNav setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:17.]];
    startLessonBut.titleLabel.font = [UIFont fontWithName:@"PTSans-CaptionBold" size:15.];
    [startLessonBut setTitleEdgeInsets:UIEdgeInsetsMake(3., 0., 0., 0.)];
    [startLessonBut.layer setCornerRadius:5.];
    [startLessonBut.layer setMasksToBounds:YES];
    
    [photoView.layer setCornerRadius:5.];
    [photoView.layer setMasksToBounds:YES];
    [photoView setImage:[UIImage imageNamed:@"belov.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
