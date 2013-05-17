//
//  LessonsTestViewController.m
//  Lightoak
//
//  Created by Администратор on 4/9/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "LessonsTestViewController.h"

@interface LessonsTestViewController ()
{
    BOOL showFirstView;
}

@end

@implementation LessonsTestViewController
@synthesize segmantController, teacherVIew,studentVIew,scrollView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [segmantController addTarget:self action:@selector(changeMode:) forControlEvents:UIControlEventValueChanged];
    teacherVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"teachers.png"]];
    studentVIew = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"students.png"]];

    
    [scrollView addSubview:teacherVIew];
    [scrollView addSubview:studentVIew];
    
    
    [segmantController setTintColor:[UIColor colorWithRed:112./255. green:172./255. blue:93./255. alpha:1.]];
    showFirstView = YES;
    [studentVIew setHidden:YES];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 560)];
    [self.view addSubview:scrollView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"Я скроллю");
}
- (IBAction)changeMode:(UISegmentedControl *)sender
{
    if(showFirstView)
    {
        showFirstView = NO;
        [teacherVIew setHidden:YES];
        [studentVIew setHidden:NO];
    }
    else
    {
        showFirstView = YES;
        [studentVIew setHidden:YES];
        [teacherVIew setHidden:NO];
    }
}

@end
