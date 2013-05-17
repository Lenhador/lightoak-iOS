//
//  TabBarViewController.m
//  Lightoak
//
//  Created by Администратор on 4/6/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "TabBarViewController.h"

#import "ProfileViewController.h"

#import "LessonsViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar.png"]];
    [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];

    [[[self.viewControllers objectAtIndex:0] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"user_white.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"user_white.png"]];
    [[[self.viewControllers objectAtIndex:1] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"posts_white.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"posts_white.png"]];
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"leaf.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"leaf.png"]];
    [[[self.viewControllers objectAtIndex:3] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"settings_white.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"settings_white.png"]];
    
    
    
    //[[[self.viewControllers objectAtIndex:0] tabBarItem] setImage:[UIImage imageNamed:@"user_white.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate
{
    return YES;
}
- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
