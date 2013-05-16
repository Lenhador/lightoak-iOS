//
//  AuthViewController.m
//  Lightoak
//
//  Created by Администратор on 4/5/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "AuthViewController.h"

#import <QuartzCore/QuartzCore.h>

#define padding 10.0f
@interface AuthViewController ()

@end

@implementation AuthViewController

@synthesize loginpassView;
@synthesize loginField, passField;
@synthesize loginBut, regBut;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    loginField.delegate = self;
    [loginField setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:15.]];
//    loginField.layer.sublayerTransform = CATransform3DMakeTranslation(0., 3., 0.);
    
    regBut.titleLabel.font = [UIFont fontWithName:@"PTSans-CaptionBold" size:15.];
    [regBut setTitleEdgeInsets:UIEdgeInsetsMake(3., 0., 0., 0.)];
    [regBut.layer setCornerRadius:5.];
    [regBut.layer setMasksToBounds:YES];
    
    loginBut.titleLabel.font = [UIFont fontWithName:@"PTSans-CaptionBold" size:15.];
    [loginBut setTitleEdgeInsets:UIEdgeInsetsMake(3., 0., 0., 0.)];
    [loginBut.layer setCornerRadius:5.];
    [loginBut.layer setMasksToBounds:YES];
    
    passField.delegate = self;
    [passField setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:15.]];
    
    /*
    // observe keyboard hide and show notifications to resize the text view appropriately
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Responding to keyboard events

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's
    // coordinate system. The bottom of the text view's frame should align with the top
    // of the keyboard's final position.
    //
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    keyboard_height = keyboardRect.size.height;
    //CGFloat keyboardTop = keyboardRect.origin.y;
    
    CGRect newLoginFieldFrame = CGRectMake(loginField.frame.origin.x, loginField.frame.origin.y - keyboard_height, loginField.frame.size.width, loginField.frame.size.height);
    
    CGRect newPassFieldFrame = CGRectMake(passField.frame.origin.x, passField.frame.origin.y - keyboard_height, passField.frame.size.width, passField.frame.size.height);
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.loginField.frame = newLoginFieldFrame;
    self.passField.frame = newPassFieldFrame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
 
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    loginField.frame = CGRectMake(loginField.frame.origin.x, loginField.frame.origin.y + keyboard_height, loginField.frame.size.width, loginField.frame.size.height);
    passField.frame = CGRectMake(passField.frame.origin.x, passField.frame.origin.y + keyboard_height, passField.frame.size.width, passField.frame.size.height);
    
    [UIView commitAnimations];
}
*/

#pragma mark -
#pragma mark Orientation method

- (BOOL) shouldAutorotate
{
    return YES;
}
- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)authentication:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"to_main" sender:self];			
}
@end
