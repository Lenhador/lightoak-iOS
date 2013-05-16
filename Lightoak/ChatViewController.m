//
//  ChatViewController.m
//  Lightoak
//
//  Created by Администратор on 4/5/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "ChatViewController.h"

#import "VideoLessonController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController
@synthesize titleNav;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleNav setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:17.]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toVideo:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"to_video" sender:self];
}

- (BOOL) shouldAutorotate
{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
@end
