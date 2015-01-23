//
//  RootViewController.m
//  Farkle Renew
//
//  Created by Sherrie Jones on 1/21/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"

@interface RootViewController () <DieLabelDelegate>
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSMutableArray *labelCollection;
@property (strong, nonatomic) NSMutableArray *dice;
@property (strong, nonatomic) NSMutableArray *tappedDice;

@property (weak, nonatomic) IBOutlet DieLabel *dieOne;
@property (weak, nonatomic) IBOutlet DieLabel *dieTwo;
@property (weak, nonatomic) IBOutlet DieLabel *dieThree;
@property (weak, nonatomic) IBOutlet DieLabel *dieFour;
@property (weak, nonatomic) IBOutlet DieLabel *dieFive;
@property (weak, nonatomic) IBOutlet DieLabel *dieSix;

@property int round;
@property int playerScore;
@property int player;
@property int bank;
@property int score;
@property int newScore;

@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentScoreLabel;

@property int oneScore;
@property int twoScore;
@property int threeScore;
@property int fourScore;
@property int fiveScore;
@property int sixScore;

@property NSMutableArray *ones;
@property NSMutableArray *twos;
@property NSMutableArray *threes;
@property NSMutableArray *fours;
@property NSMutableArray *fives;
@property NSMutableArray *sixes;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;

@property BOOL isPlayerTurn;
@property BOOL isFinalRound;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // set the delegate properties of all the DieLabels
    DieLabel *die = [[DieLabel alloc]init];
    die.delegate = self;

    [self setupDice];
    self.isPlayerTurn = YES;
    self.player = 1;
    self.playerLabel.text = [NSString stringWithFormat:@"Player:  %i", self.player];

    self.round = 0;
    self.roundLabel.text = [NSString stringWithFormat:@"Round:  %i",self.round];
//    self.playerScore = 0;
//    self.playerScoreLabel.text = [NSString stringWithFormat:@"Score: %i", self.playerScore];

    self.score = 0;
    self.currentScoreLabel.text = [NSString stringWithFormat:@"Score:  %i", self.score];

    self.bank = 0;
    self.bankScoreLabel.text = [NSString stringWithFormat:@"Bank:  %i", self.bank];

    self.tappedDice = [[NSMutableArray alloc] init];
}

-(void)setupDice {
    self.tappedDice = [NSMutableArray array];
    for (DieLabel *die in self.labelCollection) {
        die.delegate = self;
        die.isSelected = NO;
    }
}

//-(void)dieRolledWithValue:(int)value {
//    NSLog(@"Hi! I'm the viewController and the die told me it rolled a: %d", value);
//    //self.delegate = [NSString stringWithFormat:@"%d",value];
//}
//// end of custom delegate

- (IBAction)onRollButtonPressed:(UIButton *)sender {

    //if (![self.tappedDice containsObject:self.labelCollection]) {
        //Start first round
        if (self.round == 0) {
            self.round += 1;
            self.roundLabel.text = [NSString stringWithFormat:@"Round: %i",self.round];
            // Fast Enumeration = iterates over everything in an collection
            for (DieLabel *die in self.labelCollection) {
                // executes once for all six die being rolled
                [die roll];
                [self.dice addObject:die];
                NSLog(@"Roll 1: %@",die.text);
                //NSLog(@"add die to collection: %@", die);
            }
        } else if (self.round == 1) {
            //Start second round
            self.roundLabel.text = [NSString stringWithFormat:@"Round %i",self.round];
            self.rollButton.enabled = NO;

            for (DieLabel *die in self.dice) {
                [die roll];
                NSLog(@"Roll 2: %@",die.text);
            }
        }
    //}
}

-(void)dieLabelWasTapped:(DieLabel *)die {
    // if a die is tapped remove from tappedDice array & add to labelCollection & vice versa
    if (die.isSelected == YES) {
        [self.tappedDice removeObject:die];
        [self.labelCollection addObject:die];
        die.backgroundColor = [UIColor yellowColor];
        NSLog(@"tapped die: %@", die);
    } else {
        [self.labelCollection removeObject:die];
        [self.tappedDice addObject:die];
        die.backgroundColor = [UIColor blueColor];
        die.textColor = [UIColor whiteColor];
    }

    // add up score for tapped dice
    [self countSelected:self.tappedDice];

    // total score of points for roll
    [self scoreRoll];

    self.currentScoreLabel.text = [NSString stringWithFormat:@"Score:  %i",self.score];
    if (self.round == 1) {
        self.bank = self.score;
        self.bankScoreLabel.text = [NSString stringWithFormat:@"Bank:  %i",self.bank];
    }
    die.isSelected = !die.isSelected;
}

