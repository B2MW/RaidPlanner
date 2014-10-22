//
//  MasterViewController.m
//  RaidPlanner
//
//  Created by Bradley Walker on 10/22/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Adventurer.h"
#import "Raid.h"

@interface MasterViewController () <UITableViewDataSource>
@property NSArray *adventurers;
@end

@implementation MasterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAdventurers];
}

-(void)loadAdventurers
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Adventurer"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.adventurers = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

- (IBAction)onAddNewAdventurer:(UITextField *)sender
{
    Adventurer *adventurer = [NSEntityDescription insertNewObjectForEntityForName:@"Adventurer" inManagedObjectContext:self.managedObjectContext];
    adventurer.name = sender.text;
    adventurer.species = [NSNumber numberWithInteger:arc4random_uniform(4)];
    [self.managedObjectContext save:nil];
    [sender resignFirstResponder];

    [self loadAdventurers];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.adventurers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Adventurer *adventurer = [self.adventurers objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.textLabel.text = adventurer.name;
    cell.detailTextLabel.text = @(adventurer.raids.count).description;

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    Adventurer *adventurer = [self.adventurers objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    DetailViewController *viewController = [segue destinationViewController];
    viewController.adventurer = adventurer;
}

-(IBAction)unwindDVC:(UIStoryboardSegue *)segue
{
    DetailViewController *viewController = [segue sourceViewController];
    Raid *raid = [viewController createRaid];
    [raid addAdventurersObject:viewController.adventurer];
    [self.managedObjectContext save:nil];
    [self loadAdventurers];

}

@end
