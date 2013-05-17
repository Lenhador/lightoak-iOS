//
//  RegistrationViewController.h
//  Lightoak
//
//  Created by Администратор on 4/6/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CroppingViewController.h"

@interface RegistrationViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CroppingImageDelegate, UIActionSheetDelegate, NSURLConnectionDelegate, UITextFieldDelegate>

@property (nonatomic) UIImagePickerController *galleryPickerController;
@property (nonatomic) UIImagePickerController *cameraPickerController;
@property (strong, nonatomic) IBOutlet UITextField *titleNav;

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UITextField *fNameField;
@property (strong, nonatomic) IBOutlet UITextField *lNameField;
@property (strong, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *placeholderAgeLabel;
@property (strong, nonatomic) IBOutlet UILabel *nodeLabel1;
@property (strong, nonatomic) IBOutlet UILabel *nodeLabel2;
@property (strong, nonatomic) IBOutlet UIButton *regBut;

- (IBAction)endRegistration:(UIButton *)sender;

- (void) updateUserPhoto:(UIImage *)photo;
- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker;

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void) connectionDidFinishLoading : (NSURLConnection *)connection;
- (IBAction)back:(UIBarButtonItem *)sender;
@end
