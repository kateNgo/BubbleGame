//
//  ViewController.m
//  MyGame2
//
//  Created by phuong on 1/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

#import "PlayViewController.h"
#import "BubbleImage.h"
#import "AppDelegate.h"

#define ARC4RANDOM_MAX 0x100000000

@interface PlayViewController()
    @property NSTimer * timer;
@end


@implementation PlayViewController

@synthesize  greenBalls, redBalls, blueBalls, pinkBalls, blackBalls;
@synthesize  scoreLabel, timerLabel, highScoreLabel;
@synthesize sentName;
@synthesize bubbleContainer, userDetailView;
@synthesize previousColorTouched ;
@synthesize countDownLabel;

int maxNumberOfGreenBalls,maxNumberOfRedBalls,maxNumberOfBlueBalls,maxNumberOfBlackBalls,maxNumberOfPinkBalls, numberOfBalls;
int seconds, countDownLeft;

- (void)viewDidLoad {
    [super viewDidLoad];
    bubbleContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    countDownLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}
// This method is to count down before startng game.
- (void)tick {
    countDownLeft--;
    countDownLabel.text = [NSString stringWithFormat:@"%d", countDownLeft];
    if (countDownLeft <= 0) {
        [self.timer invalidate];
        [countDownLabel removeFromSuperview];
        bubbleContainer.alpha = 1;
        userDetailView.alpha = 1;
        [self startGame];
    }
}
-(void) viewWillDisappear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.blockRotation=NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [self play];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void) viewDidDisappear:(BOOL)animated{
    [self gameOver];
}
-(void) startGame{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentUser.score =0;
    highScoreLabel.text = [NSString stringWithFormat:@"%.1f",appDelegate.currentUser.highestScore];
    scoreLabel.text = @"0.0";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(animate)
                                                userInfo:nil
                                                 repeats:YES];
     
}
-(void) animate{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (seconds < 0){
        [self gameOver];
        [self displayGameOverMessage];
        return;
    }
    if (seconds != appDelegate.currentUser.gameTimer){
        [self refreshAfterSecondGame];
    }
    [self displayBubbles];
    timerLabel.text = [NSString stringWithFormat:@"%i",seconds];
    seconds--;
}
-(void) play{
    [self settingValues];
    countDownLabel.text = @"3";
    [bubbleContainer addSubview:countDownLabel];
    bubbleContainer.alpha = 0.5;
    userDetailView.alpha = 0.5;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(tick)
                                                userInfo:nil
                                                 repeats:YES];
}
-(void) displayGameOverMessage{
    // display alert message
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Hello" message:@"Game Over" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionPlayAgain = [UIAlertAction actionWithTitle:@"Play again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self play];
    }];
    UIAlertAction *actionExit = [UIAlertAction actionWithTitle:@"Stop" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loadScoreboard];
    }];
    [alert addAction:actionPlayAgain];
    [alert addAction:actionExit];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) loadScoreboard{
    UIViewController *scoreBoard = [self.tabBarController.viewControllers objectAtIndex:1];
    [self.navigationController popViewControllerAnimated:NO];
    scoreBoard.tabBarController.selectedIndex = 1;
}
-(void) gameOver{
    [self.timer invalidate];
    self.timer = nil;
    // save current score if it is greater than highest score
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUser.score > appDelegate.currentUser.highestScore){
        appDelegate.currentUser.highestScore = appDelegate.currentUser.score;
    }
    // set score is zero
    appDelegate.currentUser.score = 0.0;
    // save current in database;
    [appDelegate saveCurrentUser];
}

-(void) displayBubbles{
    // numberBalls is number of bubbles to add the screen
    int numberBalls = (maxNumberOfRedBalls + maxNumberOfBlueBalls + maxNumberOfPinkBalls + maxNumberOfBlackBalls + maxNumberOfGreenBalls) - ((int)[blackBalls count] + (int)[blueBalls count]  + (int)[greenBalls count]  + (int)[redBalls count] + (int)[pinkBalls count]);
    int i = 0;
    while ( i < (numberBalls)){
        BubbleImage *bubble = [self createBall:[self generateColor] atPosition:[self generateBallPosition]];
        // add bubble to list of bubble have the same color
        [self addBubbleInToListWithBubble:bubble];
        i++;
    }
 }
/*
 This method is to add a bubble in to the list of balls have the same color
 */
