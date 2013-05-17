//
//  TextField.m
//  Lightoak
//
//  Created by Администратор on 4/9/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "TextField.h"

@interface TextFieldDDD ()

@end
@implementation TextFieldDDD

@synthesize horizontalPadding, verticalPadding;
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + horizontalPadding, bounds.origin.y + verticalPadding, bounds.size.width - horizontalPadding*2, bounds.size.height - verticalPadding*2);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
