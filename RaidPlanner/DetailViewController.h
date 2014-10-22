//
//  DetailViewController.h
//  RaidPlanner
//
//  Created by Bradley Walker on 10/22/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Adventurer.h"
#import "Raid.h"


@interface DetailViewController : UIViewController

@property (strong, nonatomic) Adventurer *adventurer;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

-(Raid *)createRaid;

@end