-(void) addBubbleInToListWithBubble:(BubbleImage *) bubble{
    NSString *color = bubble.color;
    NSMutableArray *ballsHaveSameColor = [self getBallListWithColor:color];
    [ballsHaveSameColor addObject:bubble];
}
// the method return to array of bubbles have the same color
-(NSMutableArray *) getBallListWithColor:(NSString *) color{
    if ([color isEqualToString:@"Red"] ){
        return redBalls ;
    } else if ([color isEqualToString:@"Black"] ){
        return blackBalls;
    } else if ([color isEqualToString:@"Pink"] ){
        return pinkBalls ;
    } else if ([color isEqualToString:@"Green"] ){
        return greenBalls ;
    } else {
        return blueBalls;
    }
}
// create bubble with random color and random position in bubbleContainer
-(BubbleImage *) createBall:(NSString *)color atPosition:(CGPoint) position{
    BubbleImage *imageView = [[BubbleImage alloc] initWithColor:color atPoint:position];
    [imageView addTarget:self
               action:@selector(popHandler:)
     forControlEvents:UIControlEventTouchUpInside];
    [bubbleContainer  addSubview:imageView];
    return imageView;
}

-(void) removeBubbleAfterSecondGameWithAnimation:(BubbleImage *)bubble{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect r = CGRectMake(bubble.frame.origin.x ,bubbleContainer.frame.size.height,  bubble.frame.size.width,bubble.frame.size.height) ;
        bubble.frame = r;
        bubble.alpha = 1.0; bubble.alpha = 0.0;
    } completion:^(BOOL success) {
        if (success) {
            [bubble removeFromSuperview];
        }
    }];
}
-(void) removeTapedBubbleWithAnimation:(BubbleImage *)bubble{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect r = CGRectMake(bubble.frame.origin.x , bubble.frame.origin.y,  bubble.frame.size.width + 10,bubble.frame.size.height + 10) ;
        bubble.frame = r;
        bubble.alpha = 1.0; bubble.alpha = 0.0;
    } completion:^(BOOL success) {
        if (success) {
            [bubble removeFromSuperview];
        }
    }];
}

-(void) popHandler:(id) sender{
    BubbleImage *bubble = (BubbleImage*)sender;
    NSMutableArray *ballsHaveSameColor = [self getBallListWithColor:bubble.color];
    [ballsHaveSameColor removeObject:bubble];
    // remove buuble from superview with animation
    [self removeTapedBubbleWithAnimation:bubble];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // calculate point
    if ([previousColorTouched isEqualToString:bubble.color]){
        appDelegate.currentUser.score += (1.5* bubble.mark);
    }else{
        previousColorTouched = bubble.color;
        appDelegate.currentUser.score += bubble.mark;
    }
    scoreLabel.text = [NSString stringWithFormat:@"%.1f",appDelegate.currentUser.score];
}

