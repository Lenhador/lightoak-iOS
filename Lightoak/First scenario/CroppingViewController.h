//
//  CroppingViewController.h
//  lightoak
//
//  Created by Администратор on 2/24/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CroppingImageDelegate <NSObject>

@required
-(void)updateUserPhoto : (UIImage *) photo;

@end

@interface CroppingViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) UIImage *imageCrop;
-(void)croppingWithImage : (UIImage *) image delegate : (id) delegate;
@property id delegate;
@property UIImageView *imageView;
- (IBAction)executeCropp:(UIBarButtonItem *)sender;

@property (nonatomic) CALayer *cropRect;
//- (IBAction)handlePan :(UIPanGestureRecognizer *)recognizer;

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView;

@end