-(void) resetScore {
    // reset current score to zero
    self.score = 0;
    self.currentScoreLabel.text = [NSString stringWithFormat:@"Score:  %i", self.score];

    self.oneScore = 0;
    self.twoScore = 0;
    self.threeScore = 0;
    self.fourScore = 0;
    self.fiveScore = 0;
    self.sixScore = 0;
}

-(void)countSelected:(NSArray *)array
{
    [self resetDiceCount];

    // count the number of dies for each die number and store in array
    for (DieLabel *die in array)
    {
        if ([die.text intValue] == 1) {
            [self.ones addObject:die];
        } else if ([die.text intValue] == 2) {
            [self.twos addObject:die];
        } else if ([die.text intValue] == 3) {
            [self.threes addObject:die];
        }  else if ([die.text intValue] == 4) {
            [self.fours addObject:die];
        }else if ([die.text intValue] == 5) {
            [self.fives addObject:die];
        } else if ([die.text intValue] == 6) {
            [self.sixes addObject:die];
        }
    }
}

-(void) resetDiceCount {
    // reset numbers array to zero
    self.ones = [NSMutableArray array];
    self.twos = [NSMutableArray array];
    self.threes = [NSMutableArray array];
    self.fours = [NSMutableArray array];
    self.fives = [NSMutableArray array];
    self.sixes = [NSMutableArray array];
}

-(void)scoreRoll {
    // Scores for multiples of ones
    if (self.ones.count == 1) {
        self.oneScore = 100;
    } else if (self.ones.count == 2) {
        self.oneScore = 200;
    } else if (self.ones.count == 3) {
        self.oneScore = 1000;
    } else if (self.ones.count == 4) {
        self.oneScore = 1100;
    } else if (self.ones.count == 5) {
        self.oneScore = 1200;
    } else if (self.ones.count == 6) {
        self.oneScore = 2000;
    }

    // Score for 3 twos
    if (self.twos.count == 3) {
        self.twoScore = 200;
    }

    // Score for 3 threes
    if (self.threes.count == 3) {
        self.threeScore = 300;
    }

    // Score for 3 fours
    if (self.fours.count == 3) {
        self.fourScore = 400;
    }

    // Scores for multiples of fives
    if (self.fives.count == 1) {
        self.fiveScore = 50;
    } else if (self.fives.count == 2) {
        self.fiveScore = 100;
    } else if (self.fives.count == 3) {
        self.fiveScore = 500;
    } else if (self.fives.count == 4) {
        self.fiveScore = 550;
    } else if (self.fives.count == 5) {
        self.fiveScore = 600;
    } else if (self.fives.count == 6) {
        self.fiveScore = 1000;
    }

    // Score for 3 sixes
    if (self.sixes.count == 3) {
        self.sixScore = 600;
    }

    // Total score for roll
    self.score = self.oneScore + self.twoScore + self.threeScore + self.fourScore + self.fiveScore + self.sixScore;
    NSLog(@"Total Score %i", self.score);

    [self resetDiceCount];
}

-(void)changePlayer {
    if (self.isPlayerTurn) {
        self.playerScore += self.score;
        self.playerScoreLabel.text = [NSString stringWithFormat:@"Score: %i", self.playerScore];
        //self.player.textColor = [UIColor blackColor];
    }

    self.isPlayerTurn = !self.isPlayerTurn;
    self.round = 0;
    //[self resetScore];
    self.bank = 0;
    self.bankScoreLabel.text = @"0";
    [self setupDice];
    for (DieLabel *die in self.dice) {
        die.backgroundColor = [UIColor grayColor];
        die.text = @"";
    }

    self.rollButton.enabled = YES;

    //[self checkGameOver];
}

- (IBAction)onEndTurnButtonPressed:(UIButton *)sender {


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
