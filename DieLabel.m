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
    int randomNumber = arc4random_uniform(6) + 1;
    self.text = [NSString stringWithFormat:@"%i", randomNumber];
    
}

-(IBAction)onTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"enter onTapped");
    self.backgroundColor = [UIColor greenColor];
    [self.delegate dieLabelWasTapped:self];
}

@end
