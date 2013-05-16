//
//  LessonsViewController.m
//  Lightoak
//
//  Created by Администратор on 4/8/13.
//  Copyright (c) 2013 Three way studio. All rights reserved.
//

#import "LessonsViewController.h"

#import "UIProfileTableViewCell.h"

#import "CLesson.h"

#import "TextField.h"

@interface LessonsViewController ()
@property (nonatomic) NSMutableDictionary *proposals;
@property (nonatomic) NSString *identifierCell;
@end

@implementation LessonsViewController

@synthesize proposals, lessonTableView, segmentController, identifierCell, titleNav;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleNav setFont:[UIFont fontWithName:@"PTSans-CaptionBold" size:17.]];

    [segmentController addTarget:self action:@selector(changeMode:) forControlEvents:UIControlEventValueChanged];
    NSMutableArray *students = [[NSMutableArray alloc] init];
    CLesson *fLesson = [[CLesson alloc] init];
        fLesson.fName = @"Иван";
        fLesson.lName = @"Трифонов";
        fLesson.time = @"00 : 13";
        fLesson.price = @"300 D";
        fLesson.content = @"Я хочу научиться рисовать глаз";
    [students addObject:fLesson];
    
    CLesson *sLesson = [[CLesson alloc] init];
        sLesson.fName = @"Александр";
        sLesson.lName = @"Белов";
        sLesson.time = @"00 : 26";
        sLesson.price = @"340 D";
        sLesson.content = @"Ищу учителя для обучения игры на гитаре в до мажоре";
    [students addObject:sLesson];
    
    CLesson *tLesson = [[CLesson alloc] init];
    tLesson.fName = @"Андрей";
    tLesson.lName = @"Лукин";
    tLesson.time = @"01 : 20";
    tLesson.price = @"250 D";
    tLesson.content = @"Требуется помощь по решинию задач по физике. Тема: интерференция света";
    [students addObject:tLesson];
    

    
    
    NSMutableArray *teachers = [[NSMutableArray alloc] init];
    CLesson *foLesson = [[CLesson alloc] init];
    foLesson.fName = @"Индыков";
    foLesson.lName = @"Максим";
    foLesson.time = @"02 : 03";
    foLesson.price = @"300 D";
    foLesson.content = @"Требуется помощь по программированию сайта c использованием стандартных шаблонов";
    [teachers addObject:foLesson];
    
    proposals = [[NSMutableDictionary alloc] initWithObjectsAndKeys: students, @"students", teachers, @"teachers", nil];
    [lessonTableView setRowHeight:260];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(segmentController.selectedSegmentIndex == 0)
    {
        identifierCell = @"students";
        return [[proposals objectForKey:@"students"] count];
        
    }
    else
    {
        identifierCell = @"teachers";
        return [[proposals objectForKey:@"teachers"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIProfileTableViewCell *cell = (UIProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifierCell];
    
    //Если ячейки не существует
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UIProfileTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(segmentController.selectedSegmentIndex == 0)
        {
            [cell setContentLesson:[[proposals objectForKey:@"students"] objectAtIndex:indexPath.row]];
        }
        else
        {
            [cell setContentLesson:[[proposals objectForKey:@"teachers"] objectAtIndex:indexPath.row]];
        }
    }
    return cell;
}
/*
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"DetailView" sender:self];
}
 */

- (IBAction)changeMode:(UISegmentedControl *)sender
{
    [lessonTableView reloadData];
}
@end
