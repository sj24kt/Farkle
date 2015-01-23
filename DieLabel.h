//
//  DieLabel.h
//  Farkle
//
//  Created by Sherrie Jones on 1/21/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate
//-(void)dieRolledWithValue:(int)value;
-(void)dieLabelWasTapped:(id)sender;
@end

@interface DieLabel : UILabel

@property id<DieLabelDelegate> delegate;
@property BOOL isSelected;

-(void)roll;


@end
