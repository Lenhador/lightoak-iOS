//
//  CroppingViewController.m
//  lightoak
//
//  Created by Администратор on 2/24/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "CroppingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CroppingViewController ()

@property (nonatomic) float difference;
@property (nonatomic) UIScrollView *imageScrollView;
@end

@implementation CroppingViewController

@synthesize imageCrop, cropRect, imageScrollView, imageView, difference;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0., 0., 320, 320)];
    imageScrollView.delegate = self;
    [imageScrollView setMinimumZoomScale:1.];
    [imageScrollView setMaximumZoomScale:3.];
    
    self.view.backgroundColor = [UIColor blackColor];
            
    imageView = [[UIImageView alloc] initWithImage:self.imageCrop];
    
    CGRect rect;
    rect.size.width = self.imageCrop.size.width;
    rect.size.height = self.imageCrop.size.height;
    
    [imageView setFrame:rect];
    
    [imageScrollView setContentSize:rect.size];
    
    
    [imageScrollView addSubview:imageView];
    [self.view addSubview:imageScrollView];

    /*cropRect = [CALayer layer];
    cropRect.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1].CGColor;
    cropRect.borderColor = [UIColor blackColor].CGColor;
    cropRect.borderWidth = 1.0;

    cropRect.frame = CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.width);
        [self.view.layer addSublayer:cropRect];*/
    
    if(imageCrop.size.width < cropRect.frame.size.width || imageCrop.size.height < cropRect.frame.size.width)
    {
        float different;
        
        if(imageCrop.size.width < imageCrop.size.height)
        {
            different = imageCrop.size.width / 100;
        }
        else
        {
            different = imageCrop.size.height / 100;
            
            
        }
        float differentBetween = cropRect.frame.size.width / different/ 100;

        [imageScrollView setMinimumZoomScale:differentBetween];
        [imageScrollView setMaximumZoomScale:differentBetween*2];
        [imageScrollView setZoomScale:differentBetween];
        
       /* float a = (self.view.frame.size.height-self.navigationBar.frame.size.height) / 2;
        float b = imageCrop.size.height /2 ;
        float yOrigin = a - b - self.navigationBar.frame.size.height;
        
        float c = self.view.frame.size.width / 2;
        //NSLog(@"height display /2 = %f", c);
        float d = imageCrop.size.width * differentBetween / 2;
        //NSLog(@"height image /2 = %f", d);

        float e = c - d;
        //NSLog(@"%f", e);
        [imageView setFrame:CGRectMake(e, yOrigin, self.imageView.frame.size.width, self.imageView.frame.size.height)];
        [imageScrollView setContentOffset:CGPointMake(e, imageScrollView.frame.origin.y)];*/
    }
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)containerView
{
    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
}

-(void)croppingWithImage:(UIImage *)image delegate : (id) delegate
{
    self.imageCrop = image;
    self.delegate = delegate;
}

- (IBAction)executeCropp:(UIBarButtonItem *)sender
{
    /*float topEdgePosition = CGRectGetMinY(cropRect.frame);
    NSLog(@"Cropping coordinate Y = %f", topEdgePosition);
    
    UIImage *croppedImage = nil;
    
    CGRect croppedRect = CGRectMake(0, topEdgePosition, cropRect.frame.size.width, cropRect.frame.size.height);
    CGImageRef tmp = CGImageCreateWithImageInRect([self.imageView.image CGImage], croppedRect);
    croppedImage = [UIImage imageWithCGImage:tmp];
    CGImageRelease(tmp);
    
    NSData *croppedImageData = UIImageJPEGRepresentation(croppedImage, 0.7);
    [imageView setImage:croppedImage];


    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = CGRectMake(0, self.view.frame.size.height*0.3, cropRect.frame.size.width, cropRect.frame.size.height);
    }];
    
    [cropBut setEnabled:NO];
    [cropRect setHidden:YES];*/
    float zoomScale = 1.0 / [imageScrollView zoomScale];
	
	CGRect rect;
	rect.origin.x = [imageScrollView contentOffset].x * zoomScale;
	rect.origin.y = [imageScrollView contentOffset].y * zoomScale;
    /*
    rect.size.width = [cropRect bounds].size.width * zoomScale;
    rect.size.height = [cropRect bounds].size.width * zoomScale;
    
    
	rect.size.width = [imageScrollView bounds].size.width * zoomScale;
	rect.size.height = [imageScrollView bounds].size.height * zoomScale;
     
    */
    rect.size.width = imageScrollView.frame.size.width * zoomScale;
    rect.size.height = imageScrollView.frame.size.width * zoomScale;
     
	
	CGImageRef cr = CGImageCreateWithImageInRect([[imageView image] CGImage], rect);
	
	UIImage *cropped = [UIImage imageWithCGImage:cr];
	
	CGImageRelease(cr);
    
    if([self.delegate conformsToProtocol:@protocol(CroppingImageDelegate)])
    {
        [self.delegate updateUserPhoto:cropped];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


/*
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
{
    switch ([recognizer state])
    {
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y + translation.y);
            
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
            
            float topEdgePosition = CGRectGetMinY(cropRect.frame);
            NSLog(@"Top edge position = %f", topEdgePosition);
            float bottomEdgePosition = CGRectGetMaxY(cropRect.frame);
            NSLog(@"Bottom edge position = %f", bottomEdgePosition);


            if(topEdgePosition <= 50)
            {
                cropRect.frame = CGRectMake(0, 53, cropRect.frame.size.width, cropRect.frame.size.height);
            }
            
            if(bottomEdgePosition >= 450)
            {
                cropRect.frame = CGRectMake(0,450-cropRect.frame.size.height,cropRect.frame.size.width, cropRect.frame.size.height);
            }
        }
            break;
            
        default:
            break;
    }
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
