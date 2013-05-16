//
//  ChatViewController.h
//  Lightoak
//
//  Created by Администратор on 4/5/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *titleNav;
- (IBAction)toVideo:(UIBarButtonItem *)sender;
@end
