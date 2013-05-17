//
//  RegistrationViewController.m
//  Lightoak
//
//  Created by Администратор on 4/6/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "RegistrationViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface RegistrationViewController ()
{
    float someFloat;
}

@property (nonatomic) BOOL presenceCamera;
@property (nonatomic) CroppingViewController *croppViewController;
@property (nonatomic) UIImage *imageCropp;
@property (nonatomic) NSMutableData *responseData;


- (UIImage *)scaleAndRotateImage:(UIImage *)image;
-(BOOL) checkPresenceCamera;
@end


@implementation RegistrationViewController

@synthesize galleryPickerController, cameraPickerController, photoView, datePicker, ageLabel;
//Поля для регистрации
@synthesize fNameField,lNameField,passField,emailField;
@synthesize responseData;
@synthesize croppViewController, imageCropp, titleNav;
@synthesize nodeLabel1,nodeLabel2,regBut, placeholderAgeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleNav setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:17.]];
    [fNameField setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:15.]];
    [lNameField setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:15.]];
    [passField setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:15.]];
    [emailField setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:15.]];
    [nodeLabel1 setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:13.]];
    [nodeLabel2 setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:13.]];
    [placeholderAgeLabel setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:13.]];
    [ageLabel setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:15.]];
    regBut.titleLabel.font = [UIFont fontWithName:@"PTSans-CaptionBold" size:15.];
    [regBut setTitleEdgeInsets:UIEdgeInsetsMake(3., 0., 0., 0.)];
    [regBut.layer setCornerRadius:5.];
    [regBut.layer setMasksToBounds:YES];
    
    galleryPickerController = [[UIImagePickerController alloc] init];
    galleryPickerController.delegate = self;
    galleryPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    self.presenceCamera = [self checkPresenceCamera];
    
    UITapGestureRecognizer *tapAgeLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker:)];
    [ageLabel addGestureRecognizer:tapAgeLabel];
    ageLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRegistrationView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDatePicker:)];
    [self.view addGestureRecognizer:tapRegistrationView];
    [datePicker setHidden:YES];
    
    [datePicker addTarget:self action:@selector(dateChange :) forControlEvents:UIControlEventValueChanged];
    
    
    UITapGestureRecognizer *tapChoicePhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    photoView.userInteractionEnabled = YES;
    [photoView addGestureRecognizer:tapChoicePhoto];
    [photoView.layer setCornerRadius:5.];
    [photoView.layer setMasksToBounds:YES];
    
    croppViewController = [[CroppingViewController alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dateChange:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    [ageLabel setText:[dateFormat stringFromDate:datePicker.date]];
}
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

#pragma mark -
#pragma mark TextField delegate method

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)back:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Management DatePicker

- (void)showDatePicker : (UITapGestureRecognizer *)sender
{
    if(datePicker.hidden == YES)
        [datePicker setHidden:NO];
}


- (void)hideDatePicker : (UITapGestureRecognizer *)sender
{
    if(datePicker.hidden == NO)
    {
        [datePicker setHidden:YES];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd.MM.yyyy"];
        [ageLabel setText:[dateFormat stringFromDate:datePicker.date]];
    }
    else
        return;
}

#pragma mark -
#pragma mark UIActionSheet delegate method

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self presentViewController:galleryPickerController animated:YES completion:nil];
    }
    else if(buttonIndex == 1)
    {
        [self presentViewController:cameraPickerController animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark Check presence ot the camera on device

- (BOOL)checkPresenceCamera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        cameraPickerController = [[UIImagePickerController alloc] init];
        cameraPickerController.delegate = self;
        cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        else
        {
            cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        return YES;
    }
    return NO;
}



- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:^{
        imageCropp = [info objectForKey:UIImagePickerControllerOriginalImage];
        imageCropp = [self scaleAndRotateImage:imageCropp];
        [self performSegueWithIdentifier:@"to_crop" sender:self];
    }];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapImageView:(UITapGestureRecognizer *)sender
{
    UIActionSheet *actSheet = nil;
    if(self.presenceCamera)
    {
        actSheet = [[UIActionSheet alloc] initWithTitle:@"Please choice your photo" delegate:self cancelButtonTitle:@"Cansel" destructiveButtonTitle:nil otherButtonTitles:@"Gallery", @"Camera", nil];
    }
    else
    {
        actSheet = [[UIActionSheet alloc] initWithTitle:@"Please choice your photo" delegate:self cancelButtonTitle:@"Cansel" destructiveButtonTitle:nil otherButtonTitles:@"Gallery", nil];
    }
    actSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actSheet showInView:self.view];
}

- (void) updateUserPhoto:(UIImage *)photo
{
    [photoView setImage:photo];
}

- (IBAction)endRegistration:(UIButton *)sender
{
    //создаем разделитель (границу)
    NSString *boundary = @"--------------1898321078F912I1230123";
    
    //создаем адрес хоста
    NSString *urlStr = @"http://lightoak.herokuapp.com/users.json";
    
    //создаем объект запроса и указываем ему метод POST
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"POST"];
    
    //создаем строку с типом контента и указываем разделитель
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    //указываем запросу тип контента
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    //получаем данные фото и сжимаем ее
    NSData *imageData = UIImageJPEGRepresentation(photoView.image, 0.9);
    
    NSMutableData *body = [[NSMutableData alloc] init];
    
    //закидываем email
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user[email]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[emailField.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //закидываем пароль
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user[password]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[passField.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //закидываем поле с первым именем
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user[name]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[fNameField.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //закидываем в тело запроса картинку
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"user[avatar]\"; filename=\"my_img.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //указываем что поток стандартный
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //закидываем поле с датой дня рождения
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user[birthday]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[ageLabel.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //закидываем поле со вторым именем
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user[last]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[lNameField.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //закрываем форму отправки
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //устанавливаем тело запроса
    [request setHTTPBody:body];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        NSLog(@"Connection successed");
    }
    else
    {
        NSLog(@"Connection failed");
    }
    
}
- (void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
}
- (void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil]);
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"to_crop"])
    {
        CroppingViewController *cropVC = [segue destinationViewController];
        [cropVC croppingWithImage:self.imageCropp delegate:self];
    }
}

@end
