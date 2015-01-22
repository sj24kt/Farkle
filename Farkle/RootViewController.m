//
//  RootViewController.m
//  Farkle
//
//  Created by Sherrie Jones on 1/21/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"

@interface RootViewController () <DieLabelDelegate>
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labelCollection;
@property (strong, nonatomic) NSMutableArray *dice;
@property (strong, nonatomic) NSMutableArray *heldDice;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dice = [[NSMutableArray alloc] init];
    self.heldDice = [[NSMutableArray alloc] init];
}

// One of these two methods are called from DieDelegate in DieLabel.m
//-(void)dieFellOffTable {
//    self.dieLabel.text = @":/";
//}

-(void)dieRolledWithValue:(int)value {
    NSLog(@"Hi! I'm the viewController and the die told me it rolled a: %d", value);
    //self.delegate = [NSString stringWithFormat:@"%d",value];
}
// end of custom delegate

- (IBAction)onRollButtonPressed:(UIButton *)sender {
    // set the delegate properties of all the DieLabels
    DieLabel *dieLabel = [[DieLabel alloc]init];
    dieLabel.delegate = self;

    if (![self.heldDice containsObject:dieLabel]) {
        // Fast Enumeration = iterates over everything in an collection
        for (dieLabel in self.labelCollection) {
            // executes once for all six die being rolled
            [dieLabel roll];
            [self.dice addObject:dieLabel];
        }
    }

}

-(void)didChooseDie:(id)dieLabel {
    DieLabel *label = (DieLabel *)dieLabel;
    label.backgroundColor = [UIColor yellowColor];
    [self.heldDice addObject:label];
    NSLog(@"Held die: %@", label);
}

// X 1. Begin by rolling all 6 dice
// 2. Scoring dice must be set aside
//      a. (1's, 5's, 3(1's), 1-6, 3 pair, 6 identical)
//      b. 3 of any number times 100 scores (3-2's=200, 3-3's=300, 3-4's=400, 3-5's=500, 3-6's=600)
//      c. 3 of 1's == 1,000 point
//      and bank score for that turn
// 3. Continue in turn to hit ROLL only use remaining unscored die.
// 4. As long as remaining die produce points, can ROLL again
// 5. Any time all 6 die produce point, can roll again on same turn.
// 6. Once points are banked/recorded they cannot be lost.
// 7. No scoring dice = "farkles" and lose turn.
// 8. Play to 5,000+ points












@end
