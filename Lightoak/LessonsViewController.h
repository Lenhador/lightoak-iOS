//
//  LessonsViewController.h
//  Lightoak
//
//  Created by Администратор on 4/8/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (strong, nonatomic) IBOutlet UITableView *lessonTableView;
- (IBAction)changeMode:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutlet UITextField *titleNav;

@end
