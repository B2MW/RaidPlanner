//
//  DetailViewController.m
//  RaidPlanner
//
//  Created by Bradley Walker on 10/22/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "DetailViewController.h"
#import <CoreData/CoreData.h>

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.adventurer.name;
}

-(Raid *)createRaid
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Raid"];
    request.predicate = [NSPredicate predicateWithFormat:@"date equals %@", self.datePicker.date];

    NSArray *results = [self.adventurer.managedObjectContext executeFetchRequest:request error:nil];

    if(results.count > 0)
    {
        NSLog(@"This raid exists");
        return results.firstObject;
    }
    Raid *raid = [NSEntityDescription insertNewObjectForEntityForName:@"Raid" inManagedObjectContext:self.adventurer.managedObjectContext];
    raid.date = self.datePicker.date;
    return raid;
}

@end
