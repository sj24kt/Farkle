//
//  DieLabel.m
//  Farkle
//
//  Created by Sherrie Jones on 1/21/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

-(void)roll {
    int randomTimeInSeconds = arc4random_uniform(4) + 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(randomTimeInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int randomNumber = arc4random_uniform(6) + 1;
        NSLog(@"This dieLabel is: %d", randomNumber);

        [self.delegate dieRolledWithValue:randomNumber];
        self.text = [NSString stringWithFormat:@"%d", randomNumber];
    });
}

-(IBAction)onTapped:(UITapGestureRecognizer *)sender {
    self.backgroundColor = [UIColor greenColor];
    [self.delegate didChooseDie:self];

}

@end