-(void) refreshAfterSecondGame{
    // make a random number of balls to remove
    int removeRedBalls = ([redBalls count] == 0)? 0: arc4random() % ((unsigned)RAND_MAX) % [redBalls count] ;
    int removePinkBalls = ([pinkBalls count] == 0)? 0: arc4random() % ((unsigned)RAND_MAX) % [pinkBalls count];
    int removeGreenBalls = ([greenBalls count] == 0)? 0: arc4random() % ((unsigned)RAND_MAX) % [greenBalls count];
    int removeBlueBalls = ([blueBalls count] == 0)? 0: arc4random() % ((unsigned)RAND_MAX) % [blueBalls count];
    int removeBlackBalls = ([blackBalls count] == 0)? 0: arc4random() % ((unsigned)RAND_MAX) % [blackBalls count];
    // remove each bubble
    BubbleImage *bubble ;
    for ( int i = 0; i< removeRedBalls; i++){
        bubble = [redBalls lastObject];
        [self removeBubbleAfterSecondGameWithAnimation:bubble];
        [redBalls removeLastObject];
    }
    for ( int i = 0; i< removePinkBalls; i++){
        bubble = [pinkBalls lastObject];
        [self removeBubbleAfterSecondGameWithAnimation:bubble];
        [pinkBalls removeLastObject];
    }
    for ( int i = 0; i< removeGreenBalls; i++){
        bubble = [greenBalls lastObject];
        [self removeBubbleAfterSecondGameWithAnimation:bubble];
        [greenBalls removeLastObject];
    }
    for ( int i = 0; i< removeBlueBalls; i++){
        bubble = [blueBalls lastObject];
        [self removeBubbleAfterSecondGameWithAnimation:bubble];
        [blueBalls removeLastObject];
    }
    for ( int i = 0; i< removeBlackBalls; i++){
        bubble = [blackBalls lastObject];
        [self removeBubbleAfterSecondGameWithAnimation:bubble];
        [blackBalls removeLastObject];
    }
    
}
-(void) settingValues{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.blockRotation=YES;
    countDownLeft = 3;
    appDelegate.currentUser = [appDelegate getBubbleUserWithName:sentName];
    seconds = appDelegate.currentUser.gameTimer ;
    NSArray *bubbles = [[[[redBalls arrayByAddingObjectsFromArray:blueBalls] arrayByAddingObjectsFromArray:greenBalls] arrayByAddingObjectsFromArray:pinkBalls]  arrayByAddingObjectsFromArray:blackBalls];
    for ( BubbleImage *bubble in bubbles){
        [bubble removeFromSuperview];
    }
    maxNumberOfGreenBalls  =  appDelegate.currentUser.maxNumberOfBubbles * 15/100;
    maxNumberOfBlueBalls   =  appDelegate.currentUser.maxNumberOfBubbles * 10/100;
    maxNumberOfBlackBalls  =  appDelegate.currentUser.maxNumberOfBubbles * 5/100;
    maxNumberOfPinkBalls   =  appDelegate.currentUser.maxNumberOfBubbles * 30/100;
    maxNumberOfRedBalls    =  appDelegate.currentUser.maxNumberOfBubbles * 40/100;
    scoreLabel.text = @"0.0";
    timerLabel.text = [NSString stringWithFormat:@"%i",seconds];
    highScoreLabel.text = [NSString stringWithFormat:@"%.1f",appDelegate.currentUser.highestScore];
    blueBalls = [[NSMutableArray alloc] init];
    blackBalls = [[NSMutableArray alloc] init];
    pinkBalls = [[NSMutableArray alloc] init];
    redBalls = [[NSMutableArray alloc] init];
    greenBalls = [[NSMutableArray alloc] init];
}

-(CGPoint) generateBallPosition{
    while (true){
        CGFloat x = (CGFloat) (arc4random_uniform(bubbleContainer.frame.size.width - BUBBLE_WIDTH));
        CGFloat y = (CGFloat) (arc4random_uniform(bubbleContainer.frame.size.height - BUBBLE_HEIGHT));
        CGRect rect =  CGRectMake(x,y, BUBBLE_WIDTH,BUBBLE_HEIGHT);
        // check the new bubble is intersected with exist bubbles or not
        int i=0;
        BOOL intersection = NO;
        NSArray *balls = [[[[redBalls arrayByAddingObjectsFromArray:pinkBalls] arrayByAddingObjectsFromArray:blueBalls] arrayByAddingObjectsFromArray:greenBalls] arrayByAddingObjectsFromArray:blackBalls];
        while( (i<[balls count]) && (!intersection) ){
            if ( CGRectIntersectsRect(rect,[[balls objectAtIndex:i] frame] )){
                intersection = YES;
            }else{
                i++;
            }
        }
        if (!intersection){
            // check rect inside bubble container
            if (!CGRectContainsRect([bubbleContainer frame], rect)){
                return CGPointMake(x,y);
            }
        }
    }
}

-(NSString*) generateColor{
    while(true){
        // Get random value between 0 and 4
        int rand = arc4random() % 5;
        switch (rand) {
            case 0:
                // red color
                if ([redBalls count] < maxNumberOfRedBalls){
                    return  @"Red";
                }
                break;
            case 1:
                // pink color
                if ([pinkBalls count] < maxNumberOfPinkBalls){
                    return @"Pink";
                }
                break;
            case 2:
                //  green color
                if ([greenBalls count] < maxNumberOfGreenBalls){
                    return @"Green";
                }
                
            case 3:
                // blue color
                if ([blueBalls count] < maxNumberOfBlueBalls){
                    return @"Blue";
                }
                break;
            case 4:
                // black color
                if ([blackBalls count] < maxNumberOfBlackBalls){
                    return @"Black";
                }
                break;
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.timer invalidate];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentUser.score > appDelegate.currentUser.highestScore){
        appDelegate.currentUser.highestScore = appDelegate.currentUser.score;
        appDelegate.currentUser.score = 0.0;
    }
}

@end
