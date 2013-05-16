//
//  AuthViewController.h
//  Lightoak
//
//  Created by Администратор on 4/5/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"
@interface AuthViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *loginField;
@property (strong, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UIImageView *loginpassView;
@property (strong, nonatomic) IBOutlet UIButton *regBut;
@property (strong, nonatomic) IBOutlet UIButton *loginBut;

- (IBAction)authentication:(UIButton *)sender;
@end
