//
//  DieLabel.h
//  Farkle
//
//  Created by Sherrie Jones on 1/21/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate
-(void)dieRolledWithValue:(int)value;
-(void)didChooseDie:(id)dieLabel;
@end

@interface DieLabel : UILabel

-(void)roll;
//-(void)dieWasTapped;

@property id<DieLabelDelegate> delegate;

@end
