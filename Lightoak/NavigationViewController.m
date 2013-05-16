//
//  NavigationViewController.m
//  Lightoak
//
//  Created by Администратор on 4/8/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "NavigationViewController.h"
#import "NavigationBar.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NavigationBar *navBar = [[NavigationBar alloc] init];
    //[navBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:1. green:1.0 blue:1.0 alpha:1.0], UITextAttributeTextColor,
      [UIColor colorWithRed:216./255. green:216./255. blue:216./255. alpha:0.], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(1, 1)], UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"PTSans-CaptionBold" size:17.], UITextAttributeFont,
      nil]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:112./255. green:172./255. blue:93./255. alpha:1.]];
//	[[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal
//                                          barMetrics:UIBarMetricsDefault];

    //[self setValue:navBar forKey:@"navigationBar"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) shouldAutorotate
{
    return [[self topViewController] shouldAutorotate];
}

- (NSUInteger) supportedInterfaceOrientations
{
    return [[self topViewController] supportedInterfaceOrientations];
}

@end
