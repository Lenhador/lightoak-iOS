//
//  CLesson.h
//  Lightoak
//
//  Created by Администратор on 4/8/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLesson : NSObject

@property (nonatomic) NSString *fName, *lName;
@property (nonatomic) NSString *time, *price;
@property (nonatomic) NSString *content;
@property (nonatomic) UIView *flag1, *flag2, *photoTeacher;

@end
